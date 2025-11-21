import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/models/fixtures.dart';

void main() {
  testWidgets('product options update local state', (tester) async {
    final product = products.first;

    await tester.pumpWidget(MaterialApp(home: ProductPage(product: product)));
    await tester.pumpAndSettle();

    // Initial quantity is 1
    expect(find.byKey(const Key('qtyText')), findsOneWidget);
    expect(find.text('1'), findsWidgets);

  // Increment quantity (ensure the control is visible first)
  await tester.ensureVisible(find.byKey(const Key('qtyIncrement')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('qtyIncrement')));
  await tester.pumpAndSettle();
  expect(find.text('2'), findsWidgets);

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
