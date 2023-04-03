import 'package:fischtracker/src/features/entries/domain/entry_job.dart';


/// Groups together all jobs/entries on a given day
class DailyEntriesDetails {
  DailyEntriesDetails({required this.date, required this.entries});
  final DateTime date;
  final List<EntryJob> entries;

  Duration get duration => entries
      .map((e) => e.entry.duration)
      .reduce((value, element) => value + element);

  /// splits all entries into separate groups by date
  static Map<DateTime, List<EntryJob>> _entriesByDate(List<EntryJob> entries) {
    final Map<DateTime, List<EntryJob>> map = {};
    for (final entryJob in entries) {
      final entryDayStart = DateTime(entryJob.entry.start.year,
          entryJob.entry.start.month, entryJob.entry.start.day);
      if (map[entryDayStart] == null) {
        map[entryDayStart] = [entryJob];
      } else {
        map[entryDayStart]!.add(entryJob);
      }
    }
    return map;
  }

  /// maps an unordered list of EntryJob into a list of DailyEntriesDetails with date information
  static List<DailyEntriesDetails> all(List<EntryJob> entries) {
    final byDate = _entriesByDate(entries);
    final List<DailyEntriesDetails> list = [];
    for (final pair in byDate.entries) {
      final date = pair.key;
      final entriesByDate = pair.value;
      list.add(DailyEntriesDetails(date: date, entries: entriesByDate));
    }
    return list.toList();
  }
}
