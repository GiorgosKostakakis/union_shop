import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  group('Navigation Tests', () {
    testWidgets('tapping a product card on Home navigates to ProductPage',
        (tester) async {
      // Start at home page
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Verify we're on the home page
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);
      expect(find.text('University Hoodie'), findsOneWidget);

      // Scroll to ensure the product card is visible
      final productCardFinder = find.text('University Hoodie').first;
      await tester.ensureVisible(productCardFinder);
      await tester.pumpAndSettle();

      // Tap the product card
      await tester.tap(productCardFinder);
      await tester.pumpAndSettle();

      // Verify we're on the ProductPage
      // ProductPage should show product title and price
      expect(find.text('University Hoodie'), findsWidgets);
      expect(find.text('£10.00'), findsWidgets);
      
      // Verify product-specific elements are present
      expect(find.text('ADD TO CART'), findsOneWidget);
      
      // Verify we're no longer on home (no hero section)
      expect(find.text('PRODUCTS SECTION'), findsNothing);
    });

    testWidgets('navigation maintains header and footer on ProductPage',
        (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Navigate to a product
      final productFinder = find.text('Varsity T-Shirt').first;
      await tester.ensureVisible(productFinder);
      await tester.pumpAndSettle();
      await tester.tap(productFinder);
      await tester.pumpAndSettle();

      // Verify header is present
      expect(find.text('Union Shop'), findsOneWidget);

      // Verify footer is present (scroll to bottom if needed)
      await tester.drag(find.byType(SingleChildScrollView).first, const Offset(0, -500));
      await tester.pumpAndSettle();
      expect(find.text('Opening Hours'), findsOneWidget);
    });

    testWidgets('multiple product navigations work correctly', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Navigate to University Hoodie
      await tester.ensureVisible(find.text('University Hoodie').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('University Hoodie').first);
      await tester.pumpAndSettle();
      expect(find.text('University Hoodie'), findsWidgets);

      // Go back to home using menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);

      // Navigate to Campus Sweatshirt
      await tester.ensureVisible(find.text('Campus Sweatshirt').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Campus Sweatshirt').first);
      await tester.pumpAndSettle();
      expect(find.text('Campus Sweatshirt'), findsWidgets);
      expect(find.text('£15.00'), findsWidgets);
    });
  });
}
