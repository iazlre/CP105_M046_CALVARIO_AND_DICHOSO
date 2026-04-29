import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/main.dart';

void main() {
  testWidgets('App loads and shows title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // App title should be visible.
    expect(find.text('MotiNotes'), findsOneWidget);

    // Settings icon should be present in the app bar.
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
  });
}
