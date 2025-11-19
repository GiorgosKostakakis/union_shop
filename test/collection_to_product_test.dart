import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/collection_page.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/models/fixtures.dart';
import 'package:union_shop/models/product.dart';

void main() {
  testWidgets('tapping a product in CollectionPage opens ProductPage with details', (
    tester,
  ) async {
    final collection = collections.first;

    await tester.pumpWidget(MaterialApp(
      initialRoute: '/collection',
      routes: {
        '/collection': (c) => CollectionPage(collection: collection),
        '/product': (c) {
          final args = ModalRoute.of(c)?.settings.arguments;
          if (args is Product) {
            return ProductPage(product: args);
          }
          return const ProductPage();
        }
      },
    ));

    await tester.pumpAndSettle();

    // Ensure collection title is present
    expect(find.text(collection.title), findsOneWidget);

    // Tap the first product
    final firstProductTitle = collection.products.first.title;
    expect(find.text(firstProductTitle), findsOneWidget);
    await tester.tap(find.text(firstProductTitle));
    await tester.pumpAndSettle();

    // ProductPage should display product title and price
    expect(find.text(firstProductTitle), findsOneWidget);
    expect(find.text(collection.products.first.price), findsOneWidget);
  });
}
