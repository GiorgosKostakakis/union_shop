import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/views/cart_page.dart';
import 'package:union_shop/models/cart.dart';
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
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('Shopping Cart'), findsOneWidget);
    });

    testWidgets('shows empty cart message when cart is empty', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('GO SHOPPING'), findsOneWidget);
    });

    testWidgets('displays cart items when cart has items', (tester) async {
      setupLargeViewport(tester);
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
      setupLargeViewport(tester);
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
      setupLargeViewport(tester);
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
      setupLargeViewport(tester);
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

      // Items are removed by decrementing quantity to 0
      expect(find.byIcon(Icons.remove_circle_outline), findsAtLeastNWidgets(1));
    });

    testWidgets('has quantity controls for items', (tester) async {
      setupLargeViewport(tester);
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
      expect(find.byIcon(Icons.remove_circle_outline), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.add_circle_outline), findsAtLeastNWidgets(1));
    });

    testWidgets('has checkout button when cart has items', (tester) async {
      setupLargeViewport(tester);
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

      expect(find.text('PROCEED TO CHECKOUT'), findsAtLeastNWidgets(1));
    });

    testWidgets('has scrollable content', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('displays multiple cart items', (tester) async {
      setupLargeViewport(tester);
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

    testWidgets('GO SHOPPING button navigates to home', (tester) async {
      setupLargeViewport(tester);
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(body: Text('Home Page')),
          ),
          GoRoute(
            path: '/cart',
            builder: (context, state) => const CartPage(),
          ),
        ],
        initialLocation: '/cart',
      );

      await tester.pumpWidget(
        MaterialApp.router(routerConfig: router),
      );

      await tester.tap(find.text('GO SHOPPING'));
      await tester.pumpAndSettle();

      expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('increments quantity when + button tapped', (tester) async {
      setupLargeViewport(tester);
      final testProduct = const Product(
        id: 'inc-1',
        title: 'Increment Test',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
        selectedSize: 'M',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      final incrementButton = find.byIcon(Icons.add_circle_outline).first;
      await tester.tap(incrementButton);
      await tester.pump();

      expect(find.text('2'), findsWidgets);
    });

    testWidgets('decrements quantity when - button tapped', (tester) async {
      setupLargeViewport(tester);
      final testProduct = const Product(
        id: 'dec-1',
        title: 'Decrement Test',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 3,
        selectedSize: 'M',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      final decrementButton = find.byIcon(Icons.remove_circle_outline).first;
      await tester.tap(decrementButton);
      await tester.pump();

      expect(find.text('2'), findsWidgets);
    });

    testWidgets('removes item when quantity is 1 and - button tapped', (tester) async {
      setupLargeViewport(tester);
      final testProduct = const Product(
        id: 'rem-1',
        title: 'Remove by Decrement',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
        selectedSize: 'M',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('Remove by Decrement'), findsOneWidget);

      final decrementButton = find.byIcon(Icons.remove_circle_outline).first;
      await tester.tap(decrementButton);
      await tester.pump();

      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('removes item when Remove button tapped', (tester) async {
      setupLargeViewport(tester);
      final testProduct = const Product(
        id: 'rem-2',
        title: 'Remove Button Test',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 2,
        selectedSize: 'M',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('Remove Button Test'), findsOneWidget);

      await tester.tap(find.text('Remove'));
      await tester.pump();

      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('displays size and color for cart items', (tester) async {
      setupLargeViewport(tester);
      final testProduct = const Product(
        id: 'opt-1',
        title: 'Options Test',
        price: '£20.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
        selectedSize: 'XL',
        selectedColor: 'Red',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.textContaining('Size: XL'), findsOneWidget);
      expect(find.textContaining('Color: Red'), findsOneWidget);
    });

    testWidgets('displays only size when color is null', (tester) async {
      setupLargeViewport(tester);
      final testProduct = const Product(
        id: 'opt-2',
        title: 'Size Only',
        price: '£20.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
        selectedSize: 'L',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.textContaining('Size: L'), findsOneWidget);
    });

    testWidgets('displays only color when size is null', (tester) async {
      setupLargeViewport(tester);
      final testProduct = const Product(
        id: 'opt-3',
        title: 'Color Only',
        price: '£20.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
        selectedColor: 'Blue',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.textContaining('Color: Blue'), findsOneWidget);
    });

    testWidgets('displays original price when item is on sale', (tester) async {
      setupLargeViewport(tester);
      final testProduct = const Product(
        id: 'sale-1',
        title: 'Sale Item',
        price: '£15.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
        originalPrice: '£25.00',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('£25.00'), findsWidgets);
      expect(find.text('£15.00'), findsWidgets);
    });

    testWidgets('displays Order Summary section', (tester) async {
      setupLargeViewport(tester);
      final testProduct = const Product(
        id: 'sum-1',
        title: 'Summary Test',
        price: '£30.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
        selectedSize: 'M',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.text('Subtotal:'), findsOneWidget);
      expect(find.text('Delivery:'), findsOneWidget);
      expect(find.text('FREE'), findsOneWidget);
      expect(find.text('Total:'), findsOneWidget);
    });

    testWidgets('uses narrow layout on small screen', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final testProduct = const Product(
        id: 'narrow-1',
        title: 'Narrow Layout',
        price: '£15.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
        selectedSize: 'M',
        selectedColor: 'Green',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('Narrow Layout'), findsOneWidget);
      expect(find.text('£15.00'), findsWidgets);
    });

    testWidgets('narrow layout displays sale price correctly', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final testProduct = const Product(
        id: 'narrow-sale',
        title: 'Narrow Sale Item',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
        originalPrice: '£20.00',
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('£20.00'), findsWidgets);
      expect(find.text('£10.00'), findsWidgets);
    });

    testWidgets('narrow layout has remove button', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final testProduct = const Product(
        id: 'narrow-rem',
        title: 'Narrow Remove',
        price: '£5.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('Remove'), findsOneWidget);
      
      await tester.tap(find.text('Remove'));
      await tester.pump();

      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('narrow layout quantity controls work', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final testProduct = const Product(
        id: 'narrow-qty',
        title: 'Narrow Quantity',
        price: '£8.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 2,
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      await tester.tap(find.byIcon(Icons.add_circle_outline).first);
      await tester.pump();
      expect(find.text('3'), findsWidgets);

      await tester.tap(find.byIcon(Icons.remove_circle_outline).first);
      await tester.pump();
      expect(find.text('2'), findsWidgets);
    });

    testWidgets('displays product image when available', (tester) async {
      setupLargeViewport(tester);
      final testProduct = const Product(
        id: 'img-1',
        title: 'Image Test',
        price: '£15.00',
        imageUrl: 'assets/product1.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('shows icon when imageUrl is empty', (tester) async {
      setupLargeViewport(tester);
      final testProduct = const Product(
        id: 'img-2',
        title: 'Empty Image URL',
        price: '£15.00',
        imageUrl: '',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.byIcon(Icons.image), findsWidgets);
    });

    testWidgets('narrow layout removes item when quantity 1 and - tapped', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final testProduct = const Product(
        id: 'narrow-rem-dec',
        title: 'Narrow Remove Dec',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );
      
      Cart().addItem(
        product: testProduct,
        quantity: 1,
      );

      await tester.pumpWidget(
        const MaterialApp(home: CartPage()),
      );

      expect(find.text('Narrow Remove Dec'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.remove_circle_outline).first);
      await tester.pump();

      expect(find.text('Your cart is empty'), findsOneWidget);
    });
  });
}
