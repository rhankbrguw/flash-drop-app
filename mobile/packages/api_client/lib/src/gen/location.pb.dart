// This is a generated file - do not edit.
//
// Generated from location.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Location extends $pb.GeneratedMessage {
  factory Location({
    $core.double? latitude,
    $core.double? longitude,
    $fixnum.Int64? timestamp,
  }) {
    final result = create();
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  Location._();

  factory Location.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Location.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Location',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'location.v1'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'latitude')
    ..aD(2, _omitFieldNames ? '' : 'longitude')
    ..aInt64(3, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Location clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Location copyWith(void Function(Location) updates) =>
      super.copyWith((message) => updates(message as Location)) as Location;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Location create() => Location._();
  @$core.override
  Location createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Location getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Location>(create);
  static Location? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get timestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set timestamp($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);
}

class StreamLocationRequest extends $pb.GeneratedMessage {
  factory StreamLocationRequest({
    $core.String? driverId,
    Location? location,
  }) {
    final result = create();
    if (driverId != null) result.driverId = driverId;
    if (location != null) result.location = location;
    return result;
  }

  StreamLocationRequest._();

  factory StreamLocationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamLocationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamLocationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'location.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'driverId')
    ..aOM<Location>(2, _omitFieldNames ? '' : 'location',
        subBuilder: Location.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamLocationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamLocationRequest copyWith(
          void Function(StreamLocationRequest) updates) =>
      super.copyWith((message) => updates(message as StreamLocationRequest))
          as StreamLocationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamLocationRequest create() => StreamLocationRequest._();
  @$core.override
  StreamLocationRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StreamLocationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamLocationRequest>(create);
  static StreamLocationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get driverId => $_getSZ(0);
  @$pb.TagNumber(1)
  set driverId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDriverId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDriverId() => $_clearField(1);

  @$pb.TagNumber(2)
  Location get location => $_getN(1);
  @$pb.TagNumber(2)
  set location(Location value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLocation() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocation() => $_clearField(2);
  @$pb.TagNumber(2)
  Location ensureLocation() => $_ensure(1);
}

class StreamLocationResponse extends $pb.GeneratedMessage {
  factory StreamLocationResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  StreamLocationResponse._();

  factory StreamLocationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamLocationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamLocationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'location.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamLocationResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamLocationResponse copyWith(
          void Function(StreamLocationResponse) updates) =>
      super.copyWith((message) => updates(message as StreamLocationResponse))
          as StreamLocationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamLocationResponse create() => StreamLocationResponse._();
  @$core.override
  StreamLocationResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StreamLocationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamLocationResponse>(create);
  static StreamLocationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class WatchDriverRequest extends $pb.GeneratedMessage {
  factory WatchDriverRequest({
    $core.String? driverId,
  }) {
    final result = create();
    if (driverId != null) result.driverId = driverId;
    return result;
  }

  WatchDriverRequest._();

  factory WatchDriverRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WatchDriverRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WatchDriverRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'location.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'driverId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchDriverRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchDriverRequest copyWith(void Function(WatchDriverRequest) updates) =>
      super.copyWith((message) => updates(message as WatchDriverRequest))
          as WatchDriverRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WatchDriverRequest create() => WatchDriverRequest._();
  @$core.override
  WatchDriverRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WatchDriverRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WatchDriverRequest>(create);
  static WatchDriverRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get driverId => $_getSZ(0);
  @$pb.TagNumber(1)
  set driverId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDriverId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDriverId() => $_clearField(1);
}

class WatchDriverResponse extends $pb.GeneratedMessage {
  factory WatchDriverResponse({
    Location? location,
  }) {
    final result = create();
    if (location != null) result.location = location;
    return result;
  }

  WatchDriverResponse._();

  factory WatchDriverResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WatchDriverResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WatchDriverResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'location.v1'),
      createEmptyInstance: create)
    ..aOM<Location>(1, _omitFieldNames ? '' : 'location',
        subBuilder: Location.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchDriverResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchDriverResponse copyWith(void Function(WatchDriverResponse) updates) =>
      super.copyWith((message) => updates(message as WatchDriverResponse))
          as WatchDriverResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WatchDriverResponse create() => WatchDriverResponse._();
  @$core.override
  WatchDriverResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WatchDriverResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WatchDriverResponse>(create);
  static WatchDriverResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Location get location => $_getN(0);
  @$pb.TagNumber(1)
  set location(Location value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLocation() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocation() => $_clearField(1);
  @$pb.TagNumber(1)
  Location ensureLocation() => $_ensure(0);
}

class GetLocationHistoryRequest extends $pb.GeneratedMessage {
  factory GetLocationHistoryRequest({
    $core.String? driverId,
    $core.int? limit,
  }) {
    final result = create();
    if (driverId != null) result.driverId = driverId;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetLocationHistoryRequest._();

  factory GetLocationHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLocationHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLocationHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'location.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'driverId')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLocationHistoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLocationHistoryRequest copyWith(
          void Function(GetLocationHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetLocationHistoryRequest))
          as GetLocationHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLocationHistoryRequest create() => GetLocationHistoryRequest._();
  @$core.override
  GetLocationHistoryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetLocationHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLocationHistoryRequest>(create);
  static GetLocationHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get driverId => $_getSZ(0);
  @$pb.TagNumber(1)
  set driverId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDriverId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDriverId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetLocationHistoryResponse extends $pb.GeneratedMessage {
  factory GetLocationHistoryResponse({
    $core.Iterable<Location>? locations,
  }) {
    final result = create();
    if (locations != null) result.locations.addAll(locations);
    return result;
  }

  GetLocationHistoryResponse._();

  factory GetLocationHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLocationHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLocationHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'location.v1'),
      createEmptyInstance: create)
    ..pPM<Location>(1, _omitFieldNames ? '' : 'locations',
        subBuilder: Location.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLocationHistoryResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLocationHistoryResponse copyWith(
          void Function(GetLocationHistoryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetLocationHistoryResponse))
          as GetLocationHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLocationHistoryResponse create() => GetLocationHistoryResponse._();
  @$core.override
  GetLocationHistoryResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetLocationHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLocationHistoryResponse>(create);
  static GetLocationHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Location> get locations => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
