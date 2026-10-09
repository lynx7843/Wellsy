import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wellsy/main.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('Today dashboard renders and is interactive', (tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const WellsyApp());

    // Sign in with the prefilled demo credentials.
    await tester.tap(find.text('Sign In'));
    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Wellsy'), findsOneWidget);
    expect(find.byIcon(Icons.person_rounded), findsOneWidget);

    await tester.scrollUntilVisible(find.text('250ml'), 200);
    expect(find.text('1,750 / 2,500 ml'), findsOneWidget);

    await tester.tap(find.text('250ml'));
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('2,000 / 2,500 ml'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Take'), 200);
    await tester.tap(find.text('Take'));
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('Taken'), findsOneWidget);
  });
}
