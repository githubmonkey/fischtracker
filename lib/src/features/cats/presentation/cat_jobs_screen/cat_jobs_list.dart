import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:fischtracker/src/common_widgets/empty_content.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/cats/presentation/cat_jobs_screen/cat_jobs_list_controller.dart';
import 'package:fischtracker/src/features/cats/presentation/cat_jobs_screen/job_list_item.dart';
import 'package:fischtracker/src/features/jobs/data/jobs_repository.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:fischtracker/src/routing/app_router.dart';
import 'package:fischtracker/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CatJobsList extends ConsumerWidget {
  const CatJobsList({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      catsJobsListControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final catJobsQuery = ref.watch(catJobsQueryProvider(cat.id));
    return FirestoreListView<Job>(
      query: catJobsQuery,
      itemBuilder: (context, doc) {
        final job = doc.data();
        return DismissibleJobListItem(
          dismissibleKey: Key('job-${job.id}'),
          job: job,
          cat: cat,
          onDismissed: () => ref
              .read(catsJobsListControllerProvider.notifier)
              .deleteJob(job.id),
          onTap: () => context.goNamed(
            AppRoute.job.name,
            pathParameters: {'cid': cat.id, 'jid': job.id},
            extra: job,
          ),
        );
      },
      emptyBuilder: (_) =>
          const EmptyContent(message: 'Add some jobs to this category.'),
    );
  }
}
