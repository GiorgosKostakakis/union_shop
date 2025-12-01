import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/footer.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  group('Footer Widget Tests', () {
    testWidgets('renders with narrow layout when screen width < 700', (tester) async {
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Footer())),
      );
      await tester.pump();

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
      
      // Verify Column layout is used
      final columns = find.byType(Column);
      expect(columns, findsWidgets);
      
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('renders with wide layout when screen width >= 700', (tester) async {
      tester.view.physicalSize = const Size(1000, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Footer())),
      );
      await tester.pump();

      // Verify sections are present in wide layout
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Help & Info'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);
      
      // Verify Row layout is used
      final row = find.descendant(
        of: find.byType(Container),
        matching: find.byType(Row),
      );
      expect(row, findsOneWidget);
      
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('Search button is present and tappable', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Footer()),
        ),
      );

      // Find Search button
      final searchButton = find.text('Search');
      expect(searchButton, findsOneWidget);
      
      // Verify it's a TextButton
      final textButton = find.ancestor(
        of: searchButton,
        matching: find.byType(TextButton),
      );
      expect(textButton, findsOneWidget);
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

    testWidgets('narrow layout uses Column with correct structure', (tester) async {
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Footer())),
      );
      await tester.pump();

      // Verify Column layout is used for narrow screens
      final column = find.descendant(
        of: find.byType(Container),
        matching: find.byType(Column),
      );
      expect(column, findsWidgets);
      
      // Verify all three sections are in the column
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Help & Info'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);
      
      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('displays all opening hours information', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Footer())),
      );

      expect(find.text('(Term Time)'), findsOneWidget);
      expect(find.text('Monday - Friday 9am - 4pm'), findsOneWidget);
      expect(find.text('(Outside of Term Time / Consolidation Weeks)'), findsOneWidget);
      expect(find.text('Monday - Friday 9am - 3pm'), findsOneWidget);
      expect(find.text('Purchase online 24/7'), findsOneWidget);
    });
  });
}
