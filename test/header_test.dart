import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/collection_page.dart';
import 'package:union_shop/models/fixtures.dart';

void main() {
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
      await tester.pumpWidget(const MaterialApp(home: AboutPage()));
      await tester.pumpAndSettle();
  expect(find.text('PLACEHOLDER HEADER TEXT'), findsWidgets);

      await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));
      await tester.pumpAndSettle();
  expect(find.text('PLACEHOLDER HEADER TEXT'), findsWidgets);
    });

    testWidgets('logo tap navigates to home from ProductPage', (tester) async {
      // Provide named routes so the Header navigation works correctly
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/product',
        routes: {
          '/': (c) => const HomeScreen(),
          '/product': (c) => const ProductPage(),
        },
      ));
      await tester.pumpAndSettle();

      // Find the logo asset and tap it
      final logoFinder = find.byWidgetPredicate((widget) {
        return widget is Image && widget.image is AssetImage &&
            (widget.image as AssetImage).assetName == 'assets/logo.png';
      });

  expect(logoFinder, findsOneWidget);
  await tester.ensureVisible(logoFinder);
  await tester.pumpAndSettle();
  await tester.tap(logoFinder, warnIfMissed: false);
      await tester.pumpAndSettle();

      // HomeScreen should be visible after logo tap
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);
    });

    testWidgets('Header is present on CollectionPage with fixtures', (tester) async {
      final collection = collections.first;
      await tester.pumpWidget(MaterialApp(home: CollectionPage(collection: collection)));
      await tester.pumpAndSettle();

  expect(find.text('PLACEHOLDER HEADER TEXT'), findsWidgets);
      expect(find.text(collection.title), findsOneWidget);
    });
  });
}
