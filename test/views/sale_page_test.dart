import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/views/sale_page.dart';
import 'package:union_shop/models/fixtures.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  group('SalePage Tests', () {
    testWidgets('renders sale banner', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SalePage()),
      );

      expect(find.text('BIG SALE — Limited time offers'), findsOneWidget);
      expect(find.byKey(const Key('saleBanner')), findsOneWidget);
    });

    testWidgets('displays all sale items', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SalePage()),
      );

      // Should display sale items from fixtures
      expect(saleItems.length, greaterThan(0));
      
      // Check that at least some sale items are rendered
      for (var item in saleItems) {
        final product = item['product'];
        expect(find.text(product.title), findsWidgets);
      }
    });

    testWidgets('uses narrow layout for small screens', (tester) async {
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(home: SalePage()),
      );
      await tester.pump();

      // Verify GridView exists
      expect(find.byType(GridView), findsOneWidget);

      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('uses wide layout for large screens', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(home: SalePage()),
      );
      await tester.pump();

      // Verify GridView exists
      expect(find.byType(GridView), findsOneWidget);

      addTearDown(() => tester.view.resetPhysicalSize());
    });

    testWidgets('displays discount percentages', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SalePage()),
      );

      // Check for discount badges
      for (var item in saleItems) {
        final discountPercent = item['discountPercent'];
        expect(find.textContaining('$discountPercent%'), findsWidgets);
      }
    });

    testWidgets('displays original and sale prices', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SalePage()),
      );

      // Check that prices are displayed
      expect(find.textContaining('£'), findsWidgets);
    });

    testWidgets('has scrollable content', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SalePage()),
      );

      // Verify SingleChildScrollView exists for scrolling
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('product cards have GestureDetector for navigation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SalePage()),
      );

      // Verify GestureDetector exists for product navigation
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('tapping a product navigates with sale price and original price', (tester) async {
      String? navigatedRoute;
      Object? navigatedExtra;

      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const SalePage(),
          ),
          GoRoute(
            path: '/sale/products/:id',
            builder: (context, state) {
              navigatedRoute = state.uri.toString();
              navigatedExtra = state.extra;
              return const Scaffold(body: Text('Product Page'));
            },
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      // Find and tap the first sale product
      final firstProductTile = find.byKey(const Key('saleProductTile_0'));
      expect(firstProductTile, findsOneWidget);

      await tester.tap(firstProductTile);
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(navigatedRoute, isNotNull);
      expect(navigatedRoute, contains('/sale/products/'));
      
      // Verify extra data contains both product and original price
      expect(navigatedExtra, isA<Map>());
      final extra = navigatedExtra as Map;
      expect(extra.containsKey('product'), isTrue);
      expect(extra.containsKey('originalPrice'), isTrue);
      expect(extra['originalPrice'], startsWith('£'));
    });
  });
}
