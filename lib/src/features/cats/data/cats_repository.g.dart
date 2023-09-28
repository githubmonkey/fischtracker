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
String _$catsQueryHash() => r'e5eee281e22cef14614ba1950d8e1f802fc1e57d';

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
    required String catId,
  }) : this._internal(
          (ref) => catStream(
            ref as CatStreamRef,
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
          catId: catId,
        );

  CatStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.catId,
  }) : super.internal();

  final String catId;

  @override
  Override overrideWith(
    Stream<Cat> Function(CatStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CatStreamProvider._internal(
        (ref) => create(ref as CatStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        catId: catId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Cat> createElement() {
    return _CatStreamProviderElement(this);
  }

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

mixin CatStreamRef on AutoDisposeStreamProviderRef<Cat> {
  /// The parameter `catId` of this provider.
  String get catId;
}

class _CatStreamProviderElement extends AutoDisposeStreamProviderElement<Cat>
    with CatStreamRef {
  _CatStreamProviderElement(super.provider);

  @override
  String get catId => (origin as CatStreamProvider).catId;
}

String _$catFutureHash() => r'f02e1e12ed61ef5deed896b66bdd7c725fcd52e2';

/// See also [catFuture].
@ProviderFor(catFuture)
const catFutureProvider = CatFutureFamily();

/// See also [catFuture].
class CatFutureFamily extends Family<AsyncValue<Cat?>> {
  /// See also [catFuture].
  const CatFutureFamily();

  /// See also [catFuture].
  CatFutureProvider call({
    required String catId,
  }) {
    return CatFutureProvider(
      catId: catId,
    );
  }

  @override
  CatFutureProvider getProviderOverride(
    covariant CatFutureProvider provider,
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
  String? get name => r'catFutureProvider';
}

/// See also [catFuture].
class CatFutureProvider extends AutoDisposeFutureProvider<Cat?> {
  /// See also [catFuture].
  CatFutureProvider({
    required String catId,
  }) : this._internal(
          (ref) => catFuture(
            ref as CatFutureRef,
            catId: catId,
          ),
          from: catFutureProvider,
          name: r'catFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$catFutureHash,
          dependencies: CatFutureFamily._dependencies,
          allTransitiveDependencies: CatFutureFamily._allTransitiveDependencies,
          catId: catId,
        );

  CatFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.catId,
  }) : super.internal();

  final String catId;

  @override
  Override overrideWith(
    FutureOr<Cat?> Function(CatFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CatFutureProvider._internal(
        (ref) => create(ref as CatFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        catId: catId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Cat?> createElement() {
    return _CatFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CatFutureProvider && other.catId == catId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, catId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CatFutureRef on AutoDisposeFutureProviderRef<Cat?> {
  /// The parameter `catId` of this provider.
  String get catId;
}

class _CatFutureProviderElement extends AutoDisposeFutureProviderElement<Cat?>
    with CatFutureRef {
  _CatFutureProviderElement(super.provider);

  @override
  String get catId => (origin as CatFutureProvider).catId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
