import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:fischtracker/src/constants/strings.dart';
import 'package:fischtracker/src/features/cats/data/cats_repository.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/cats/presentation/cats_screen/cats_screen_controller.dart';
import 'package:fischtracker/src/routing/app_router.dart';
import 'package:fischtracker/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CatsScreen extends StatelessWidget {
  const CatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.cats),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.goNamed(AppRoute.addCat.name),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(
            catsScreenControllerProvider,
            (_, state) => state.showAlertDialogOnError(context),
          );
          final catsQuery = ref.watch(catsQueryProvider);
          return FirestoreListView<Cat>(
            query: catsQuery,
            itemBuilder: (context, doc) {
              final cat = doc.data();
              return Dismissible(
                key: Key('cat-${cat.id}'),
                background: Container(color: Colors.red),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) => ref
                    .read(catsScreenControllerProvider.notifier)
                    .deleteCat(cat),
                child: CatListTile(
                  cat: cat,
                  onTap: () => context.goNamed(
                    AppRoute.cat.name,
                    params: {'cid': cat.id},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CatListTile extends StatelessWidget {
  const CatListTile({Key? key, required this.cat, this.onTap})
      : super(key: key);
  final Cat cat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cat.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
