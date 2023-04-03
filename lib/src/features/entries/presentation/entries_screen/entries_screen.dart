import 'package:fischtracker/src/common_widgets/list_items_builder.dart';
import 'package:fischtracker/src/constants/strings.dart';
import 'package:fischtracker/src/features/entries/application/entries_service.dart';
import 'package:fischtracker/src/features/entries/domain/entries_list_tile_model.dart';
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
      body: Consumer(builder: (context, ref, child) {
        ref.listen<AsyncValue>(
          entriesScreenControllerProvider,
          (_, state) => state.showAlertDialogOnError(context),
        );

        final entriesTileModelStream =
            ref.watch(entriesTileModelStreamProvider);
        return ListItemsBuilder<EntriesListTileModel>(
            data: entriesTileModelStream,
            itemBuilder: (context, model) => model.isHeader
                ? EntryListItem(model: model, onTap: null)
                : DismissibleEntryListItem(
                    dismissibleKey: Key('entry-${model.entry!.id}'),
                    model: model,
                    onDismissed: () => ref
                        .read(entriesScreenControllerProvider.notifier)
                        .deleteEntry(model.entry!),
                    onTap: () => context.goNamed(AppRoute.editEntry.name,
                        params: {'eid': model.entry!.id}, extra: model.entry!),
                  ));
      }),
    );
  }
}
