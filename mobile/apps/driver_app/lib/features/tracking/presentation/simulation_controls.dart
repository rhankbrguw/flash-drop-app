import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../application/simulation_provider.dart';

class SimulationControls extends ConsumerWidget {
  const SimulationControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final simulationState = ref.watch(simulationControllerProvider);

    return Column(
      children: [
        const Text(
          AppStrings.simulationControl,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppDimensions.space10),
        Switch(
          value: simulationState.isSimulating,
          onChanged: (val) {
            ref.read(simulationControllerProvider.notifier).toggleSimulation(val);
          },
          activeThumbColor: AppColors.neonGreen,
        ),
      ],
    );
  }
}
