import 'package:fischtracker/src/common_widgets/async_value_widget.dart';
import 'package:fischtracker/src/features/cats/data/cats_repository.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/cats/presentation/cat_jobs_screen/cat_jobs_list.dart';
import 'package:fischtracker/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CatJobsScreen extends ConsumerWidget {
  const CatJobsScreen({super.key, required this.catId});

  final CatID catId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catAsync = ref.watch(catStreamProvider(catId));
    return ScaffoldAsyncValueWidget<Cat>(
      value: catAsync,
      data: (cat) => CatJobsPageContents(cat: cat),
    );
  }
}

class CatJobsPageContents extends StatelessWidget {
  const CatJobsPageContents({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat.name),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.goNamed(
              AppRoute.editCat.name,
              params: {'cid': cat.id},
              extra: cat,
            ),
          ),
        ],
      ),
      body: CatJobsList(cat: cat),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.goNamed(
          AppRoute.addJobForCat.name,
          params: {'cid': cat.id},
          extra: cat,
        ),
      ),
    );
  }
}
