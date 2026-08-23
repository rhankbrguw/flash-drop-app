import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:api_client/api_client.dart';

part 'tracking_repository.g.dart';

class DriverLocation {
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final double bearing; // Calculated heading angle

  DriverLocation({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.bearing = 0.0,
  });
}

@riverpod
class TrackingRepository extends _$TrackingRepository {
  LocationApiClient? _client;
  StreamSubscription? _sub;

  @override
  FutureOr<DriverLocation?> build(String token) {
    _client = LocationApiClient(
      host: defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2' : '127.0.0.1',
      port: 8080,
      token: token,
    );
    
    ref.onDispose(() {
      _sub?.cancel();
      _client?.close();
    });

    return null; // Return null when not tracking
  }

  void startTracking(String driverId) {
    if (_client == null) return;
    
    // Set loading while we establish connection
    state = const AsyncValue.loading();

    _sub?.cancel();
    
    final request = WatchDriverRequest(driverId: driverId);
    final stream = _client!.watchDriver(request);
    
    _sub = stream.listen((response) {
      if (response.hasLocation()) {
        final loc = response.location;
        double newBearing = 0.0;
        
        // Calculate bearing if we have a previous state
        if (state.hasValue && state.value != null) {
          final prev = state.value!;
          newBearing = _calculateBearing(
            prev.latitude, prev.longitude,
            loc.latitude, loc.longitude
          );
        }

        final driverLoc = DriverLocation(
          latitude: loc.latitude,
          longitude: loc.longitude,
          timestamp: DateTime.fromMillisecondsSinceEpoch(loc.timestamp.toInt() * 1000),
          bearing: newBearing,
        );
        state = AsyncValue.data(driverLoc);
      }
    }, onError: (error) {
      state = AsyncValue.error(error, StackTrace.current);
    });
  }

  void stopTracking() {
    _sub?.cancel();
    _sub = null;
    state = const AsyncValue.data(null);
  }

  double _calculateBearing(double startLat, double startLng, double destLat, double destLng) {
    startLat = startLat * math.pi / 180.0;
    startLng = startLng * math.pi / 180.0;
    destLat = destLat * math.pi / 180.0;
    destLng = destLng * math.pi / 180.0;

    double y = math.sin(destLng - startLng) * math.cos(destLat);
    double x = math.cos(startLat) * math.sin(destLat) -
        math.sin(startLat) * math.cos(destLat) * math.cos(destLng - startLng);
    double brng = math.atan2(y, x);
    return (brng * 180.0 / math.pi + 360.0) % 360.0;
  }
}

@riverpod
Future<List<DriverLocation>> locationHistory(LocationHistoryRef ref, String token, String driverId) async {
  final client = LocationApiClient(
    host: defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2' : '127.0.0.1',
    port: 8080,
    token: token,
  );
  ref.onDispose(() => client.close());

  final req = GetLocationHistoryRequest(driverId: driverId, limit: 100);
  final res = await client.getLocationHistory(req);

  return res.locations.map((loc) => DriverLocation(
    latitude: loc.latitude,
    longitude: loc.longitude,
    timestamp: DateTime.fromMillisecondsSinceEpoch(loc.timestamp.toInt() * 1000),
  )).toList();
}
