import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/models/fixtures.dart';
import 'test_helpers.dart';

void main() {
  setupFirebaseMocks();
  
  group('Header widget', () {
    testWidgets('appears on home and shows navigation items', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

  expect(find.text('PLACEHOLDER HEADER TEXT'), findsWidgets);
      expect(find.text('About Us'), findsOneWidget);
      expect(find.text('Collections'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('appears on About and Collections pages', (tester) async {
      // Use UnionShopApp and navigate to pages
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      
      // Find and tap About button
      final aboutButton = find.text('About Us');
      expect(aboutButton, findsOneWidget);
      await tester.tap(aboutButton);
      await tester.pumpAndSettle();
      expect(find.text('PLACEHOLDER HEADER TEXT'), findsOneWidget);

      // Go back home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      
      // Find and tap Collections button
      final collectionsButton = find.text('Collections');
      expect(collectionsButton, findsOneWidget);
      await tester.tap(collectionsButton);
      await tester.pumpAndSettle();
      expect(find.text('PLACEHOLDER HEADER TEXT'), findsOneWidget);
    });

    testWidgets('logo tap navigates to home from ProductPage', (tester) async {
      // Use UnionShopApp with proper routing
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Scroll to and navigate to a product page first
      final productFinder = find.text('Product A').first;
      await tester.ensureVisible(productFinder);
      await tester.pumpAndSettle();
      await tester.tap(productFinder);
      await tester.pumpAndSettle();

      // Find the Home button in the header and tap it
      final homeFinder = find.text('Home');
      expect(homeFinder, findsOneWidget);
      await tester.tap(homeFinder);
      await tester.pumpAndSettle();

      // HomeScreen should be visible after home button tap
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);
    });

    testWidgets('Header is present on CollectionPage with fixtures', (tester) async {
      final collection = collections.first;
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Navigate to collections page
      await tester.tap(find.text('Collections'));
      await tester.pumpAndSettle();

      // Navigate to first collection
      await tester.tap(find.text(collection.title).first);
      await tester.pumpAndSettle();

      expect(find.text('PLACEHOLDER HEADER TEXT'), findsOneWidget);
      expect(find.text(collection.title), findsOneWidget);
    });
  });
}
