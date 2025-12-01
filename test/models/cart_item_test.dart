import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('CartItem Model Tests', () {
    const testProduct = Product(
      id: 'test-1',
      title: 'Test Product',
      price: '£15.50',
      imageUrl: 'assets/test.png',
    );

    test('totalPrice calculates correctly', () {
      final cartItem = CartItem(product: testProduct, quantity: 3);
      expect(cartItem.totalPrice, closeTo(46.50, 0.01));
    });

    test('totalPrice handles invalid price format', () {
      const invalidProduct = Product(
        id: 'test-2',
        title: 'Invalid Product',
        price: 'invalid',
        imageUrl: 'assets/test.png',
      );
      final cartItem = CartItem(product: invalidProduct, quantity: 2);
      expect(cartItem.totalPrice, equals(0.0));
    });

    test('key generates unique identifier with all options', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
        selectedSize: 'M',
        selectedColor: 'Blue',
      );
      expect(cartItem.key, equals('test-1_M_Blue'));
    });

    test('key generates correctly with no options', () {
      final cartItem = CartItem(product: testProduct, quantity: 1);
      expect(cartItem.key, equals('test-1_nosize_nocolor'));
    });

    test('copyWith creates new instance with updated values', () {
      final original = CartItem(
        product: testProduct,
        quantity: 1,
        selectedSize: 'M',
        selectedColor: 'Blue',
      );

      final updated = original.copyWith(quantity: 3);
      
      expect(updated.quantity, equals(3));
      expect(updated.selectedSize, equals('M'));
      expect(updated.selectedColor, equals('Blue'));
      expect(updated.product.id, equals('test-1'));
    });

    test('copyWith updates all fields', () {
      const newProduct = Product(
        id: 'new-1',
        title: 'New Product',
        price: '£20.00',
        imageUrl: 'assets/new.png',
      );

      final original = CartItem(product: testProduct, quantity: 1);
      final updated = original.copyWith(
        product: newProduct,
        quantity: 5,
        selectedSize: 'L',
        selectedColor: 'Red',
        originalPrice: '£25.00',
      );

      expect(updated.product.id, equals('new-1'));
      expect(updated.quantity, equals(5));
      expect(updated.selectedSize, equals('L'));
      expect(updated.selectedColor, equals('Red'));
      expect(updated.originalPrice, equals('£25.00'));
    });
  });
}
