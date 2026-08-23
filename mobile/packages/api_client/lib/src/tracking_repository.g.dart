// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationHistoryHash() => r'cf6de10b8a77c26592e090821a915566861dc3ea';

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

/// See also [locationHistory].
@ProviderFor(locationHistory)
const locationHistoryProvider = LocationHistoryFamily();

/// See also [locationHistory].
class LocationHistoryFamily extends Family<AsyncValue<List<DriverLocation>>> {
  /// See also [locationHistory].
  const LocationHistoryFamily();

  /// See also [locationHistory].
  LocationHistoryProvider call(String token, String driverId) {
    return LocationHistoryProvider(token, driverId);
  }

  @override
  LocationHistoryProvider getProviderOverride(
    covariant LocationHistoryProvider provider,
  ) {
    return call(provider.token, provider.driverId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'locationHistoryProvider';
}

/// See also [locationHistory].
class LocationHistoryProvider
    extends AutoDisposeFutureProvider<List<DriverLocation>> {
  /// See also [locationHistory].
  LocationHistoryProvider(String token, String driverId)
    : this._internal(
        (ref) => locationHistory(ref as LocationHistoryRef, token, driverId),
        from: locationHistoryProvider,
        name: r'locationHistoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$locationHistoryHash,
        dependencies: LocationHistoryFamily._dependencies,
        allTransitiveDependencies:
            LocationHistoryFamily._allTransitiveDependencies,
        token: token,
        driverId: driverId,
      );

  LocationHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.token,
    required this.driverId,
  }) : super.internal();

  final String token;
  final String driverId;

  @override
  Override overrideWith(
    FutureOr<List<DriverLocation>> Function(LocationHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LocationHistoryProvider._internal(
        (ref) => create(ref as LocationHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        token: token,
        driverId: driverId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DriverLocation>> createElement() {
    return _LocationHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LocationHistoryProvider &&
        other.token == token &&
        other.driverId == driverId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);
    hash = _SystemHash.combine(hash, driverId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LocationHistoryRef on AutoDisposeFutureProviderRef<List<DriverLocation>> {
  /// The parameter `token` of this provider.
  String get token;

  /// The parameter `driverId` of this provider.
  String get driverId;
}

class _LocationHistoryProviderElement
    extends AutoDisposeFutureProviderElement<List<DriverLocation>>
    with LocationHistoryRef {
  _LocationHistoryProviderElement(super.provider);

  @override
  String get token => (origin as LocationHistoryProvider).token;
  @override
  String get driverId => (origin as LocationHistoryProvider).driverId;
}

String _$trackingRepositoryHash() =>
    r'b65659fcea535f0bc6a83fefbac20dac309c7e0c';

abstract class _$TrackingRepository
    extends BuildlessAutoDisposeAsyncNotifier<DriverLocation?> {
  late final String token;

  FutureOr<DriverLocation?> build(String token);
}

/// See also [TrackingRepository].
@ProviderFor(TrackingRepository)
const trackingRepositoryProvider = TrackingRepositoryFamily();

/// See also [TrackingRepository].
class TrackingRepositoryFamily extends Family<AsyncValue<DriverLocation?>> {
  /// See also [TrackingRepository].
  const TrackingRepositoryFamily();

  /// See also [TrackingRepository].
  TrackingRepositoryProvider call(String token) {
    return TrackingRepositoryProvider(token);
  }

  @override
  TrackingRepositoryProvider getProviderOverride(
    covariant TrackingRepositoryProvider provider,
  ) {
    return call(provider.token);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'trackingRepositoryProvider';
}

/// See also [TrackingRepository].
class TrackingRepositoryProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          TrackingRepository,
          DriverLocation?
        > {
  /// See also [TrackingRepository].
  TrackingRepositoryProvider(String token)
    : this._internal(
        () => TrackingRepository()..token = token,
        from: trackingRepositoryProvider,
        name: r'trackingRepositoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$trackingRepositoryHash,
        dependencies: TrackingRepositoryFamily._dependencies,
        allTransitiveDependencies:
            TrackingRepositoryFamily._allTransitiveDependencies,
        token: token,
      );

  TrackingRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.token,
  }) : super.internal();

  final String token;

  @override
  FutureOr<DriverLocation?> runNotifierBuild(
    covariant TrackingRepository notifier,
  ) {
    return notifier.build(token);
  }

  @override
  Override overrideWith(TrackingRepository Function() create) {
    return ProviderOverride(
      origin: this,
      override: TrackingRepositoryProvider._internal(
        () => create()..token = token,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        token: token,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TrackingRepository, DriverLocation?>
  createElement() {
    return _TrackingRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TrackingRepositoryProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TrackingRepositoryRef
    on AutoDisposeAsyncNotifierProviderRef<DriverLocation?> {
  /// The parameter `token` of this provider.
  String get token;
}

class _TrackingRepositoryProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          TrackingRepository,
          DriverLocation?
        >
    with TrackingRepositoryRef {
  _TrackingRepositoryProviderElement(super.provider);

  @override
  String get token => (origin as TrackingRepositoryProvider).token;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
