import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:fischtracker/src/features/cats/data/cats_repository.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/jobs/data/jobs_repository.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:fischtracker/src/features/timers/presentation/timers_screen/timers_screen_controller.dart';
import 'package:fischtracker/src/localization/string_hardcoded.dart';
import 'package:fischtracker/src/utils/async_value_ui.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(job.name),
      trailing: StartStopButton(job: job),
      onTap: onTap,
    );
  }
}

class StartStopButton extends ConsumerWidget {
  const StartStopButton({Key? key, required this.job}) : super(key: key);
  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (job.isOpen) {
      return ElevatedButton(
        onPressed: () => ref
            .read(timersScreenControllerProvider.notifier)
            .closeEntry(job.lastEntry!),
        child: const Text('stop'),
      );
    } else {
      return ElevatedButton(
        onPressed: (() {
          ref.read(timersScreenControllerProvider.notifier).closeEntries();
          ref.read(timersScreenControllerProvider.notifier).openEntry(job.id);
        }),
        child: const Text('start'),
      );
    }
  }
}
