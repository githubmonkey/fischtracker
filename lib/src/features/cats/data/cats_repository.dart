import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/authentication/domain/app_user.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/entries/data/entries_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cats_repository.g.dart';

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
  // NOTE: This expects that the category is empty
  Future<void> deleteCat({required UserID uid, required CatID catId}) async {
    // delete job
    final ref = _firestore.doc(catPath(uid, catId));
    await ref.delete();
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
          ).orderBy('name');

  Future<List<Cat>> fetchCats({required UserID uid}) async {
    final cats = await queryCats(uid: uid).get();
    return cats.docs.map((doc) => doc.data()).toList();
  }
}

@Riverpod(keepAlive: true)
CatsRepository catsRepository(CatsRepositoryRef ref) {
  return CatsRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Cat> catsQuery(CatsQueryRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(catsRepositoryProvider);
  return repository.queryCats(uid: user.uid);
}

@riverpod
Stream<List<Cat>> catsStream(CatsStreamRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(catsRepositoryProvider);
  return repository.watchCats(uid: user.uid);
}

@riverpod
Stream<Cat> catStream(CatStreamRef ref, {required CatID catId}) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(catsRepositoryProvider);
  return repository.watchCat(uid: user.uid, catId: catId);
}
