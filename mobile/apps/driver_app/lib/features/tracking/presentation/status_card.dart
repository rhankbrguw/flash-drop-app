import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../application/health_provider.dart';
import '../application/simulation_provider.dart';
import 'map_telemetry_view.dart';

class StatusCard extends ConsumerWidget {
  const StatusCard({super.key});

  Color _getStatusColor(SyncStatus status) {
    switch (status) {
      case SyncStatus.streaming:
        return AppColors.statusActive;
      case SyncStatus.connecting:
        return AppColors.statusConnecting;
      case SyncStatus.error:
        return AppColors.statusError;
      case SyncStatus.disconnected:
        return AppColors.statusDisconnected;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final simulationState = ref.watch(simulationControllerProvider);
    final healthState = ref.watch(serverHealthProvider);
    final isHealthError = healthState.valueOrNull == HealthStatus.error;
    final statusColor = isHealthError ? AppColors.statusError : _getStatusColor(simulationState.status);
    final statusLabel = isHealthError ? AppStrings.apiDown : simulationState.status.name.toUpperCase();

    return Card(
      elevation: 8,
      color: AppColors.cardDark,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.space20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(AppStrings.goConnectivity,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Flexible(
                  child: Chip(
                    labelPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.space12),
                    label: Text(statusLabel, overflow: TextOverflow.ellipsis),
                    backgroundColor: statusColor.withValues(alpha: 0.1),
                    side: BorderSide(color: statusColor),
                  ),
                ),
              ],
            ),
            const Divider(height: AppDimensions.space30),
            const Text(
              AppStrings.liveTelemetry,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.neonGreen,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.space10),
            const MapTelemetryView(),
          ],
        ),
      ),
    );
  }
}
