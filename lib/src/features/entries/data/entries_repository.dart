import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/authentication/domain/app_user.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Future<void> addEntry({
    required UserID uid,
    required JobID jobId,
    required DateTime start,
    required DateTime? end,
    required String comment,
  }) =>
      _firestore.collection(entriesPath(uid)).add({
        'jobId': jobId,
        'start': start.millisecondsSinceEpoch,
        'end': end?.millisecondsSinceEpoch,
        'comment': comment,
      });

  // update
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

  Stream<List<Entry>> watchOpenEntries({required UserID uid, JobID? jobId}) =>
      queryEntries(uid: uid, jobId: jobId)
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
    // TODO: this seems to prevent the job-entries list from being updated
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
EntriesRepository entriesRepository(Ref ref) {
  return EntriesRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Entry> entriesQuery(Ref ref, {JobID? jobId}) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching jobs');
  }
  final repository = ref.watch(entriesRepositoryProvider);
  return repository
      .queryEntries(uid: user.uid, jobId: jobId)
      .orderBy('start', descending: true);
}

@riverpod
Stream<List<Entry>> openEntriesStream(Ref ref, {JobID? jobId}) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching jobs');
  }
  final repository = ref.watch(entriesRepositoryProvider);
  return repository.watchOpenEntries(uid: user.uid, jobId: jobId);
}
