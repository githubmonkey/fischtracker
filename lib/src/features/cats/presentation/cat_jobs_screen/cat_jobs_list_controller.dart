import 'dart:async';

import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/jobs/data/jobs_repository.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cat_jobs_list_controller.g.dart';

@riverpod
class CatsJobsListController extends _$CatsJobsListController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> deleteJob(JobID jobId) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(jobsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repository.deleteJob(
          uid: currentUser.uid,
          jobId: jobId,
        ));
  }
}
