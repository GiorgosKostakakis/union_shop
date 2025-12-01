import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/models/fixtures.dart';
import 'test_helpers.dart';

void main() {
  setupFirebaseMocks();
  testWidgets('product options update local state', (tester) async {
    final product = products.first;

    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Scroll to and navigate to first product
    final productFinder = find.text(product.title).first;
    await tester.ensureVisible(productFinder);
    await tester.pumpAndSettle();
    await tester.tap(productFinder);
    await tester.pumpAndSettle();

    // Initial quantity is 1
    expect(find.byKey(const Key('qtyText')), findsOneWidget);
    expect(find.text('1'), findsWidgets);

    // Ensure the quantity increment button is visible and tap it
    await tester.ensureVisible(find.byKey(const Key('qtyIncrement')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('qtyIncrement')));
    await tester.pumpAndSettle();
    expect(find.text('2'), findsWidgets);

    // Scroll to ensure dropdown is visible
    await tester.ensureVisible(find.byKey(const Key('sizeDropdown')));
    await tester.pumpAndSettle();
    
    // Change size to L
    await tester.tap(find.byKey(const Key('sizeDropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('L').last);
    await tester.pumpAndSettle();
    
    // The summary text includes 'Size: L' as a substring; verify via a predicate
    expect(
      find.byWidgetPredicate((w) =>
          w is Text && (w.data ?? '').contains('Size: L')),
      findsOneWidget,
    );
  });
}
