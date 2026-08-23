import 'dart:async';
import 'dart:math';

import 'package:api_client/api_client.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/application/auth_provider.dart';

part 'simulation_provider.g.dart';

enum SyncStatus { disconnected, connecting, streaming, error }

class SimulationState {
  final bool isSimulating;
  final SyncStatus status;

  SimulationState({
    required this.isSimulating,
    required this.status,
  });

  SimulationState copyWith({
    bool? isSimulating,
    SyncStatus? status,
  }) {
    return SimulationState(
      isSimulating: isSimulating ?? this.isSimulating,
      status: status ?? this.status,
    );
  }
}

@riverpod
class SimulationController extends _$SimulationController {
  late final LocationApiClient _apiClient;
  StreamController<StreamLocationRequest>? _requestController;
  Timer? _mockTimer;

  @override
  SimulationState build() {
    final token = ref.watch(authProvider).valueOrNull ?? '';
    _apiClient = LocationApiClient(
      host: defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2' : '127.0.0.1',
      port: 8080,
      token: token,
    );

    ref.onDispose(() {
      _cleanup();
      _apiClient.close();
    });

    return SimulationState(
      isSimulating: false,
      status: SyncStatus.disconnected,
    );
  }

  void _cleanup() {
    _mockTimer?.cancel();
    _mockTimer = null;
    if (_requestController?.isClosed == false) {
      _requestController?.close();
    }
    _requestController = null;
  }

  void toggleSimulation(bool enable) {
    final token = ref.read(authProvider).valueOrNull ?? '';
    if (enable) {
      state = state.copyWith(isSimulating: true, status: SyncStatus.connecting);
      _startSending();
      ref.read(trackingRepositoryProvider(token).notifier).startTracking("driver-123");
    } else {
      _stopSending();
      ref.read(trackingRepositoryProvider(token).notifier).stopTracking();
    }
  }

  void _startSending() {
    _cleanup();
    _requestController = StreamController<StreamLocationRequest>();

    _apiClient.streamLocation(_requestController!.stream).then((response) {
      debugPrint("Server publish stream closed with success=${response.success}");
      _stopSending();
    }).catchError((error) {
      debugPrint("Publishing error: $error");
      state = state.copyWith(status: SyncStatus.error);
      _stopSending();
    });

    _mockTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!state.isSimulating || _requestController?.isClosed == true) {
        timer.cancel();
        return;
      }

      state = state.copyWith(status: SyncStatus.streaming);

      final lat = 37.7749 + (Random().nextDouble() - 0.5) * 0.01;
      final lng = -122.4194 + (Random().nextDouble() - 0.5) * 0.01;

      final ts = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final high = ts >> 32;
      final low = ts & 0xFFFFFFFF;

      _requestController?.add(StreamLocationRequest(
        driverId: "driver-123",
        location: Location(
          latitude: lat,
          longitude: lng,
          timestamp: Int64.fromInts(high, low),
        ),
      ));
    });
  }

  void _stopSending() {
    if (state.status != SyncStatus.error) {
      state = state.copyWith(isSimulating: false, status: SyncStatus.disconnected);
    } else {
      state = state.copyWith(isSimulating: false);
    }
    _cleanup();
  }
}
