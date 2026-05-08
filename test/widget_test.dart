import 'package:flutter_test/flutter_test.dart';
import 'package:sonnenkompass/src/app.dart';

void main() {
  testWidgets('renders the Sonnenkompass prototype', (tester) async {
    await tester.pumpWidget(const SonnenkompassApp());
    await tester.pumpAndSettle();

    expect(find.text('Rammer Sonnenkompass MVP'), findsOneWidget);
    expect(find.text('Block-Stundenplan'), findsOneWidget);
    expect(find.text('Monetization Layer'), findsOneWidget);
  });
}
