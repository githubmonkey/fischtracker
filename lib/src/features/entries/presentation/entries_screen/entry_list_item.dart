import 'package:fischtracker/src/features/entries/domain/entries_list_tile_model.dart';
import 'package:fischtracker/src/features/jobs/presentation/job_entries_screen/job_entries_list_controller.dart';
import 'package:fischtracker/src/localization/string_hardcoded.dart';
import 'package:fischtracker/src/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntryListItem extends ConsumerWidget {
  const EntryListItem({
    super.key,
    required this.model,
    //required this.job,
    this.onTap,
  });

  final EntriesListTileModel model;

  //final Job job;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (model.isHeader)
      return _buildHeader(context, ref);
    else
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: _buildContents(context, ref),
        ),
      );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    final texttheme = Theme.of(context).textTheme.bodyLarge;
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(Format.longdate(model.date!), style: texttheme),
          Text(Format.hours(model.durationInHours!),
              style: texttheme, textAlign: TextAlign.right),
        ],
      ),
    );
  }

  Widget _buildContents(BuildContext context, WidgetRef ref) {
    final entry = model.entry!;
    final startTime = TimeOfDay.fromDateTime(entry.start).format(context);
    final endTime = entry.end == null
        ? 'ongoing'.hardcoded
        : TimeOfDay.fromDateTime(entry.end!).format(context);
    final durationFormatted = Format.hours(entry.durationInHours);

    final isOngoing = entry.end == null;
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.job!.name, style: textStyle),
                Text('$startTime - $endTime', style: textStyle),
              ],
            ),
            if (isOngoing) ...<Widget>[
              Expanded(child: Container()),
              ElevatedButton(
                onPressed: () => ref
                    .read(jobsEntriesListControllerProvider.notifier)
                    .closeOpenEntry(entry),
                child: const Text('stop'),
              ),
            ],
            Expanded(child: Container()),
            Text(
              durationFormatted,
              style: textStyle!.copyWith(
                  color: textStyle.color!.withOpacity(isOngoing ? 0.5 : 1)),
            ),
          ],
        ),
        if (entry.comment.isNotEmpty)
          Text(
            entry.comment,
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
      ],
    );
  }
}

class DismissibleEntryListItem extends StatelessWidget {
  const DismissibleEntryListItem({
    super.key,
    required this.dismissibleKey,
    required this.model,
    this.onDismissed,
    this.onTap,
  });

  final Key dismissibleKey;
  final EntriesListTileModel model;
  final VoidCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (model.isHeader) {
      return EntryListItem(
        model: model,
        onTap: null,
      );
    } else
      return Dismissible(
        background: Container(color: Colors.red),
        key: dismissibleKey,
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => onDismissed?.call(),
        child: EntryListItem(
          model: model,
          onTap: onTap,
        ),
      );
  }
}
