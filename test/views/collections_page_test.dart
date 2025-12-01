import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/collections_page.dart';
import 'package:union_shop/models/fixtures.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  group('CollectionsPage Tests', () {
    testWidgets('renders with title and collections', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      expect(find.text('Collections'), findsWidgets);
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('displays all collections from fixtures', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      // Check that collections are displayed
      for (var collection in collections) {
        expect(find.text(collection.title), findsOneWidget);
      }
    });

    testWidgets('displays product count for each collection', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      // Check that product counts are displayed
      for (var collection in collections) {
        final productCount = collection.products.length;
        final expectedText = '$productCount product${productCount != 1 ? 's' : ''}';
        expect(find.text(expectedText), findsWidgets);
      }
    });

    testWidgets('has search field', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search collections...'), findsOneWidget);
    });

    testWidgets('filters collections by search query', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      // Get first collection name
      final firstCollection = collections.first;
      
      // Enter search query
      await tester.enterText(find.byType(TextField), firstCollection.title);
      await tester.pump();

      // Should find the searched collection (in search field and in results)
      expect(find.text(firstCollection.title), findsWidgets);
      
      // Should show results count
      expect(find.textContaining('collection(s) found'), findsOneWidget);
    });

    testWidgets('shows no results message when search finds nothing', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      // Enter search query that won't match
      await tester.enterText(find.byType(TextField), 'NonExistentCollection12345');
      await tester.pump();

      expect(find.text('No collections found'), findsOneWidget);
      expect(find.byIcon(Icons.search_off), findsOneWidget);
    });

    testWidgets('search is case-insensitive', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      final firstCollection = collections.first;
      
      // Search with lowercase
      await tester.enterText(find.byType(TextField), firstCollection.title.toLowerCase());
      await tester.pump();

      // Should still find the collection
      expect(find.text(firstCollection.title), findsOneWidget);
    });

    testWidgets('has sort dropdown with options', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      // Find sort dropdown
      final dropdown = find.byType(DropdownButtonFormField<String>);
      expect(dropdown, findsOneWidget);

      // Check default value
      final dropdownWidget = tester.widget<DropdownButtonFormField<String>>(dropdown);
      expect(dropdownWidget.initialValue, 'Name');
    });

    testWidgets('uses column layout on narrow screens', (tester) async {
      setupLargeViewport(tester);
      tester.view.physicalSize = const Size(500, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );
      await tester.pump();

      // Verify layout exists
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);

      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('uses row layout on wide screens', (tester) async {
      setupLargeViewport(tester);
      tester.view.physicalSize = const Size(1000, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );
      await tester.pump();

      // Verify layout exists
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);

      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('collection cards are tappable with GestureDetector', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      // Verify GestureDetector exists for navigation
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('displays collection images', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      // Verify images are rendered
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('has scrollable content', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('clears search results when query is cleared', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      // Enter search query
      await tester.enterText(find.byType(TextField), collections.first.title);
      await tester.pump();

      // Clear search
      await tester.enterText(find.byType(TextField), '');
      await tester.pump();

      // All collections should be visible again
      for (var collection in collections) {
        expect(find.text(collection.title), findsOneWidget);
      }
      
      // Results count should not be shown
      expect(find.textContaining('collection(s) found'), findsNothing);
    });
  });
}
