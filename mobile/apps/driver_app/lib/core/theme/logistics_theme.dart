import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class LogisticsTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.neonGreen,
        brightness: Brightness.dark,
        surface: AppColors.cardDark,
      ),
      useMaterial3: true,
    );
  }
}

