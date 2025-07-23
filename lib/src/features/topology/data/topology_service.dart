import 'package:fischtracker/src/features/cats/data/cats_repository.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/topology/domain/cat_jobs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/authentication/domain/app_user.dart';
import 'package:fischtracker/src/features/jobs/data/jobs_repository.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';

part 'topology_service.g.dart';

class CatsJobsService {
  CatsJobsService({required this.catsRepository, required this.jobsRepository});
  final CatsRepository catsRepository;
  final JobsRepository jobsRepository;

  /// combine List<Cat>, List<Job> into List<CatJobs>
  Stream<List<CatJobs>> catsJobsStream(UserID uid) =>
      CombineLatestStream.combine2(
        catsRepository.watchCats(uid: uid),
        jobsRepository.watchJobs(uid: uid),
        _catsJobsCombiner,
      );

  static List<CatJobs> _catsJobsCombiner(List<Cat> cats, List<Job> jobs) {
    return cats.map((cat) {
      final catjobs = jobs.where((job) => cat.id == job.catId).toList();
      return CatJobs(cat, catjobs);
    }).toList();
  }
}

@riverpod
CatsJobsService catsJobsService(Ref ref) {
  return CatsJobsService(
    catsRepository: ref.watch(catsRepositoryProvider),
    jobsRepository: ref.watch(jobsRepositoryProvider),
  );
}

@riverpod
Stream<List<CatJobs>> catsJobsStream(Ref ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching entries');
  }
  final catJobsService = ref.watch(catsJobsServiceProvider);
  return catJobsService.catsJobsStream(user.uid);
}
