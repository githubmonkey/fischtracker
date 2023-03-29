import 'package:fischtracker/src/features/entries/domain/daily_entries_details.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/authentication/domain/app_user.dart';
import 'package:fischtracker/src/features/entries/data/entries_repository.dart';
import 'package:fischtracker/src/features/entries/domain/entries_list_tile_model.dart';
import 'package:fischtracker/src/features/entries/domain/entry_job.dart';
import 'package:fischtracker/src/features/jobs/data/jobs_repository.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';

part 'entries_service.g.dart';

// TODO: Clean up this code a bit more
class EntriesService {
  EntriesService(
      {required this.jobsRepository, required this.entriesRepository});
  final JobsRepository jobsRepository;
  final EntriesRepository entriesRepository;

  /// combine List<Job>, List<Entry> into List<EntryJob>
  Stream<List<EntryJob>> _allEntriesStream(UserID uid) =>
      CombineLatestStream.combine2(
        entriesRepository.watchEntries(uid: uid),
        jobsRepository.watchJobs(uid: uid),
        _entriesJobsCombiner,
      );

  static List<EntryJob> _entriesJobsCombiner(
      List<Entry> entries, List<Job> jobs) {
    return entries.map((entry) {
      final job = jobs.firstWhere((job) => job.id == entry.jobId);
      return EntryJob(entry, job);
    }).toList();
  }

  /// Output stream
  Stream<List<EntriesListTileModel>> entriesTileModelStream(UserID uid) =>
      _allEntriesStream(uid).map(_createModels);

  static List<EntriesListTileModel> _createModels(List<EntryJob> allEntries) {
    if (allEntries.isEmpty) {
      return [];
    }
    final allDailyEntriesDetails = DailyEntriesDetails.all(allEntries);

    return <EntriesListTileModel>[
      for (DailyEntriesDetails dailyEntriesDetails in allDailyEntriesDetails) ...[
        EntriesListTileModel(
          isHeader: true,
          date: dailyEntriesDetails.date,
          durationInHours: dailyEntriesDetails.duration,
        ),
        for (EntryJob entryDetails in dailyEntriesDetails.entries)
          EntriesListTileModel(
            entry: entryDetails.entry,
            job: entryDetails.job,
          ),
      ]
    ];
  }
}

@riverpod
EntriesService entriesService(EntriesServiceRef ref) {
  return EntriesService(
    jobsRepository: ref.watch(jobsRepositoryProvider),
    entriesRepository: ref.watch(entriesRepositoryProvider),
  );
}

@riverpod
Stream<List<EntriesListTileModel>> entriesTileModelStream(
    EntriesTileModelStreamRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching entries');
  }
  final entriesService = ref.watch(entriesServiceProvider);
  return entriesService.entriesTileModelStream(user.uid);
}
