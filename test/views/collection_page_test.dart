import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/collection_page.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  final testProducts = [
    const Product(
      id: 'test-1',
      title: 'Test Product A',
      price: '£15.00',
      imageUrl: 'assets/test1.png',
    ),
    const Product(
      id: 'test-2',
      title: 'Test Product B',
      price: '£25.00',
      imageUrl: 'assets/test2.png',
    ),
    const Product(
      id: 'test-3',
      title: 'Another Item',
      price: '£10.00',
      imageUrl: 'assets/test3.png',
    ),
  ];

  final testCollection = Collection(
    id: 'test-collection',
    title: 'Test Collection',
    imageUrl: 'assets/test.png',
    products: testProducts,
  );

  group('CollectionPage Tests', () {
    testWidgets('renders with collection data', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: testCollection),
        ),
      );

      expect(find.text('Test Collection'), findsOneWidget);
    });

    testWidgets('displays all products in collection', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: testCollection),
        ),
      );

      expect(find.text('Test Product A'), findsOneWidget);
      expect(find.text('Test Product B'), findsOneWidget);
      expect(find.text('Another Item'), findsOneWidget);
    });

    testWidgets('filters products by search query', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: testCollection),
        ),
      );

      // Find and enter text in search field
      final searchField = find.byType(TextField).first;
      await tester.enterText(searchField, 'Product');
      await tester.pump();

      // Should show products with "Product" in title
      expect(find.text('Test Product A'), findsOneWidget);
      expect(find.text('Test Product B'), findsOneWidget);
      expect(find.text('Another Item'), findsNothing);
    });

    testWidgets('handles null collection gracefully', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CollectionPage(collection: null),
        ),
      );

      // Should render without crashing
      expect(find.byType(CollectionPage), findsOneWidget);
    });

    testWidgets('clears search query when cleared', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: testCollection),
        ),
      );

      // Enter search query
      final searchField = find.byType(TextField).first;
      await tester.enterText(searchField, 'Product');
      await tester.pump();

      // Clear search
      await tester.enterText(searchField, '');
      await tester.pump();

      // All products should be visible again
      expect(find.text('Test Product A'), findsOneWidget);
      expect(find.text('Test Product B'), findsOneWidget);
      expect(find.text('Another Item'), findsOneWidget);
    });

    testWidgets('search is case-insensitive', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: testCollection),
        ),
      );

      // Search with lowercase
      final searchField = find.byType(TextField).first;
      await tester.enterText(searchField, 'product');
      await tester.pump();

      // Should find products regardless of case
      expect(find.text('Test Product A'), findsOneWidget);
      expect(find.text('Test Product B'), findsOneWidget);
    });

    testWidgets('has scrollable content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: testCollection),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
