import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/cats/data/cats_repository.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/jobs/data/jobs_repository.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:fischtracker/src/features/topology/presentation/delete_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'topo_screen_controller.g.dart';

@riverpod
class TopoScreenController extends _$TopoScreenController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> deleteCat(Cat cat, List<Job> jobs) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }

    if (jobs.isNotEmpty) {
      state = AsyncValue.error(
          DeleteException(
            title: 'Category not empty',
            description: 'Delete all jobs first',
          ),
          StackTrace.current);
    }

    final repository = ref.read(catsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => repository.deleteCat(uid: currentUser.uid, catId: cat.id));
  }

  // TODO: warn about entries
  Future<void> deleteJob(Job job) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }

    final repository = ref.read(jobsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => repository.deleteJob(uid: currentUser.uid, jobId: job.id));
  }
}
