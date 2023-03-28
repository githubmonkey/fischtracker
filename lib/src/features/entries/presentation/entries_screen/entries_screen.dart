import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:fischtracker/src/constants/strings.dart';
import 'package:fischtracker/src/features/entries/data/entries_repository.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/entries/presentation/entries_screen/entries_screen_controller.dart';
import 'package:fischtracker/src/features/entries/presentation/entries_screen/entry_list_item.dart';
import 'package:fischtracker/src/routing/app_router.dart';
import 'package:fischtracker/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EntriesScreen extends StatelessWidget {
  const EntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.entries),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(
            entriesScreenControllerProvider,
            (_, state) => state.showAlertDialogOnError(context),
          );
          final entriesQuery = ref.watch(entriesQueryProvider);
          return FirestoreListView<Entry>(
            query: entriesQuery,
            itemBuilder: (context, doc) {
              final entry = doc.data();
              return DismissibleEntryListItem(
                dismissibleKey: Key('entry-${entry.id}'),
                entry: entry,
                onDismissed: () => ref
                    .read(entriesScreenControllerProvider.notifier)
                    .deleteEntry(entry),
                onTap: () => context.goNamed(
                  AppRoute.entry.name,
                  params: {'eid': entry.id},
                  extra: entry,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
