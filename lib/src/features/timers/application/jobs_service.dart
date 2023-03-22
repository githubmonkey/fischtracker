import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/authentication/domain/app_user.dart';
import 'package:fischtracker/src/features/cats/data/cats_repository.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/jobs/data/jobs_repository.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:fischtracker/src/features/timers/domain/cat_jobs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'jobs_service.g.dart';

class JobsService {
  JobsService({required this.catsRepository, required this.jobsRepository});

  final CatsRepository catsRepository;
  final JobsRepository jobsRepository;

  /// combine List<Cat>, List<Job> into List<CatJobs>
  Stream<List<CatJobs>> catJobsStream(UserID uid) =>
      CombineLatestStream.combine2(
        catsRepository.watchCats(uid: uid),
        jobsRepository.watchJobs(uid: uid),
        _catsJobsCombiner,
      );

  static List<CatJobs> _catsJobsCombiner(List<Cat> cats, List<Job> jobs) {
    return cats.map((cat) {
      final jobsforcat = jobs.where((job) => job.catId == cat.id).toList();
      return CatJobs(cat, jobsforcat);
    }).toList();
  }
}

@riverpod
JobsService jobsService(JobsServiceRef ref) {
  return JobsService(
    catsRepository: ref.watch(catsRepositoryProvider),
    jobsRepository: ref.watch(jobsRepositoryProvider),
  );
}

@riverpod
Stream<List<CatJobs>> catJobsStream(CatJobsStreamRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
   if (user == null) {
     throw AssertionError('User can\'t be null when fetching entries');
   }
   final jobsService = ref.watch(jobsServiceProvider);
   return jobsService.catJobsStream(user.uid);
}
