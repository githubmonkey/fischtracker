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
String _$entriesQueryHash() => r'93cd0d807140cdb2fbc5cd932f9c7c2800c90ec2';

/// See also [entriesQuery].
@ProviderFor(entriesQuery)
final entriesQueryProvider = AutoDisposeProvider<Query<Entry>>.internal(
  entriesQuery,
  name: r'entriesQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$entriesQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EntriesQueryRef = AutoDisposeProviderRef<Query<Entry>>;
String _$jobEntriesQueryHash() => r'4b9901b69f7a7c0211f097b6e1dce9434e187ca0';

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

typedef JobEntriesQueryRef = AutoDisposeProviderRef<Query<Entry>>;

/// See also [jobEntriesQuery].
@ProviderFor(jobEntriesQuery)
const jobEntriesQueryProvider = JobEntriesQueryFamily();

/// See also [jobEntriesQuery].
class JobEntriesQueryFamily extends Family<Query<Entry>> {
  /// See also [jobEntriesQuery].
  const JobEntriesQueryFamily();

  /// See also [jobEntriesQuery].
  JobEntriesQueryProvider call({
    required String jobId,
  }) {
    return JobEntriesQueryProvider(
      jobId: jobId,
    );
  }

  @override
  JobEntriesQueryProvider getProviderOverride(
    covariant JobEntriesQueryProvider provider,
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
  String? get name => r'jobEntriesQueryProvider';
}

/// See also [jobEntriesQuery].
class JobEntriesQueryProvider extends AutoDisposeProvider<Query<Entry>> {
  /// See also [jobEntriesQuery].
  JobEntriesQueryProvider({
    required this.jobId,
  }) : super.internal(
          (ref) => jobEntriesQuery(
            ref,
            jobId: jobId,
          ),
          from: jobEntriesQueryProvider,
          name: r'jobEntriesQueryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$jobEntriesQueryHash,
          dependencies: JobEntriesQueryFamily._dependencies,
          allTransitiveDependencies:
              JobEntriesQueryFamily._allTransitiveDependencies,
        );

  final String jobId;

  @override
  bool operator ==(Object other) {
    return other is JobEntriesQueryProvider && other.jobId == jobId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, jobId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
