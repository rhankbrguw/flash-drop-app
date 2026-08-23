import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/logistics_theme.dart';
import 'features/auth/application/auth_provider.dart';
import 'features/auth/presentation/login_view.dart';
import 'features/tracking/presentation/logistics_map.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'FlashDrop Driver',
      theme: LogisticsTheme.darkTheme,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: authState.when(
        data: (token) => token != null
            ? const LogisticsMap(title: 'FlashDrop Driver')
            : const LoginView(),
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (err, stack) => Scaffold(
          body: Center(child: Text('Error loading auth state: $err')),
        ),
      ),
    );
  }
}


