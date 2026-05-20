import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sonnenkompass/src/app.dart';

void main() {
  testWidgets('renders the Sonnenkompass prototype', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const SonnenkompassApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('SONNENKOMPASS MODELL'), findsOneWidget);
    expect(find.text('HEUTE IM KERN'), findsOneWidget);
    expect(find.text('NAECHSTE SCHRITTE'), findsOneWidget);
    expect(find.text('Zu Heute'), findsOneWidget);
  });

  testWidgets('navigates to the review screen', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const SonnenkompassApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.text('Review').last);
    await tester.pumpAndSettle();

    expect(find.text('TAGESRUECKBLICK'), findsOneWidget);
    expect(find.text('Review speichern'), findsOneWidget);
  });
}
