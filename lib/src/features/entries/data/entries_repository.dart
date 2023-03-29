import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/authentication/domain/app_user.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entries_repository.g.dart';

class EntriesRepository {
  const EntriesRepository(this._firestore);

  final FirebaseFirestore _firestore;

  static String entryPath(String uid, String entryId) =>
      'users/$uid/entries/$entryId';

  static String entriesPath(String uid) => 'users/$uid/entries';

  static String jobPath(String uid, String jobId) => 'users/$uid/jobs/$jobId';

  // create
  // Add a new entry and update the matching job object
  Future<void> addEntry({
    required UserID uid,
    required JobID jobId,
    required DateTime start,
    required DateTime? end,
    required String comment,
  }) {
    final batch = _firestore.batch();

    final entryref = _firestore.collection(entriesPath(uid)).doc();
    final jobref = _firestore.doc(jobPath(uid, jobId));

    batch.set(entryref, {
      'id': entryref.id,
      'jobId': jobId,
      'start': start.millisecondsSinceEpoch,
      'end': end?.millisecondsSinceEpoch,
      'comment': comment,
    });

    batch.update(jobref, {
      'lastEntryId': entryref.id,
      'lastEntryStart': start.millisecondsSinceEpoch,
      'lastEntryEnd': end?.millisecondsSinceEpoch,
      'lastEntryComment': comment,
    });

    return batch.commit();
  }

  // update
  // This one also updates lastentry in the matching job object
  Future<void> updateLastEntry({required UserID uid, required Entry entry}) {
    final batch = _firestore.batch();
    final entryref = _firestore.doc(entryPath(uid, entry.id));
    final jobref = _firestore.doc(jobPath(uid, entry.jobId));

    batch.update(entryref, entry.toMap());
    batch.update(jobref, {
      'lastEntryId': entry.id,
      'lastEntryStart': entry.start.millisecondsSinceEpoch,
      'lastEntryEnd': entry.end?.millisecondsSinceEpoch,
      'lastEntryComment': entry.comment,
    });

    return batch.commit();
  }

  Future<void> updateEntry({
    required UserID uid,
    required Entry entry,
  }) =>
      _firestore.doc(entryPath(uid, entry.id)).update(entry.toMap());

  // delete
  Future<void> deleteEntry({required UserID uid, required EntryID entryId}) =>
      _firestore.doc(entryPath(uid, entryId)).delete();

  // read
  Stream<List<Entry>> watchEntries({required UserID uid, JobID? jobId}) =>
      queryEntries(uid: uid, jobId: jobId)
          .orderBy('start', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Stream<List<Entry>> watchOpenEntries({required UserID uid}) =>
      queryEntries(uid: uid)
          .orderBy('start', descending: true)
          .where('end', isNull: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Entry> queryEntries({required UserID uid, JobID? jobId}) {
    Query<Entry> query =
        _firestore.collection(entriesPath(uid)).withConverter<Entry>(
              fromFirestore: (snapshot, _) =>
                  Entry.fromMap(snapshot.data()!, snapshot.id),
              toFirestore: (entry, _) => entry.toMap(),
            );
    if (jobId != null) {
      query = query.where('jobId', isEqualTo: jobId);
    }
    return query;
  }

  Future<List<Entry>> fetchOpenEntries({required UserID uid}) async {
    Query<Entry> query = _firestore
        .collection(entriesPath(uid))
        .withConverter<Entry>(
            fromFirestore: (snapshot, _) =>
                Entry.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (entry, _) => entry.toMap())
        .where('end', isNull: true);

    final entries = await query.get();
    return entries.docs.map((doc) => doc.data()).toList();
  }
}

@Riverpod(keepAlive: true)
EntriesRepository entriesRepository(EntriesRepositoryRef ref) {
  return EntriesRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Entry> entriesQuery(EntriesQueryRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching jobs');
  }
  final repository = ref.watch(entriesRepositoryProvider);
  return repository.queryEntries(uid: user.uid);
}

// TODO: make jobId nullable to combine with above?
@riverpod
Query<Entry> jobEntriesQuery(JobEntriesQueryRef ref, {required JobID jobId}) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching jobs');
  }
  final repository = ref.watch(entriesRepositoryProvider);
  return repository.queryEntries(uid: user.uid, jobId: jobId);
}

@riverpod
Stream<List<Entry>> openEntriesStream(OpenEntriesStreamRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching jobs');
  }
  final repository = ref.watch(entriesRepositoryProvider);
  return repository.watchOpenEntries(uid: user.uid);
}
