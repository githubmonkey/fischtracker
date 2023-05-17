import 'dart:async';

import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/entries/data/entries_repository.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timers_screen_controller.g.dart';

@riverpod
class TimersScreenController extends _$TimersScreenController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> onChange(Job job) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    final openEntriesForJob =
        ref.read(openEntriesStreamProvider(jobId: job.id));
    final isOpen = openEntriesForJob.value?.isNotEmpty ?? false;

    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(entriesRepositoryProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (isOpen) {
        // close this one and whatever else might be open
        // TODO: log if there is more than one still open
        repository.fetchOpenEntries(uid: currentUser.uid).then((entries) {
          for (var e in entries) {
            repository.updateEntry(
                uid: currentUser.uid, entry: e.copyWith(end: DateTime.now()));
          }
        });
      } else {
        // close all expect the one we are trying to open
        repository.fetchOpenEntries(uid: currentUser.uid).then((entries) {
          for (var e in entries) {
            if (e.jobId != job.id) {
              repository.updateEntry(
                  uid: currentUser.uid, entry: e.copyWith(end: DateTime.now()));
            }
          }
        });
        // open the one we are interested in
        repository.addEntry(
          uid: currentUser.uid,
          jobId: job.id,
          start: DateTime.now(),
          end: null,
          comment: "",
        );
      }
    });
  }

// first check if any open entries have to be closed, then open as requested
  Future<void> openEntry(JobID jobid) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(entriesRepositoryProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final entries = await repository.fetchOpenEntries(uid: currentUser.uid);
      for (var e in entries) {
        await repository.updateEntry(
            uid: currentUser.uid, entry: e.copyWith(end: DateTime.now()));
      }

      return repository.addEntry(
        uid: currentUser.uid,
        jobId: jobid,
        start: DateTime.now(),
        end: null,
        comment: "",
      );
    });
  }

  Future<void> closeEntries() async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(entriesRepositoryProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => repository.fetchOpenEntries(uid: currentUser.uid).then((entries) {
        for (var e in entries) {
          repository.updateEntry(
              uid: currentUser.uid, entry: e.copyWith(end: DateTime.now()));
        }
      }),
    );
  }

  Future<void> closeEntry(Entry entry) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(entriesRepositoryProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => repository.updateEntry(
        uid: currentUser.uid,
        entry: entry.copyWith(end: DateTime.now()),
      ),
    );
  }
}
