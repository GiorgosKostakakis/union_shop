import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'test_helpers.dart';

void main() {
  setupFirebaseMocks();
  
  group('Product Page Tests', () {
    testWidgets('should display product page with basic elements', (
      tester,
    ) async {
      // Use UnionShopApp for proper routing
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Scroll to and navigate to first product
      final productFinder = find.text('Product A').first;
      await tester.ensureVisible(productFinder);
      await tester.pumpAndSettle();
      await tester.tap(productFinder);
      await tester.pumpAndSettle();

      // Check that basic UI elements are present
      expect(
        find.text('PLACEHOLDER HEADER TEXT'),
        findsOneWidget,
      );
      expect(find.text('Product A'), findsWidgets);
      expect(find.text('£10.00'), findsWidgets);
    });

    testWidgets('should display student instruction text', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Scroll to and navigate to first product
      final productFinder = find.text('Product A').first;
      await tester.ensureVisible(productFinder);
      await tester.pumpAndSettle();
      await tester.tap(productFinder);
      await tester.pumpAndSettle();

      // Check that product description is present
      expect(
        find.text(
          'This is a placeholder description for the product. Students should replace this with real product information and implement proper data management.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display header icons', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Scroll to and navigate to first product
      final productFinder = find.text('Product A').first;
      await tester.ensureVisible(productFinder);
      await tester.pumpAndSettle();
      await tester.tap(productFinder);
      await tester.pumpAndSettle();

      // Check that header icons are present
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Scroll to and navigate to first product
      final productFinder = find.text('Product A').first;
      await tester.ensureVisible(productFinder);
      await tester.pumpAndSettle();
      await tester.tap(productFinder);
      await tester.pumpAndSettle();

      // Check that footer is present
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Help & Info'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);
    });
  });
}
