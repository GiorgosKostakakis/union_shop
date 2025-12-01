import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/personalisation_page.dart';
import 'package:union_shop/models/cart.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  setUp(() {
    Cart().clear();
  });

  group('PersonalisationPage Tests', () {
    testWidgets('renders with default state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('Preview Area\nYour text will appear here'), findsOneWidget);
    });

    testWidgets('has personalisation options dropdown', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.byType(DropdownButton<String>), findsWidgets);
    });

    testWidgets('has text input field for One Line option', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('displays entered text in preview', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Find text field and enter text
      final textFields = find.byType(TextField);
      await tester.enterText(textFields.first, 'Test Text');
      await tester.pump();

      expect(find.text('Test Text'), findsWidgets);
    });

    testWidgets('has font selection dropdown', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('Font:'), findsOneWidget);
    });

    testWidgets('has quantity controls', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('Quantity:'), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.add), findsAtLeastNWidgets(1));
    });

    testWidgets('increments quantity when + button tapped', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Find the add button in quantity section
      final addButtons = find.byIcon(Icons.add);
      // Tap last add button (quantity control, not header)
      await tester.tap(addButtons.last);
      await tester.pump();

      expect(find.text('2'), findsWidgets);
    });

    testWidgets('decrements quantity when - button tapped', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // First increment to 2
      final addButtons = find.byIcon(Icons.add);
      await tester.tap(addButtons.last);
      await tester.pump();

      // Then decrement
      final removeButtons = find.byIcon(Icons.remove);
      await tester.tap(removeButtons.first);
      await tester.pump();

      expect(find.text('1'), findsWidgets);
    });

    testWidgets('does not decrement quantity below 1', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Try to decrement from 1
      final removeButtons = find.byIcon(Icons.remove);
      await tester.tap(removeButtons.first);
      await tester.pump();

      // Should still be 1
      expect(find.text('1'), findsWidgets);
    });

    testWidgets('has ADD TO CART button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('ADD TO CART'), findsOneWidget);
    });

    testWidgets('has scrollable content', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('displays preview container', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Check for preview container
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('shows pricing information', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('Price:'), findsOneWidget);
      expect(find.textContaining('£'), findsWidgets);
    });

    testWidgets('displays personalisation type label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('Personalisation Type:'), findsOneWidget);
    });

    testWidgets('has Learn About Print Shack link', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('Learn About Print Shack'), findsOneWidget);
    });

    testWidgets('content is constrained to max width', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      final constrainedBox = find.byType(ConstrainedBox);
      expect(constrainedBox, findsOneWidget);

      final widget = tester.widget<ConstrainedBox>(constrainedBox);
      expect(widget.constraints.maxWidth, 1000);
    });
  });
}
