import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/authentication/domain/app_user.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/entries/data/entries_repository.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jobs_repository.g.dart';

class JobsRepository {
  const JobsRepository(this._firestore);

  final FirebaseFirestore _firestore;

  static String jobPath(String uid, String jobId) => 'users/$uid/jobs/$jobId';

  static String jobsPath(String uid) => 'users/$uid/jobs';

  static String entriesPath(String uid) => EntriesRepository.entriesPath(uid);

  // create
  Future<void> addJob({
    required UserID uid,
    required String name,
    required String catId,
    required String catName,
  }) =>
      _firestore.collection(jobsPath(uid)).add({
        'name': name,
        'catId': catId,
        'catName': catName,
      });

  // update
  Future<void> updateJob({required UserID uid, required Job job}) =>
      _firestore.doc(jobPath(uid, job.id)).update(job.toMap());

  // delete
  Future<void> deleteJob({required UserID uid, required JobID jobId}) async {
    // delete where entry.jobId == job.jobId
    final entriesRef = _firestore.collection(entriesPath(uid));
    final entries = await entriesRef.get();
    for (final snapshot in entries.docs) {
      final entry = Entry.fromMap(snapshot.data(), snapshot.id);
      if (entry.jobId == jobId) {
        await snapshot.reference.delete();
      }
    }
    // delete job
    final jobRef = _firestore.doc(jobPath(uid, jobId));
    await jobRef.delete();
  }

  // read
  Stream<Job> watchJob({required UserID uid, required JobID jobId}) =>
      _firestore
          .doc(jobPath(uid, jobId))
          .withConverter<Job>(
            fromFirestore: (snapshot, _) =>
                Job.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (job, _) => job.toMap(),
          )
          .snapshots()
          .map((snapshot) => snapshot.data()!);

  Stream<List<Job>> watchJobs({required UserID uid}) => queryJobs(uid: uid)
      .orderBy('catName')
      .orderBy('name')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Job> queryJobs({required UserID uid, CatID? catId}) {
    Query<Job> query = _firestore.collection(jobsPath(uid)).withConverter<Job>(
          fromFirestore: (snapshot, _) =>
              Job.fromMap(snapshot.data()!, snapshot.id),
          toFirestore: (job, _) => job.toMap(),
        );

    if (catId != null) {
      query = query.where('catId', isEqualTo: catId);
    }
    return query;
  }

  // Order doesn't matter
  Future<List<Job>> fetchJobs({required UserID uid}) async {
    final jobs = await queryJobs(uid: uid).get();
    return jobs.docs.map((doc) => doc.data()).toList();
  }
}

@Riverpod(keepAlive: true)
JobsRepository jobsRepository(Ref ref) {
  return JobsRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Job> jobsQuery(Ref ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(jobsRepositoryProvider);
  return repository.queryJobs(uid: user.uid);
}

@riverpod
Stream<Job> jobStream(Ref ref, JobID jobId) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(jobsRepositoryProvider);
  return repository.watchJob(uid: user.uid, jobId: jobId);
}

@riverpod
Stream<List<Job>> jobsStream(Ref ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(jobsRepositoryProvider);
  return repository.watchJobs(uid: user.uid);
}

final catJobsQueryProvider =
    Provider.autoDispose.family<Query<Job>, CatID>((ref, catId) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching jobs');
  }
  final repository = ref.watch(jobsRepositoryProvider);
  return repository.queryJobs(uid: user.uid, catId: catId).orderBy('name');
});
