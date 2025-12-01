import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/models/fixtures.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();
  
  group('Header widget', () {
    testWidgets('appears on home and shows navigation items', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.text('PLACEHOLDER HEADER TEXT'), findsWidgets);
      
      // On narrow screens (800px test viewport < 900px), navigation is in drawer
      // Open the menu drawer to access navigation items
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      
      expect(find.text('About Us'), findsOneWidget);
      expect(find.text('Collections'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    }, skip: true);

    testWidgets('appears on About and Collections pages', (tester) async {
      setupLargeViewport(tester);
      // Use UnionShopApp and navigate to pages
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      
      // Open menu drawer to find navigation
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      
      // Find and tap About button
      final aboutButton = find.text('About Us');
      expect(aboutButton, findsOneWidget);
      await tester.tap(aboutButton);
      await tester.pumpAndSettle();
      expect(find.text('PLACEHOLDER HEADER TEXT'), findsOneWidget);

      // Open menu again
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      
      // Go back home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      
      // Open menu again for Collections
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      
      // Find and tap Collections button
      final collectionsButton = find.text('Collections');
      expect(collectionsButton, findsOneWidget);
      await tester.tap(collectionsButton);
      await tester.pumpAndSettle();
      expect(find.text('PLACEHOLDER HEADER TEXT'), findsOneWidget);
    }, skip: true);

    testWidgets('logo tap navigates to home from ProductPage', (tester) async {
      setupLargeViewport(tester);
      // Use UnionShopApp with proper routing
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Scroll to and navigate to a product page first
      final productFinder = find.text('Product A').first;
      await tester.ensureVisible(productFinder);
      await tester.pumpAndSettle();
      await tester.tap(productFinder);
      await tester.pumpAndSettle();

      // On narrow screens, Home is in the drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      
      // Find the Home button in the drawer and tap it
      final homeFinder = find.text('Home');
      expect(homeFinder, findsOneWidget);
      await tester.tap(homeFinder);
      await tester.pumpAndSettle();

      // HomeScreen should be visible after home button tap
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);
    }, skip: true);

    testWidgets('Header is present on CollectionPage with fixtures', (tester) async {
      setupLargeViewport(tester);
      final collection = collections.first;
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Open menu to navigate to collections page
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      
      // Navigate to collections page
      await tester.tap(find.text('Collections'));
      await tester.pumpAndSettle();

      // Navigate to first collection
      await tester.tap(find.text(collection.title).first);
      await tester.pumpAndSettle();

      expect(find.text('PLACEHOLDER HEADER TEXT'), findsOneWidget);
      expect(find.text(collection.title), findsOneWidget);
    }, skip: true);

    testWidgets('displays cart badge when items in cart', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Initially no cart badge should show
      expect(find.text('0'), findsNothing);

      // Navigate to product and add to cart
      await tester.ensureVisible(find.text('Product A').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Product A').first);
      await tester.pumpAndSettle();

      // Add to cart
      await tester.tap(find.text('ADD TO CART'));
      await tester.pumpAndSettle();

      // Cart badge should now show
      expect(find.text('1'), findsOneWidget);
    }, skip: true);

    testWidgets('cart icon navigates to cart page', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Tap cart icon
      await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
      await tester.pumpAndSettle();

      // Should navigate to cart page
      expect(find.text('Shopping Cart'), findsOneWidget);
    });

    testWidgets('person icon is present in header', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Check that person icon exists (outline when not logged in)
      final personIcons = find.byIcon(Icons.person_outline);
      expect(personIcons, findsWidgets);
    });
  });
}
