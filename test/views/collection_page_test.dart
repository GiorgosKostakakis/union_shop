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

    testWidgets('has sort dropdown with Low and High options', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: testCollection),
        ),
      );

      // Verify sort dropdown exists
      final sortDropdown = find.byType(DropdownButton<String>);
      expect(sortDropdown, findsOneWidget);
      
      // Verify dropdown has Low and High options
      final dropdownWidget = tester.widget<DropdownButton<String>>(sortDropdown);
      expect(dropdownWidget.items, isNotNull);
      final itemValues = dropdownWidget.items!.map((item) => item.value).toList();
      expect(itemValues, contains('Low'));
      expect(itemValues, contains('High'));
    });

    testWidgets('product cards have GestureDetector for navigation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: testCollection),
        ),
      );

      // Verify GestureDetector exists for product navigation
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('sorts products by price low to high', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: testCollection),
        ),
      );

      // Open dropdown and select Low
      final dropdown = find.byType(DropdownButton<String>);
      await tester.ensureVisible(dropdown);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      final lowOption = find.text('Price: Low to High').last;
      await tester.ensureVisible(lowOption);
      await tester.tap(lowOption);
      await tester.pumpAndSettle();

      // Products should be sorted by price low to high
      // Verify the dropdown value changed
      final dropdownWidget = tester.widget<DropdownButton<String>>(dropdown);
      expect(dropdownWidget.value, 'Low');
    });

    testWidgets('sorts products by price high to low', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: testCollection),
        ),
      );

      // Open dropdown and select High
      final dropdown = find.byType(DropdownButton<String>);
      await tester.ensureVisible(dropdown);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      final highOption = find.text('Price: High to Low').last;
      await tester.ensureVisible(highOption);
      await tester.tap(highOption);
      await tester.pumpAndSettle();

      // Verify the dropdown value changed
      final dropdownWidget = tester.widget<DropdownButton<String>>(dropdown);
      expect(dropdownWidget.value, 'High');
    });

    testWidgets('sorts products by name', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: testCollection),
        ),
      );

      // Open dropdown and select Name
      final dropdown = find.byType(DropdownButton<String>);
      await tester.ensureVisible(dropdown);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      final nameOption = find.text('Name');
      await tester.ensureVisible(nameOption);
      await tester.tap(nameOption);
      await tester.pumpAndSettle();

      // Verify the dropdown value changed
      final dropdownWidget = tester.widget<DropdownButton<String>>(dropdown);
      expect(dropdownWidget.value, 'Name');
    });

    testWidgets('shows no products message when search has no results', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: testCollection),
        ),
      );

      // Search for non-existent product
      final searchField = find.byType(TextField).first;
      await tester.enterText(searchField, 'NonexistentProduct');
      await tester.pump();

      // Should show "No products found" message
      expect(find.text('No products found matching your search.'), findsOneWidget);
    });

    testWidgets('shows placeholder products when collection is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CollectionPage(collection: null),
        ),
      );

      // Should show placeholder products
      expect(find.text('Product name'), findsWidgets);
      expect(find.text('£10.00'), findsWidgets);
    });

    testWidgets('displays collection title or default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CollectionPage(collection: null),
        ),
      );

      expect(find.text('Collection'), findsOneWidget);
    });

    testWidgets('handles image error with fallback icon', (tester) async {
      final collectionWithBadImages = Collection(
        id: 'test-bad',
        title: 'Bad Images',
        imageUrl: 'bad.png',
        products: [
          const Product(
            id: 'bad-1',
            title: 'Bad Image Product',
            price: '£5.00',
            imageUrl: 'nonexistent.png',
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CollectionPage(collection: collectionWithBadImages),
        ),
      );
      await tester.pump();

      // Product image should be present (even if error builder shows)
      expect(find.byType(Image), findsWidgets);
    });
  });
}
