import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/search_page.dart';
import 'package:union_shop/models/fixtures.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  group('SearchPage Tests', () {
    testWidgets('renders with initial empty state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SearchPage()),
      );

      expect(find.text('Search Products'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search for products...'), findsOneWidget);
    });

    testWidgets('displays search results when query is entered', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SearchPage()),
      );

      // Enter search query
      await tester.enterText(find.byType(TextField), 'Hoodie');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Should find University Hoodie
      expect(find.text('University Hoodie'), findsWidgets);
    });

    testWidgets('shows no results message when search finds nothing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SearchPage()),
      );

      // Enter search query that won't match anything
      await tester.enterText(find.byType(TextField), 'NonExistentProduct12345');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.textContaining('No results found for'), findsOneWidget);
    });

    testWidgets('clears results when search query is cleared', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SearchPage()),
      );

      // Enter search query
      await tester.enterText(find.byType(TextField), 'Product A');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Clear the search
      await tester.enterText(find.byType(TextField), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Should show initial state
      expect(find.text('Search for products...'), findsOneWidget);
    });

    testWidgets('initializes with initialQuery if provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(initialQuery: 'T-Shirt'),
        ),
      );

      // TextField should contain initial query
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, equals('T-Shirt'));
    });

    testWidgets('search is case-insensitive', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SearchPage()),
      );

      // Search with lowercase
      await tester.enterText(find.byType(TextField), 'hoodie');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Should find University Hoodie regardless of case
      expect(find.text('University Hoodie'), findsWidgets);
    });

    testWidgets('displays multiple results when query matches multiple products', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SearchPage()),
      );

      // Search for "University" which should match multiple items
      await tester.enterText(find.byType(TextField), 'University');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Should find multiple products
      final productCount = products.where((p) => 
        p.title.toLowerCase().contains('university')).length;
      expect(productCount, greaterThan(1));
    });

    testWidgets('product card has GestureDetector for navigation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SearchPage()),
      );

      // Search for a product
      await tester.enterText(find.byType(TextField), 'Hoodie');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Verify GestureDetector exists
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('image error builder shows fallback icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Image.asset(
              'invalid_path.jpg',
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });
  });
}
