import 'dart:async';

import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/cats/data/cats_repository.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/cats/presentation/edit_cat_screen/cat_submit_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditCatScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<bool> submit({CatID? catID, Cat? oldCat, required String name}) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    // set loading state
    state = const AsyncLoading().copyWithPrevious(state);
    // check if name is already in use
    final repository = ref.read(catsRepositoryProvider);
    final cats = await repository.fetchCats(uid: currentUser.uid);
    final allLowerCaseNames =
        cats.map((cat) => cat.name.toLowerCase()).toList();
    // it's ok to use the same name as the old cat
    if (oldCat != null) {
      allLowerCaseNames.remove(oldCat.name.toLowerCase());
    }
    // check if name is already used
    if (allLowerCaseNames.contains(name.toLowerCase())) {
      state = AsyncError(CatSubmitException(), StackTrace.current);
      return false;
    } else {
      // cat previously existed
      if (catID != null) {
        final cat = Cat(id: catID, name: name);
        state = await AsyncValue.guard(
          () => repository.updateCat(uid: currentUser.uid, cat: cat),
        );
      } else {
        state = await AsyncValue.guard(
          () => repository.addCat(uid: currentUser.uid, name: name),
        );
      }
      return state.hasError == false;
    }
  }
}

final editCatScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<EditCatScreenController, void>(
        EditCatScreenController.new);
