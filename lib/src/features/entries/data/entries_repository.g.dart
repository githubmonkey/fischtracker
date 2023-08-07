// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entries_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$entriesRepositoryHash() => r'b372d27ef1dca2699bbc980d86a778328a7cf730';

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

typedef EntriesRepositoryRef = ProviderRef<EntriesRepository>;
String _$entriesQueryHash() => r'70ad8335af0bf310e7be3e94974d4830e6625edc';

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

typedef EntriesQueryRef = AutoDisposeProviderRef<Query<Entry>>;

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
    this.jobId,
  }) : super.internal(
          (ref) => entriesQuery(
            ref,
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
        );

  final String? jobId;

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

String _$openEntriesStreamHash() => r'720c9d9fb71947c09123abf9e075ae1b6975bc18';
typedef OpenEntriesStreamRef = AutoDisposeStreamProviderRef<List<Entry>>;

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
    this.jobId,
  }) : super.internal(
          (ref) => openEntriesStream(
            ref,
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
        );

  final String? jobId;

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
