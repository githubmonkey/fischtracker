import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/jobs/presentation/job_entries_screen/job_entries_list_controller.dart';
import 'package:fischtracker/src/localization/string_hardcoded.dart';
import 'package:fischtracker/src/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntryListItem extends ConsumerWidget {
  const EntryListItem({
    super.key,
    required this.entry,
    //required this.job,
    this.onTap,
  });

  final Entry entry;
  //final Job job;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _buildContents(context, ref),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context, WidgetRef ref) {
    final dayOfWeek = Format.dayOfWeek(entry.start);
    final startDate = Format.date(entry.start);
    final startTime = TimeOfDay.fromDateTime(entry.start).format(context);
    final endTime = entry.end == null
        ? 'ongoing'.hardcoded
        : TimeOfDay.fromDateTime(entry.end!).format(context);
    final durationFormatted = Format.hours(entry.durationInHours);

    final isOngoing = entry.end == null;
    final textStyle = Theme.of(context).textTheme.bodyLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text(
            dayOfWeek,
            style: const TextStyle(fontSize: 18.0, color: Colors.grey),
          ),
          const SizedBox(width: 15.0),
          Text(startDate, style: const TextStyle(fontSize: 18.0)),
          if (isOngoing) ...<Widget>[
            Expanded(child: Container()),
            ElevatedButton(
              onPressed: () => ref
                  .read(jobsEntriesListControllerProvider.notifier)
                  .closeOpenEntry(entry),
              child: const Text('stop'),
            ),
          ],
        ]),
        Row(
          children: <Widget>[
            Text('$startTime - $endTime',
                style: const TextStyle(fontSize: 16.0)),
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
            style: const TextStyle(fontSize: 12.0),
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
    required this.entry,
    this.onDismissed,
    this.onTap,
  });

  final Key dismissibleKey;
  final Entry entry;
  final VoidCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: dismissibleKey,
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed?.call(),
      child: EntryListItem(
        entry: entry,
        onTap: onTap,
      ),
    );
  }
}
