import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/models/product.dart';
import '../test_helpers.dart';

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
      final productFinder = find.text('University Hoodie').first;
      await tester.ensureVisible(productFinder);
      await tester.pumpAndSettle();
      await tester.tap(productFinder);
      await tester.pumpAndSettle();

      // Check that basic UI elements are present
      expect(
        find.text('Union Shop'),
        findsOneWidget,
      );
      expect(find.text('University Hoodie'), findsWidgets);
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

  group('ProductPage Widget Tests', () {
    final testProduct = const Product(
      id: 'test-1',
      title: 'Test Product',
      price: '£25.00',
      imageUrl: 'assets/test.png',
    );

    testWidgets('renders with product data', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductPage(product: testProduct),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£25.00'), findsWidgets);
    });

    testWidgets('renders with placeholder when no product provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductPage(product: null),
        ),
      );

      expect(find.text('Placeholder Product Name'), findsOneWidget);
      expect(find.text('£15.00'), findsWidgets);
    });

    testWidgets('has quantity controls', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductPage(product: testProduct),
        ),
      );

      // Find quantity controls - should have at least one of each
      expect(find.byIcon(Icons.remove_circle_outline), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.add_circle_outline), findsAtLeastNWidgets(1));
    });

    testWidgets('increments quantity when + button tapped', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(
          home: ProductPage(product: testProduct),
        ),
      );

      // Find and tap the increment button
      final incrementButtons = find.byIcon(Icons.add_circle_outline);
      await tester.tap(incrementButtons.first);
      await tester.pump();

      // Quantity should increase
      expect(find.text('2'), findsAtLeastNWidgets(1));
    });

    testWidgets('decrements quantity when - button tapped', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(
          home: ProductPage(product: testProduct),
        ),
      );

      // First increment to 2
      final incrementButtons = find.byIcon(Icons.add_circle_outline);
      await tester.tap(incrementButtons.first);
      await tester.pump();

      // Then decrement
      final decrementButtons = find.byIcon(Icons.remove_circle_outline);
      await tester.tap(decrementButtons.first);
      await tester.pump();

      // Should be back to 1
      expect(find.text('1'), findsAtLeastNWidgets(1));
    });

    testWidgets('does not decrement quantity below 1', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(
          home: ProductPage(product: testProduct),
        ),
      );

      // Get initial state - should start at 1
      expect(find.text('1'), findsAtLeastNWidgets(1));
      
      // Try to decrement from 1
      final decrementButtons = find.byIcon(Icons.remove_circle_outline);
      await tester.tap(decrementButtons.first);
      await tester.pump();

      // Should still have at least one '1' (quantity should not go below 1)
      expect(find.text('1'), findsAtLeastNWidgets(1));
    });

    testWidgets('has ADD TO CART button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductPage(product: testProduct),
        ),
      );

      expect(find.text('ADD TO CART'), findsOneWidget);
    });

    testWidgets('displays original price when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductPage(
            product: Product(
              id: 'sale-1',
              title: 'Sale Product',
              price: '£15.00',
              imageUrl: 'assets/sale.png',
            ),
            originalPrice: '£25.00',
          ),
        ),
      );

      // Should show both original and sale price
      expect(find.text('£25.00'), findsOneWidget);
      expect(find.text('£15.00'), findsWidgets);
    });

    testWidgets('has scrollable content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductPage(product: testProduct),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('displays product image', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductPage(product: testProduct),
        ),
      );

      expect(find.byType(Image), findsWidgets);
    });
  });
}
