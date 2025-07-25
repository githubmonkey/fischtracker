// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jobsRepositoryHash() => r'38b37bbcb0ced4ca0754f549ebbe9384bc2bda31';

/// See also [jobsRepository].
@ProviderFor(jobsRepository)
final jobsRepositoryProvider = Provider<JobsRepository>.internal(
  jobsRepository,
  name: r'jobsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$jobsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JobsRepositoryRef = ProviderRef<JobsRepository>;
String _$jobsQueryHash() => r'aeaccb50f75b9e5bc97b07443935ffd432dba51a';

/// See also [jobsQuery].
@ProviderFor(jobsQuery)
final jobsQueryProvider = AutoDisposeProvider<Query<Job>>.internal(
  jobsQuery,
  name: r'jobsQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jobsQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JobsQueryRef = AutoDisposeProviderRef<Query<Job>>;
String _$jobStreamHash() => r'0713110998fd87210993baf69e4d9cf722a73031';

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

/// See also [jobStream].
@ProviderFor(jobStream)
const jobStreamProvider = JobStreamFamily();

/// See also [jobStream].
class JobStreamFamily extends Family<AsyncValue<Job>> {
  /// See also [jobStream].
  const JobStreamFamily();

  /// See also [jobStream].
  JobStreamProvider call(
    String jobId,
  ) {
    return JobStreamProvider(
      jobId,
    );
  }

  @override
  JobStreamProvider getProviderOverride(
    covariant JobStreamProvider provider,
  ) {
    return call(
      provider.jobId,
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
  String? get name => r'jobStreamProvider';
}

/// See also [jobStream].
class JobStreamProvider extends AutoDisposeStreamProvider<Job> {
  /// See also [jobStream].
  JobStreamProvider(
    String jobId,
  ) : this._internal(
          (ref) => jobStream(
            ref as JobStreamRef,
            jobId,
          ),
          from: jobStreamProvider,
          name: r'jobStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$jobStreamHash,
          dependencies: JobStreamFamily._dependencies,
          allTransitiveDependencies: JobStreamFamily._allTransitiveDependencies,
          jobId: jobId,
        );

  JobStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.jobId,
  }) : super.internal();

  final String jobId;

  @override
  Override overrideWith(
    Stream<Job> Function(JobStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JobStreamProvider._internal(
        (ref) => create(ref as JobStreamRef),
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
  AutoDisposeStreamProviderElement<Job> createElement() {
    return _JobStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JobStreamProvider && other.jobId == jobId;
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
mixin JobStreamRef on AutoDisposeStreamProviderRef<Job> {
  /// The parameter `jobId` of this provider.
  String get jobId;
}

class _JobStreamProviderElement extends AutoDisposeStreamProviderElement<Job>
    with JobStreamRef {
  _JobStreamProviderElement(super.provider);

  @override
  String get jobId => (origin as JobStreamProvider).jobId;
}

String _$jobsStreamHash() => r'60665a0c5a3d3ad12ad3d058f25b10e618dbb098';

/// See also [jobsStream].
@ProviderFor(jobsStream)
final jobsStreamProvider = AutoDisposeStreamProvider<List<Job>>.internal(
  jobsStream,
  name: r'jobsStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jobsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JobsStreamRef = AutoDisposeStreamProviderRef<List<Job>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
