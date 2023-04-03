import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';

class EntriesListTileModel {
  const EntriesListTileModel({
    this.isHeader = false,
    this.date,
    this.duration,
    this.entry,
    this.job,
  });
  final bool isHeader;
  final DateTime? date;
  final Duration? duration;
  final Entry? entry;
  final Job? job;
}
