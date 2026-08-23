import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:driver_app/core/constants/app_strings.dart';
import 'package:driver_app/features/auth/presentation/login_view.dart';

void main() {
  testWidgets('App renders LoginView when unauthenticated', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginView(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(AppStrings.loginTitle), findsOneWidget);
    expect(find.text(AppStrings.connectToFleet), findsOneWidget);
  });
}


