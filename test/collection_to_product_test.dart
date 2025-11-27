import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/models/fixtures.dart';

void main() {
  testWidgets('tapping a product in CollectionPage opens ProductPage with details', (
    tester,
  ) async {
    final collection = collections.first;

    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Navigate to Collections
    await tester.tap(find.text('Collections'));
    await tester.pumpAndSettle();

    // Navigate to first collection
    await tester.tap(find.text(collection.title).first);
    await tester.pumpAndSettle();

    // Ensure collection title is present
    expect(find.text(collection.title), findsWidgets);

    // Scroll to and tap the first product
    final firstProductTitle = collection.products.first.title;
    final productFinder = find.text(firstProductTitle);
    expect(productFinder, findsWidgets);
    
    // Ensure the product is visible before tapping
    await tester.ensureVisible(productFinder.first);
    await tester.pumpAndSettle();
    
    await tester.tap(productFinder.first, warnIfMissed: false);
    await tester.pumpAndSettle();

    // ProductPage should display product title and price
    expect(find.text(firstProductTitle), findsWidgets);
    expect(find.text(collection.products.first.price), findsWidgets);
  });
}
