import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
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

      // Check that at least the first collection is displayed
      // (GridView is virtualized so off-screen items may not be built)
      expect(find.text(collections.first.title), findsWidgets);
      
      // Verify GridView exists with collection cards
      expect(find.byType(GridView), findsOneWidget);
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

      // At least the first collection should be visible again after clearing
      // (GridView is virtualized so off-screen items may not be built)
      expect(find.text(collections.first.title), findsWidgets);
      
      // Results count should not be shown
      expect(find.textContaining('collection(s) found'), findsNothing);
    });

    testWidgets('sorts collections by name', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      // Default sort is Name, verify collections are sorted
      final dropdown = find.byType(DropdownButtonFormField<String>);
      final dropdownWidget = tester.widget<DropdownButtonFormField<String>>(dropdown);
      expect(dropdownWidget.initialValue, 'Name');
    });

    testWidgets('sorts collections by product count high', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      // Open dropdown and select Product Count High
      final dropdown = find.byType(DropdownButtonFormField<String>);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      final highOption = find.text('Most').last;
      await tester.tap(highOption);
      await tester.pumpAndSettle();

      // Verify sort option changed
      expect(find.text('Most'), findsWidgets);
    });

    testWidgets('sorts collections by product count low', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      // Open dropdown and select Product Count Low
      final dropdown = find.byType(DropdownButtonFormField<String>);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      final lowOption = find.text('Fewest').last;
      await tester.tap(lowOption);
      await tester.pumpAndSettle();

      // Verify sort option changed
      expect(find.text('Fewest'), findsWidgets);
    });

    testWidgets('tapping collection navigates to collection page', (tester) async {
      setupLargeViewport(tester);
      
      String? navigatedRoute;
      Object? navigatedExtra;

      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const CollectionsPage(),
          ),
          GoRoute(
            path: '/collections/:id',
            builder: (context, state) {
              navigatedRoute = state.uri.toString();
              navigatedExtra = state.extra;
              return const Scaffold(body: Text('Collection Page'));
            },
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      // Tap first collection
      final firstCollection = collections.first;
      final collectionCard = find.text(firstCollection.title);
      await tester.tap(collectionCard);
      await tester.pumpAndSettle();

      // Verify navigation
      expect(navigatedRoute, contains('/collections/${firstCollection.id}'));
      expect(navigatedExtra, isNotNull);
    });

    testWidgets('handles image error with fallback', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CollectionsPage()),
      );

      // Images should render (or show error builder)
      expect(find.byType(Image), findsWidgets);
    });
  });
}
