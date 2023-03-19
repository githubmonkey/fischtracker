// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cats_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$catsRepositoryHash() => r'8dbe605bc54148cbd5553d67606fe02f47b8304a';

/// See also [catsRepository].
@ProviderFor(catsRepository)
final catsRepositoryProvider = Provider<CatsRepository>.internal(
  catsRepository,
  name: r'catsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$catsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CatsRepositoryRef = ProviderRef<CatsRepository>;
String _$catsQueryHash() => r'123352f106b7b2023266a4cb3bd9f94ba20eed9e';

/// See also [catsQuery].
@ProviderFor(catsQuery)
final catsQueryProvider = AutoDisposeProvider<Query<Cat>>.internal(
  catsQuery,
  name: r'catsQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$catsQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CatsQueryRef = AutoDisposeProviderRef<Query<Cat>>;
String _$catsStreamHash() => r'ca1ad8f829c60c173cd3eb514f991e85849d2d18';

/// See also [catsStream].
@ProviderFor(catsStream)
final catsStreamProvider = AutoDisposeStreamProvider<List<Cat>>.internal(
  catsStream,
  name: r'catsStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$catsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CatsStreamRef = AutoDisposeStreamProviderRef<List<Cat>>;
String _$catStreamHash() => r'f9b665ec268c0c5dd5eb08d25108fea1bdc318b9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef CatStreamRef = AutoDisposeStreamProviderRef<Cat>;

/// See also [catStream].
@ProviderFor(catStream)
const catStreamProvider = CatStreamFamily();

/// See also [catStream].
class CatStreamFamily extends Family<AsyncValue<Cat>> {
  /// See also [catStream].
  const CatStreamFamily();

  /// See also [catStream].
  CatStreamProvider call({
    required String catId,
  }) {
    return CatStreamProvider(
      catId: catId,
    );
  }

  @override
  CatStreamProvider getProviderOverride(
    covariant CatStreamProvider provider,
  ) {
    return call(
      catId: provider.catId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'catStreamProvider';
}

/// See also [catStream].
class CatStreamProvider extends AutoDisposeStreamProvider<Cat> {
  /// See also [catStream].
  CatStreamProvider({
    required this.catId,
  }) : super.internal(
          (ref) => catStream(
            ref,
            catId: catId,
          ),
          from: catStreamProvider,
          name: r'catStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$catStreamHash,
          dependencies: CatStreamFamily._dependencies,
          allTransitiveDependencies: CatStreamFamily._allTransitiveDependencies,
        );

  final String catId;

  @override
  bool operator ==(Object other) {
    return other is CatStreamProvider && other.catId == catId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, catId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
