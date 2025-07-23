// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entries_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$entriesRepositoryHash() => r'ad38184e057a5a0ee3f4cbf1573f2dcb496948fc';

/// See also [entriesRepository].
@ProviderFor(entriesRepository)
final entriesRepositoryProvider = Provider<EntriesRepository>.internal(
  entriesRepository,
  name: r'entriesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$entriesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EntriesRepositoryRef = ProviderRef<EntriesRepository>;
String _$entriesQueryHash() => r'96ef53d51349378f0ab210ebc46b95ab1a81884b';

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

/// See also [entriesQuery].
@ProviderFor(entriesQuery)
const entriesQueryProvider = EntriesQueryFamily();

/// See also [entriesQuery].
class EntriesQueryFamily extends Family<Query<Entry>> {
  /// See also [entriesQuery].
  const EntriesQueryFamily();

  /// See also [entriesQuery].
  EntriesQueryProvider call({
    String? jobId,
  }) {
    return EntriesQueryProvider(
      jobId: jobId,
    );
  }

  @override
  EntriesQueryProvider getProviderOverride(
    covariant EntriesQueryProvider provider,
  ) {
    return call(
      jobId: provider.jobId,
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
  String? get name => r'entriesQueryProvider';
}

/// See also [entriesQuery].
class EntriesQueryProvider extends AutoDisposeProvider<Query<Entry>> {
  /// See also [entriesQuery].
  EntriesQueryProvider({
    String? jobId,
  }) : this._internal(
          (ref) => entriesQuery(
            ref as EntriesQueryRef,
            jobId: jobId,
          ),
          from: entriesQueryProvider,
          name: r'entriesQueryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$entriesQueryHash,
          dependencies: EntriesQueryFamily._dependencies,
          allTransitiveDependencies:
              EntriesQueryFamily._allTransitiveDependencies,
          jobId: jobId,
        );

  EntriesQueryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.jobId,
  }) : super.internal();

  final String? jobId;

  @override
  Override overrideWith(
    Query<Entry> Function(EntriesQueryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EntriesQueryProvider._internal(
        (ref) => create(ref as EntriesQueryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        jobId: jobId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Query<Entry>> createElement() {
    return _EntriesQueryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EntriesQueryProvider && other.jobId == jobId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, jobId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EntriesQueryRef on AutoDisposeProviderRef<Query<Entry>> {
  /// The parameter `jobId` of this provider.
  String? get jobId;
}

class _EntriesQueryProviderElement
    extends AutoDisposeProviderElement<Query<Entry>> with EntriesQueryRef {
  _EntriesQueryProviderElement(super.provider);

  @override
  String? get jobId => (origin as EntriesQueryProvider).jobId;
}

String _$openEntriesStreamHash() => r'c3be8134c5729843a7f4cf74f83b59a639a193bb';

/// See also [openEntriesStream].
@ProviderFor(openEntriesStream)
const openEntriesStreamProvider = OpenEntriesStreamFamily();

/// See also [openEntriesStream].
class OpenEntriesStreamFamily extends Family<AsyncValue<List<Entry>>> {
  /// See also [openEntriesStream].
  const OpenEntriesStreamFamily();

  /// See also [openEntriesStream].
  OpenEntriesStreamProvider call({
    String? jobId,
  }) {
    return OpenEntriesStreamProvider(
      jobId: jobId,
    );
  }

  @override
  OpenEntriesStreamProvider getProviderOverride(
    covariant OpenEntriesStreamProvider provider,
  ) {
    return call(
      jobId: provider.jobId,
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
  String? get name => r'openEntriesStreamProvider';
}

/// See also [openEntriesStream].
class OpenEntriesStreamProvider extends AutoDisposeStreamProvider<List<Entry>> {
  /// See also [openEntriesStream].
  OpenEntriesStreamProvider({
    String? jobId,
  }) : this._internal(
          (ref) => openEntriesStream(
            ref as OpenEntriesStreamRef,
            jobId: jobId,
          ),
          from: openEntriesStreamProvider,
          name: r'openEntriesStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$openEntriesStreamHash,
          dependencies: OpenEntriesStreamFamily._dependencies,
          allTransitiveDependencies:
              OpenEntriesStreamFamily._allTransitiveDependencies,
          jobId: jobId,
        );

  OpenEntriesStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.jobId,
  }) : super.internal();

  final String? jobId;

  @override
  Override overrideWith(
    Stream<List<Entry>> Function(OpenEntriesStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OpenEntriesStreamProvider._internal(
        (ref) => create(ref as OpenEntriesStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        jobId: jobId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Entry>> createElement() {
    return _OpenEntriesStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpenEntriesStreamProvider && other.jobId == jobId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, jobId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OpenEntriesStreamRef on AutoDisposeStreamProviderRef<List<Entry>> {
  /// The parameter `jobId` of this provider.
  String? get jobId;
}

class _OpenEntriesStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Entry>>
    with OpenEntriesStreamRef {
  _OpenEntriesStreamProviderElement(super.provider);

  @override
  String? get jobId => (origin as OpenEntriesStreamProvider).jobId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
