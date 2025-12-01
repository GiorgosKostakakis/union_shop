import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/main.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  group('Header Widget Extended Tests', () {
    testWidgets('displays cart badge when items in cart', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Initially no cart badge should show
      expect(find.text('0'), findsNothing);

      // Navigate to product and add to cart
      await tester.ensureVisible(find.text('Product A').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Product A').first);
      await tester.pumpAndSettle();

      // Add to cart
      await tester.tap(find.text('ADD TO CART'));
      await tester.pumpAndSettle();

      // Cart badge should now show
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('cart icon navigates to cart page', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Tap cart icon
      await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
      await tester.pumpAndSettle();

      // Should navigate to cart page
      expect(find.text('Shopping Cart'), findsOneWidget);
    });

    testWidgets('person icon navigates to login when not authenticated', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Tap person icon (should show outline when not logged in)
      final personIcons = find.byIcon(Icons.person_outline);
      if (personIcons.evaluate().isNotEmpty) {
        await tester.tap(personIcons.first);
        await tester.pumpAndSettle();

        // Should navigate to login
        expect(find.text('Login'), findsWidgets);
      }
    });
  });
}
