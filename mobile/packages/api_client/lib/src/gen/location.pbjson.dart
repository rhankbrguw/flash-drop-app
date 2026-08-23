// This is a generated file - do not edit.
//
// Generated from location.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use locationDescriptor instead')
const Location$json = {
  '1': 'Location',
  '2': [
    {'1': 'latitude', '3': 1, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 2, '4': 1, '5': 1, '10': 'longitude'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `Location`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List locationDescriptor = $convert.base64Decode(
    'CghMb2NhdGlvbhIaCghsYXRpdHVkZRgBIAEoAVIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAIgAS'
    'gBUglsb25naXR1ZGUSHAoJdGltZXN0YW1wGAMgASgDUgl0aW1lc3RhbXA=');

@$core.Deprecated('Use streamLocationRequestDescriptor instead')
const StreamLocationRequest$json = {
  '1': 'StreamLocationRequest',
  '2': [
    {'1': 'driver_id', '3': 1, '4': 1, '5': 9, '10': 'driverId'},
    {
      '1': 'location',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.location.v1.Location',
      '10': 'location'
    },
  ],
};

/// Descriptor for `StreamLocationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamLocationRequestDescriptor = $convert.base64Decode(
    'ChVTdHJlYW1Mb2NhdGlvblJlcXVlc3QSGwoJZHJpdmVyX2lkGAEgASgJUghkcml2ZXJJZBIxCg'
    'hsb2NhdGlvbhgCIAEoCzIVLmxvY2F0aW9uLnYxLkxvY2F0aW9uUghsb2NhdGlvbg==');

@$core.Deprecated('Use streamLocationResponseDescriptor instead')
const StreamLocationResponse$json = {
  '1': 'StreamLocationResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `StreamLocationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamLocationResponseDescriptor =
    $convert.base64Decode(
        'ChZTdHJlYW1Mb2NhdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');

@$core.Deprecated('Use watchDriverRequestDescriptor instead')
const WatchDriverRequest$json = {
  '1': 'WatchDriverRequest',
  '2': [
    {'1': 'driver_id', '3': 1, '4': 1, '5': 9, '10': 'driverId'},
  ],
};

/// Descriptor for `WatchDriverRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List watchDriverRequestDescriptor =
    $convert.base64Decode(
        'ChJXYXRjaERyaXZlclJlcXVlc3QSGwoJZHJpdmVyX2lkGAEgASgJUghkcml2ZXJJZA==');

@$core.Deprecated('Use watchDriverResponseDescriptor instead')
const WatchDriverResponse$json = {
  '1': 'WatchDriverResponse',
  '2': [
    {
      '1': 'location',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.location.v1.Location',
      '10': 'location'
    },
  ],
};

/// Descriptor for `WatchDriverResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List watchDriverResponseDescriptor = $convert.base64Decode(
    'ChNXYXRjaERyaXZlclJlc3BvbnNlEjEKCGxvY2F0aW9uGAEgASgLMhUubG9jYXRpb24udjEuTG'
    '9jYXRpb25SCGxvY2F0aW9u');

@$core.Deprecated('Use getLocationHistoryRequestDescriptor instead')
const GetLocationHistoryRequest$json = {
  '1': 'GetLocationHistoryRequest',
  '2': [
    {'1': 'driver_id', '3': 1, '4': 1, '5': 9, '10': 'driverId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetLocationHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLocationHistoryRequestDescriptor =
    $convert.base64Decode(
        'ChlHZXRMb2NhdGlvbkhpc3RvcnlSZXF1ZXN0EhsKCWRyaXZlcl9pZBgBIAEoCVIIZHJpdmVySW'
        'QSFAoFbGltaXQYAiABKAVSBWxpbWl0');

@$core.Deprecated('Use getLocationHistoryResponseDescriptor instead')
const GetLocationHistoryResponse$json = {
  '1': 'GetLocationHistoryResponse',
  '2': [
    {
      '1': 'locations',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.location.v1.Location',
      '10': 'locations'
    },
  ],
};

/// Descriptor for `GetLocationHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLocationHistoryResponseDescriptor =
    $convert.base64Decode(
        'ChpHZXRMb2NhdGlvbkhpc3RvcnlSZXNwb25zZRIzCglsb2NhdGlvbnMYASADKAsyFS5sb2NhdG'
        'lvbi52MS5Mb2NhdGlvblIJbG9jYXRpb25z');
