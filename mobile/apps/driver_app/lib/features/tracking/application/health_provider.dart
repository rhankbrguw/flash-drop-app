import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'health_provider.g.dart';

enum HealthStatus { disconnected, connecting, error }

@riverpod
class ServerHealth extends _$ServerHealth {
  @override
  FutureOr<HealthStatus> build() async {
    return _checkHealth();
  }

  Future<HealthStatus> _checkHealth() async {
    final host = defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2' : '127.0.0.1';
    try {
      final response = await http.get(Uri.parse('http://$host:8080/health'));
      if (response.statusCode == 200) {
        return HealthStatus.disconnected;
      } else {
        return HealthStatus.error;
      }
    } catch (_) {
      return HealthStatus.error;
    }
  }

  Future<void> refreshHealth() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_checkHealth);
  }
}
