import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x_ray_karo/main.dart';
import 'package:x_ray_karo/services/storage_service.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await StorageService.init();
  });

  testWidgets('App smoke test', (WidgetTester tester) async {
    // Wrap in runAsync to allow real timers (like SplashScreen navigation) to be handled without fake_async errors
    await tester.runAsync(() async {
      await tester.pumpWidget(const XrayFunApp());
      // Just verify the app structure exists
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
