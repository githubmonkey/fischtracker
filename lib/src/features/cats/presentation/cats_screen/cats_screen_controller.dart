import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';

class CatsScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> deleteCat(Cat cat) async {
    throw AssertionError('Not yet implemented');
    //
    // final currentUser = ref.read(authRepositoryProvider).currentUser;
    // if (currentUser == null) {
    //   throw AssertionError('User can\'t be null');
    // }
    //
    // final repository = ref.read(catsRepositoryProvider);
    // state = const AsyncLoading();
    // state = await AsyncValue.guard(
    //     () => repository.deleteCat(uid: currentUser.uid, catId: cat.id));
  }
}

final catsScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<CatsScreenController, void>(
        CatsScreenController.new);
