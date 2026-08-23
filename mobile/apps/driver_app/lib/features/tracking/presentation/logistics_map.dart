import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../auth/application/auth_provider.dart';
import '../application/health_provider.dart';
import 'simulation_controls.dart';
import 'status_card.dart';

class LogisticsMap extends ConsumerWidget {
  const LogisticsMap({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<HealthStatus>>(
      serverHealthProvider,
      (previous, next) {
        if (next is AsyncData) {
          final isError = next.value == HealthStatus.error;
          final wasError = previous?.value == HealthStatus.error;

          if (isError && !wasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.connectionLost),
                backgroundColor: AppColors.statusError,
              ),
            );
          } else if (!isError && wasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.reconnected),
                backgroundColor: AppColors.neonGreen,
              ),
            );
          }
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(serverHealthProvider.notifier).refreshHealth(),
            tooltip: AppStrings.checkHealthTooltip,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
            tooltip: AppStrings.logoutTooltip,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.space24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SimulationControls(),
              SizedBox(height: AppDimensions.space30),
              StatusCard(),
            ],
          ),
        ),
      ),
    );
  }
}

