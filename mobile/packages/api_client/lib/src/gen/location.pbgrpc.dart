// This is a generated file - do not edit.
//
// Generated from location.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'location.pb.dart' as $0;

export 'location.pb.dart';

@$pb.GrpcServiceName('location.v1.LocationService')
class LocationServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  LocationServiceClient(super.channel, {super.options, super.interceptors});

  /// Client-to-server stream for drivers to constantly update their location.
  $grpc.ResponseFuture<$0.StreamLocationResponse> streamLocation(
    $async.Stream<$0.StreamLocationRequest> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$streamLocation, request, options: options)
        .single;
  }

  /// Server-to-client stream for users to track a driver's location in real-time.
  $grpc.ResponseStream<$0.WatchDriverResponse> watchDriver(
    $0.WatchDriverRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$watchDriver, $async.Stream.fromIterable([request]),
        options: options);
  }

  /// Fetch the historical breadcrumb trail for a specific driver.
  $grpc.ResponseFuture<$0.GetLocationHistoryResponse> getLocationHistory(
    $0.GetLocationHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getLocationHistory, request, options: options);
  }

  // method descriptors

  static final _$streamLocation =
      $grpc.ClientMethod<$0.StreamLocationRequest, $0.StreamLocationResponse>(
          '/location.v1.LocationService/StreamLocation',
          ($0.StreamLocationRequest value) => value.writeToBuffer(),
          $0.StreamLocationResponse.fromBuffer);
  static final _$watchDriver =
      $grpc.ClientMethod<$0.WatchDriverRequest, $0.WatchDriverResponse>(
          '/location.v1.LocationService/WatchDriver',
          ($0.WatchDriverRequest value) => value.writeToBuffer(),
          $0.WatchDriverResponse.fromBuffer);
  static final _$getLocationHistory = $grpc.ClientMethod<
          $0.GetLocationHistoryRequest, $0.GetLocationHistoryResponse>(
      '/location.v1.LocationService/GetLocationHistory',
      ($0.GetLocationHistoryRequest value) => value.writeToBuffer(),
      $0.GetLocationHistoryResponse.fromBuffer);
}

@$pb.GrpcServiceName('location.v1.LocationService')
abstract class LocationServiceBase extends $grpc.Service {
  $core.String get $name => 'location.v1.LocationService';

  LocationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StreamLocationRequest,
            $0.StreamLocationResponse>(
        'StreamLocation',
        streamLocation,
        true,
        false,
        ($core.List<$core.int> value) =>
            $0.StreamLocationRequest.fromBuffer(value),
        ($0.StreamLocationResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.WatchDriverRequest, $0.WatchDriverResponse>(
            'WatchDriver',
            watchDriver_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.WatchDriverRequest.fromBuffer(value),
            ($0.WatchDriverResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLocationHistoryRequest,
            $0.GetLocationHistoryResponse>(
        'GetLocationHistory',
        getLocationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetLocationHistoryRequest.fromBuffer(value),
        ($0.GetLocationHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.StreamLocationResponse> streamLocation(
      $grpc.ServiceCall call, $async.Stream<$0.StreamLocationRequest> request);

  $async.Stream<$0.WatchDriverResponse> watchDriver_Pre($grpc.ServiceCall $call,
      $async.Future<$0.WatchDriverRequest> $request) async* {
    yield* watchDriver($call, await $request);
  }

  $async.Stream<$0.WatchDriverResponse> watchDriver(
      $grpc.ServiceCall call, $0.WatchDriverRequest request);

  $async.Future<$0.GetLocationHistoryResponse> getLocationHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetLocationHistoryRequest> $request) async {
    return getLocationHistory($call, await $request);
  }

  $async.Future<$0.GetLocationHistoryResponse> getLocationHistory(
      $grpc.ServiceCall call, $0.GetLocationHistoryRequest request);
}
