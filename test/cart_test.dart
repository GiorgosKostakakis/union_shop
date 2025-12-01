import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Cart Model Tests', () {
    late Cart cart;

    setUp(() {
      cart = Cart();
      // Clear cart before each test
      cart.clear();
    });

    test('Cart starts empty', () {
      expect(cart.items, isEmpty);
      expect(cart.itemCount, 0);
      expect(cart.uniqueItemCount, 0);
      expect(cart.totalAmount, 0.0);
    });

    test('Can add item to cart', () {
      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      cart.addItem(product: product);

      expect(cart.items, hasLength(1));
      expect(cart.itemCount, 1);
      expect(cart.uniqueItemCount, 1);
      expect(cart.totalAmount, 10.0);
      expect(cart.items.first.product.id, 'test-1');
    });

    test('Can add multiple quantities of same item', () {
      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      cart.addItem(product: product, quantity: 3);

      expect(cart.items, hasLength(1));
      expect(cart.itemCount, 3);
      expect(cart.uniqueItemCount, 1);
      expect(cart.totalAmount, 30.0);
    });

    test('Adding same item again increases quantity', () {
      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      cart.addItem(product: product, quantity: 2);
      cart.addItem(product: product, quantity: 1);

      expect(cart.items, hasLength(1));
      expect(cart.itemCount, 3);
      expect(cart.totalAmount, 30.0);
    });

    test('Can add different products', () {
      const product1 = Product(
        id: 'test-1',
        title: 'Product 1',
        price: '£10.00',
        imageUrl: 'assets/test1.png',
      );
      const product2 = Product(
        id: 'test-2',
        title: 'Product 2',
        price: '£15.00',
        imageUrl: 'assets/test2.png',
      );

      cart.addItem(product: product1);
      cart.addItem(product: product2);

      expect(cart.items, hasLength(2));
      expect(cart.uniqueItemCount, 2);
      expect(cart.itemCount, 2);
      expect(cart.totalAmount, 25.0);
    });

    test('Same product with different options creates separate cart items', () {
      const product = Product(
        id: 'test-1',
        title: 'T-Shirt',
        price: '£20.00',
        imageUrl: 'assets/shirt.png',
      );

      cart.addItem(product: product, selectedSize: 'M', selectedColor: 'Blue');
      cart.addItem(product: product, selectedSize: 'L', selectedColor: 'Blue');
      cart.addItem(product: product, selectedSize: 'M', selectedColor: 'Red');

      expect(cart.items, hasLength(3));
      expect(cart.uniqueItemCount, 3);
      expect(cart.itemCount, 3);
      expect(cart.totalAmount, 60.0);
    });

    test('Can remove item from cart', () {
      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      cart.addItem(product: product);
      final key = cart.items.first.key;

      expect(cart.items, hasLength(1));

      cart.removeItem(key);

      expect(cart.items, isEmpty);
      expect(cart.itemCount, 0);
      expect(cart.totalAmount, 0.0);
    });

    test('Can increment quantity', () {
      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      cart.addItem(product: product, quantity: 1);
      final key = cart.items.first.key;

      cart.incrementQuantity(key);

      expect(cart.itemCount, 2);
      expect(cart.totalAmount, 20.0);
    });

    test('Can decrement quantity', () {
      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      cart.addItem(product: product, quantity: 3);
      final key = cart.items.first.key;

      cart.decrementQuantity(key);

      expect(cart.itemCount, 2);
      expect(cart.totalAmount, 20.0);
    });

    test('Decrementing quantity to 0 removes item', () {
      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      cart.addItem(product: product, quantity: 1);
      final key = cart.items.first.key;

      cart.decrementQuantity(key);

      expect(cart.items, isEmpty);
      expect(cart.itemCount, 0);
    });

    test('Can update quantity directly', () {
      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      cart.addItem(product: product, quantity: 1);
      final key = cart.items.first.key;

      cart.updateQuantity(key, 5);

      expect(cart.itemCount, 5);
      expect(cart.totalAmount, 50.0);
    });

    test('Updating quantity to 0 removes item', () {
      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      cart.addItem(product: product);
      final key = cart.items.first.key;

      cart.updateQuantity(key, 0);

      expect(cart.items, isEmpty);
    });

    test('Can clear entire cart', () {
      const product1 = Product(
        id: 'test-1',
        title: 'Product 1',
        price: '£10.00',
        imageUrl: 'assets/test1.png',
      );
      const product2 = Product(
        id: 'test-2',
        title: 'Product 2',
        price: '£15.00',
        imageUrl: 'assets/test2.png',
      );

      cart.addItem(product: product1, quantity: 2);
      cart.addItem(product: product2, quantity: 3);

      expect(cart.items, hasLength(2));

      cart.clear();

      expect(cart.items, isEmpty);
      expect(cart.itemCount, 0);
      expect(cart.totalAmount, 0.0);
    });

    test('Can check if product is in cart', () {
      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      expect(cart.isInCart(productId: 'test-1'), false);

      cart.addItem(product: product, selectedSize: 'M');

      expect(cart.isInCart(productId: 'test-1', selectedSize: 'M'), true);
      expect(cart.isInCart(productId: 'test-1', selectedSize: 'L'), false);
    });

    test('Total amount calculates correctly with mixed prices', () {
      const product1 = Product(
        id: 'test-1',
        title: 'Product 1',
        price: '£12.50',
        imageUrl: 'assets/test1.png',
      );
      const product2 = Product(
        id: 'test-2',
        title: 'Product 2',
        price: '£8.75',
        imageUrl: 'assets/test2.png',
      );

      cart.addItem(product: product1, quantity: 2); // 25.00
      cart.addItem(product: product2, quantity: 3); // 26.25

      expect(cart.totalAmount, closeTo(51.25, 0.01));
    });

    test('Listener is notified when items are added', () {
      var notifiedCount = 0;
      void listener() {
        notifiedCount++;
      }

      cart.addListener(listener);

      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      cart.addItem(product: product);

      expect(notifiedCount, 1);

      cart.removeListener(listener);
    });

    test('Listener is notified when items are removed', () {
      var notifiedCount = 0;
      void listener() {
        notifiedCount++;
      }

      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      cart.addItem(product: product);
      final key = cart.items.first.key;

      cart.addListener(listener);
      cart.removeItem(key);

      expect(notifiedCount, 1);

      cart.removeListener(listener);
    });

    test('Multiple listeners are all notified', () {
      var count1 = 0, count2 = 0;
      void listener1() {
        count1++;
      }

      void listener2() {
        count2++;
      }

      cart.addListener(listener1);
      cart.addListener(listener2);

      const product = Product(
        id: 'test-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );

      cart.addItem(product: product);

      expect(count1, 1);
      expect(count2, 1);

      cart.removeListener(listener1);
      cart.removeListener(listener2);
    });
  });
}
