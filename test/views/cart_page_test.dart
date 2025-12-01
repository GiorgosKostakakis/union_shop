import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/cart_page.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  setUp(() {
    // Clear cart before each test
    Cart().clear();
  });

  group('CartPage Tests', () {
    testWidgets('renders with title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('Shopping Cart'), findsOneWidget);
    });

    testWidgets('shows empty cart message when cart is empty', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('GO SHOPPING'), findsOneWidget);
    });

    testWidgets('displays cart items when cart has items', (tester) async {
      // Add item to cart
      final testProduct = const Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£25.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 2,
        selectedSize: 'M',
        selectedColor: 'Black',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£25.00'), findsWidgets);
    });

    testWidgets('displays quantity for cart items', (tester) async {
      final testProduct = const Product(
        id: 'test-2',
        title: 'Quantity Test',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 3,
        selectedSize: 'L',
        selectedColor: 'Blue',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      // Should show quantity
      expect(find.text('3'), findsWidgets);
    });

    testWidgets('displays cart total', (tester) async {
      final testProduct = const Product(
        id: 'test-3',
        title: 'Total Test',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 2,
        selectedSize: 'M',
        selectedColor: 'Black',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      // Should show total (2 x £10 = £20)
      expect(find.text('£20.00'), findsWidgets);
    });

    testWidgets('has remove button for cart items', (tester) async {
      final testProduct = const Product(
        id: 'test-4',
        title: 'Remove Test',
        price: '£15.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
        selectedSize: 'S',
        selectedColor: 'Red',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      // Should have remove button (close icon)
      expect(find.byIcon(Icons.close), findsAtLeastNWidgets(1));
    });

    testWidgets('has quantity controls for items', (tester) async {
      final testProduct = const Product(
        id: 'test-6',
        title: 'Quantity Controls',
        price: '£12.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 2,
        selectedSize: 'L',
        selectedColor: 'Yellow',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      // Should have increment and decrement buttons
      expect(find.byIcon(Icons.remove), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.add), findsAtLeastNWidgets(1));
    });

    testWidgets('has checkout button when cart has items', (tester) async {
      final testProduct = const Product(
        id: 'test-8',
        title: 'Checkout Test',
        price: '£30.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
        selectedSize: 'XL',
        selectedColor: 'Purple',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('CHECKOUT'), findsAtLeastNWidgets(1));
    });

    testWidgets('has scrollable content', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('displays multiple cart items', (tester) async {
      final product1 = const Product(
        id: 'multi-1',
        title: 'Product One',
        price: '£10.00',
        imageUrl: 'assets/p1.png',
      );
      
      final product2 = const Product(
        id: 'multi-2',
        title: 'Product Two',
        price: '£15.00',
        imageUrl: 'assets/p2.png',
      );
      
      Cart().addItem(
        product: product1,
        quantity: 1,
        selectedSize: 'M',
        selectedColor: 'Black',
      );
      
      Cart().addItem(
        product: product2,
        quantity: 2,
        selectedSize: 'L',
        selectedColor: 'White',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('Product One'), findsOneWidget);
      expect(find.text('Product Two'), findsOneWidget);
      
      // Total should be £10 + (£15 x 2) = £40
      expect(find.text('£40.00'), findsWidgets);
    });
  });
}
