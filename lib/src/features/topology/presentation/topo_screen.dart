import 'package:fischtracker/src/common_widgets/empty_content.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:fischtracker/src/features/topology/data/topology_service.dart';
import 'package:fischtracker/src/features/topology/presentation/topo_screen_controller.dart';
import 'package:fischtracker/src/localization/string_hardcoded.dart';
import 'package:fischtracker/src/routing/app_router.dart';
import 'package:fischtracker/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TopoScreen extends StatelessWidget {
  const TopoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Topology".hardcoded),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () => context.goNamed(AppRoute.addCat.name),
            icon: const Icon(Icons.add),
            label: Text('New Category'.hardcoded),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(
            topoScreenControllerProvider,
            (_, state) => state.showAlertDialogOnError(context),
          );

          final catsJobsStream = ref.watch(catsJobsStreamProvider);

          return catsJobsStream.when(
            data: (items) => ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) =>
                  CatListTile(cat: items[index].cat, jobs: items[index].jobs),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const EmptyContent(
              title: 'Something went wrong',
              message: 'Can\'t load items right now',
            ),
          );
        },
      ),
    );
  }
}

// Each cat tile is a card with cat name and a list of jobs
class CatListTile extends ConsumerWidget {
  const CatListTile({super.key, required this.cat, required this.jobs});

  final Cat cat;
  final List<Job> jobs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      child: Column(
        children: [
          Dismissible(
            key: Key('topo-cat-${cat.id}'),
            background:
                Container(color: Theme.of(context).colorScheme.tertiary),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => ref
                .read(topoScreenControllerProvider.notifier)
                .deleteCat(cat, jobs),
            child: Row(children: [
              Expanded(
                child: ListTile(
                  title: Text(cat.name),
                  onTap: () => context.goNamed(
                    AppRoute.editCat.name,
                    params: {'cid': cat.id},
                    extra: cat,
                  ),
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.add),
                label: Text('New Job'.hardcoded),
                onPressed: () => context
                    .goNamed(AppRoute.addJob.name, params: {'cid': cat.id}),
              ),
            ]),
          ),
          if (jobs.isNotEmpty)
            Divider(thickness: 0.5, color: Theme.of(context).dividerColor),
          ...jobs
              .map((job) => Dismissible(
                    key: Key('topo-job-${job.id}'),
                    background: Container(
                        color: Theme.of(context).colorScheme.secondary),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) => ref
                        .read(topoScreenControllerProvider.notifier)
                        .deleteJob(job),
                    child: ListTile(
                      leading: const Icon(Icons.work_history),
                      title: Text(job.name),
                      onTap: () => context.goNamed(
                        AppRoute.editJob.name,
                        params: {'cid': job.catId, 'jid': job.id},
                        extra: job,
                      ),
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
