import 'dart:async';

import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/cats/data/cats_repository.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/jobs/data/jobs_repository.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:fischtracker/src/features/jobs/presentation/edit_job_screen/job_submit_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_job_screen_controller.g.dart';

@riverpod
class EditJobScreenController extends _$EditJobScreenController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<bool> submit({
    JobID? jobId,
    Job? oldJob,
    required String name,
    required CatID catId,
  }) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    // set loading state
    state = const AsyncLoading().copyWithPrevious(state);
    // check if name is already in use
    final repository = ref.read(jobsRepositoryProvider);
    final jobs = await repository.fetchJobs(uid: currentUser.uid);
    final allLowerCaseNames =
        jobs.map((job) => job.name.toLowerCase()).toList();
    // it's ok to use the same name as the old job
    if (oldJob != null) {
      allLowerCaseNames.remove(oldJob.name.toLowerCase());
    }
    // check if name is already used
    if (allLowerCaseNames.contains(name.toLowerCase())) {
      state = AsyncError(
          JobSubmitException(
            title: 'Name already used',
            description: 'Please choose a different job name',
          ),
          StackTrace.current);
      return false;
    }

    // check if CatID matches a valid category
    final catRepo = ref.read(catsRepositoryProvider);
    final cat = await catRepo.fetchCat(uid: currentUser.uid, catId: catId);

    if (cat == null) {
      state = AsyncError(
          JobSubmitException(
            title: 'Unknown category',
            description: 'Please choose a different category from the list',
          ),
          StackTrace.current);
      return false;
    }

    if (jobId != null) {
      // job previously existed; update
      final job = Job(id: jobId, name: name, catId: catId, catName: cat.name);
      state = await AsyncValue.guard(
        () => repository.updateJob(uid: currentUser.uid, job: job),
      );
    } else {
      // new job; create
      state = await AsyncValue.guard(
        () => repository.addJob(
            uid: currentUser.uid, name: name, catId: catId, catName: cat.name),
      );
    }
    return state.hasError == false;
  }
}
