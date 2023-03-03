import 'dart:async';

import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/entries/data/entries_repository.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobsEntriesListController extends AutoDisposeAsyncNotifier<void> {
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

final jobsEntriesListControllerProvider =
    AutoDisposeAsyncNotifierProvider<JobsEntriesListController, void>(
        JobsEntriesListController.new);
