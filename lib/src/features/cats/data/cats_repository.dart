import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/authentication/domain/app_user.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/entries/data/entries_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatsRepository {
  const CatsRepository(this._firestore);

  final FirebaseFirestore _firestore;

  static String catPath(String uid, String catId) => 'users/$uid/cats/$catId';

  static String catsPath(String uid) => 'users/$uid/cats';

  static String entriesPath(String uid) => EntriesRepository.entriesPath(uid);

  // create
  Future<void> addCat({required UserID uid, required String name}) =>
      _firestore.collection(catsPath(uid)).add({'name': name});

  // update
  Future<void> updateCat({required UserID uid, required Cat cat}) =>
      _firestore.doc(catPath(uid, cat.id)).update(cat.toMap());

  // delete
  // TODO: should clean up jobs and entries as well
  Future<void> deleteCat({required UserID uid, required CatID catId}) async {
    throw AssertionError('Not yet implemented');
  }

  // read
  Stream<Cat> watchCat({required UserID uid, required CatID catId}) =>
      _firestore
          .doc(catPath(uid, catId))
          .withConverter<Cat>(
            fromFirestore: (snapshot, _) =>
                Cat.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (cat, _) => cat.toMap(),
          )
          .snapshots()
          .map((snapshot) => snapshot.data()!);

  Stream<List<Cat>> watchCats({required UserID uid}) => queryCats(uid: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Cat> queryCats({required UserID uid}) =>
      _firestore.collection(catsPath(uid)).withConverter(
            fromFirestore: (snapshot, _) =>
                Cat.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (cat, _) => cat.toMap(),
          );

  Future<List<Cat>> fetchCats({required UserID uid}) async {
    final cats = await queryCats(uid: uid).get();
    return cats.docs.map((doc) => doc.data()).toList();
  }
}

final catsRepositoryProvider = Provider<CatsRepository>((ref) {
  return CatsRepository(FirebaseFirestore.instance);
});

final catsQueryProvider = Provider<Query<Cat>>((ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(catsRepositoryProvider);
  return repository.queryCats(uid: user.uid);
});

final catsStreamProvider = StreamProvider<List<Cat>>((ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(catsRepositoryProvider);
  return repository.watchCats(uid: user.uid);
});

final catStreamProvider =
    StreamProvider.autoDispose.family<Cat, CatID>((ref, catId) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(catsRepositoryProvider);
  return repository.watchCat(uid: user.uid, catId: catId);
});
