import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:fischtracker/src/features/cats/data/cats_repository.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/jobs/data/jobs_repository.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:fischtracker/src/features/timers/presentation/timers_screen/timers_screen_controller.dart';
import 'package:fischtracker/src/localization/string_hardcoded.dart';
import 'package:fischtracker/src/utils/async_value_ui.dart';
import 'package:fischtracker/src/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimersScreen extends StatelessWidget {
  const TimersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Toggles".hardcoded)),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(
            timersScreenControllerProvider,
            (_, state) => state.showAlertDialogOnError(context),
          );

          final catsQuery = ref.watch(catsQueryProvider);
          return FirestoreListView<Cat>(
            query: catsQuery,
            itemBuilder: (context, doc) {
              final cat = doc.data();
              return CatJobsCard(key: Key('cat-${cat.id}'), cat: cat);
            },
          );
        },
      ),
    );
  }
}

class CatJobsCard extends StatelessWidget {
  const CatJobsCard({Key? key, required this.cat}) : super(key: key);
  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Consumer(builder: (context, ref, child) {
        final catJobsQuery = ref.watch(catJobsQueryProvider(cat.id));
        return Column(
          children: [
            Text(
              cat.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            FirestoreListView<Job>(
              shrinkWrap: true,
              query: catJobsQuery,
              itemBuilder: (context, doc) {
                final job = doc.data();
                return JobListTile(key: Key('job-${job.id}'), job: job);
              },
            ),
          ],
        );
      }),
    );
  }
}

class JobListTile extends ConsumerWidget {
  const JobListTile({Key? key, required this.job, this.onTap})
      : super(key: key);
  final Job job;
  final VoidCallback? onTap;

  String getLastEntryDetails(BuildContext context, Entry entry) {
    final startDate = Format.date(entry.start);
    final startTime = TimeOfDay.fromDateTime(entry.start).format(context);
    final endTime = entry.end == null
        ? 'ongoing'.hardcoded
        : TimeOfDay.fromDateTime(entry.end!).format(context);
    return '$startDate $startTime - $endTime';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
        value: job.isOpen,
        title: Text(job.name),
        subtitle: (job.lastEntry == null)
            ? null
            : Text(getLastEntryDetails(context, job.lastEntry!)),
        onChanged: (_) =>
            ref.read(timersScreenControllerProvider.notifier).onChange(job));
  }
}
