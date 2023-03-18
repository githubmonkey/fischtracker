import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/entries/data/entries_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/entries/domain/entry.dart';

part 'job_entries_list_controller.g.dart';

@riverpod
class JobsEntriesListController extends _$JobsEntriesListController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> deleteEntry(EntryID entryId) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(entriesRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => repository.deleteEntry(uid: currentUser.uid, entryId: entryId));
  }

  Future<void> closeOpenEntry(Entry entry) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    if (entry.end != null) {
      throw AssertionError('Can\'t close an already closed entry');
    }

    final repository = ref.read(entriesRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repository.updateEntry(
        uid: currentUser.uid, entry: entry.copyWith(end: DateTime.now())));
  }
}
