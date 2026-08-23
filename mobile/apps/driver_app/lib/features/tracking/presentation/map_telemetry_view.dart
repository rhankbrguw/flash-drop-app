import 'dart:math' as math;

import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../auth/application/auth_provider.dart';
import '../application/simulation_provider.dart';

double _calculateDistanceMeters(LatLng a, LatLng b) {
  const earthRadius = 6371000.0;
  final dLat = (b.latitude - a.latitude) * math.pi / 180.0;
  final dLng = (b.longitude - a.longitude) * math.pi / 180.0;
  final cosLat = math.cos(a.latitude * math.pi / 180.0);
  return math.sqrt(dLat * dLat + (cosLat * dLng) * (cosLat * dLng)) * earthRadius;
}

class MapTelemetryView extends ConsumerStatefulWidget {
  const MapTelemetryView({super.key});

  @override
  ConsumerState<MapTelemetryView> createState() => _MapTelemetryViewState();
}

class _MapTelemetryViewState extends ConsumerState<MapTelemetryView> {
  final MapController _mapController = MapController();
  bool _isMapReady = false;
  LatLng _targetPosition = const LatLng(37.7749, -122.4194);
  double _targetBearing = 0.0;
  DateTime _lastCameraMove = DateTime.fromMillisecondsSinceEpoch(0);

  void _updateTarget(LatLng newPosition, double newBearing) {
    if (!mounted) return;
    setState(() {
      _targetPosition = newPosition;
      _targetBearing = newBearing;
    });

    if (!_isMapReady) return;
    final now = DateTime.now();
    if (now.difference(_lastCameraMove).inSeconds >= AppDimensions.cameraIntervalSec) {
      _mapController.move(newPosition, AppDimensions.defaultZoom);
      _lastCameraMove = now;
    }
  }

  List<LatLng> _extractHistoryPoints(String token) {
    final trackingState = ref.watch(simulationControllerProvider);
    if (!trackingState.isSimulating) return [];

    final historyState = ref.watch(locationHistoryProvider(token, AppStrings.defaultDriverId));
    final locations = historyState.valueOrNull ?? [];
    final points = <LatLng>[];

    for (final loc in locations) {
      final point = LatLng(loc.latitude, loc.longitude);
      if (points.isEmpty || _calculateDistanceMeters(points.last, point) >= 3.0) {
        points.add(point);
      }
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    final token = ref.watch(authProvider).valueOrNull ?? '';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen<AsyncValue<DriverLocation?>>(trackingRepositoryProvider(token), (_, next) {
      if (next is AsyncData && next.value != null) {
        final loc = next.value!;
        _updateTarget(LatLng(loc.latitude, loc.longitude), loc.bearing);
      }
    });

    final driverState = ref.watch(trackingRepositoryProvider(token));
    if (!driverState.hasValue || driverState.value == null) {
      return const SizedBox(
        height: AppDimensions.mapHeight,
        child: Center(
          child: Text(AppStrings.waitingForStream, style: TextStyle(color: AppColors.textSecondary)),
        ),
      );
    }

    final historyPoints = _extractHistoryPoints(token);
    final tileUrl = isDark
        ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
        : 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png';

    return SizedBox(
      height: AppDimensions.mapHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radius12),
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _targetPosition,
            initialZoom: AppDimensions.defaultZoom,
            onMapReady: () => setState(() => _isMapReady = true),
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: tileUrl,
              subdomains: const ['a', 'b', 'c', 'd'],
              userAgentPackageName: 'com.flashdrop.driver.driver_app',
            ),
            if (historyPoints.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: historyPoints,
                    color: AppColors.neonGreen.withValues(alpha: 0.6),
                    strokeWidth: 4.0,
                    pattern: const StrokePattern.dotted(),
                  ),
                ],
              ),
            MarkerLayer(
              markers: [
                Marker(
                  point: _targetPosition,
                  width: AppDimensions.markerSize,
                  height: AppDimensions.markerSize,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(end: _targetBearing * math.pi / 180.0),
                    duration: const Duration(milliseconds: AppDimensions.bearingAnimMs),
                    curve: Curves.easeOut,
                    builder: (_, angle, child) => Transform.rotate(angle: angle, child: child),
                    child: const Icon(
                      Icons.navigation,
                      color: AppColors.neonGreen,
                      size: 36,
                      shadows: [Shadow(color: AppColors.shadowDark, blurRadius: 8)],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
