// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serverHealthHash() => r'c817b574096eea041f7e8cf9d8aa13bd116e8b2c';

/// See also [ServerHealth].
@ProviderFor(ServerHealth)
final serverHealthProvider =
    AutoDisposeAsyncNotifierProvider<ServerHealth, HealthStatus>.internal(
      ServerHealth.new,
      name: r'serverHealthProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$serverHealthHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ServerHealth = AutoDisposeAsyncNotifier<HealthStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
