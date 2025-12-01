import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'test_helpers.dart';

void main() {
  setupFirebaseMocks();
  
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Check that basic UI elements are present
      expect(
        find.text('PLACEHOLDER HEADER TEXT'),
        findsOneWidget,
      );
      expect(find.text('Placeholder Hero Title'), findsOneWidget);
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);
      expect(find.text('BROWSE PRODUCTS'), findsOneWidget);
    });

    testWidgets('should display product cards', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Check that product cards are displayed (using actual fixture data)
      expect(find.text('Product A'), findsOneWidget);
      expect(find.text('Product B'), findsOneWidget);
      expect(find.text('Product C'), findsOneWidget);
      expect(find.text('Product D'), findsOneWidget);

      // Check prices are displayed (from fixtures)
      expect(find.text('£10.00'), findsOneWidget);
      expect(find.text('£12.50'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
    });

    testWidgets('should display header icons', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Check that header icons are present
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Check that footer is present
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Help & Info'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);
    });
  });
}
