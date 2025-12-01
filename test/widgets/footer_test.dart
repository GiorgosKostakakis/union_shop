import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/main.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  group('Footer Widget Tests', () {
    testWidgets('renders with narrow layout when screen width < 700', (tester) async {
      await tester.binding.setSurfaceSize(const Size(600, 800));
      
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Footer())),
      );

      // Verify all sections are present
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('(Term Time)'), findsOneWidget);
      expect(find.text('Monday - Friday 9am - 4pm'), findsOneWidget);
      expect(find.text('(Outside of Term Time / Consolidation Weeks)'), findsOneWidget);
      expect(find.text('Monday - Friday 9am - 3pm'), findsOneWidget);
      expect(find.text('Purchase online 24/7'), findsOneWidget);
      expect(find.text('Help & Info'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Information and Policy'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);
      
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('renders with wide layout when screen width >= 700', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1000, 600));
      
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Footer())),
      );

      // Verify sections are present in wide layout
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Help & Info'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);
      
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('Search button navigates to search page', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Scroll to footer
      await tester.drag(find.byType(SingleChildScrollView).first, const Offset(0, -1000));
      await tester.pumpAndSettle();

      // Find Search button in footer (use last to avoid header button)
      final searchButtons = find.text('Search');
      await tester.tap(searchButtons.last);
      await tester.pumpAndSettle();

      // Verify navigation to search page
      expect(find.text('Search Products'), findsOneWidget);
    });

    testWidgets('Information and Policy button is tappable', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Footer())),
      );

      final policyButton = find.text('Information and Policy');
      expect(policyButton, findsOneWidget);
      
      // Tap button to cover onPressed callback
      await tester.tap(policyButton);
      await tester.pump();
      
      // Button should still be visible (no navigation)
      expect(policyButton, findsOneWidget);
    });

    testWidgets('has correct container styling', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Footer())),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.color, equals(Colors.grey[50]));
      expect(container.padding, equals(const EdgeInsets.all(24)));
    });
  });
}
