import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uts_mobile_ii/main.dart';

void main() {
  setUp(() {
    // Never fetch Google Fonts over the network during tests.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  /// Pumps the app on a phone-sized surface (393x852 logical pixels).
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
  }

  testWidgets('menampilkan data profil', (WidgetTester tester) async {
    await pumpApp(tester);

    final scrollable = find.byType(Scrollable).first;

    expect(find.text('Rifky Saputra Maylandra'), findsOneWidget);
    expect(find.textContaining('24552011091'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Kontak'), 200,
        scrollable: scrollable);
    expect(find.text('Kontak'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Skill'), 200,
        scrollable: scrollable);
    expect(find.text('Skill'), findsOneWidget);
  });

  testWidgets('toggle tema gelap', (WidgetTester tester) async {
    await pumpApp(tester);

    await tester.tap(find.byIcon(Icons.dark_mode_outlined));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
  });

  testWidgets('status berubah lewat Cubit', (WidgetTester tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Aktif'));
    await tester.pumpAndSettle();

    expect(find.text('Cuti'), findsOneWidget);
  });
}
