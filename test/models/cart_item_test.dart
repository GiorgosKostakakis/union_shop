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

    test('creates cart item with originalPrice for sale items', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
        selectedSize: 'M',
        selectedColor: 'Blue',
        originalPrice: '£20.00',
      );

      expect(cartItem.originalPrice, equals('£20.00'));
      expect(cartItem.product.id, equals('test-1'));
      expect(cartItem.selectedSize, equals('M'));
      expect(cartItem.selectedColor, equals('Blue'));
    });

    test('copyWith preserves originalPrice when not specified', () {
      final original = CartItem(
        product: testProduct,
        quantity: 1,
        originalPrice: '£20.00',
      );

      final updated = original.copyWith(quantity: 2);
      
      expect(updated.originalPrice, equals('£20.00'));
      expect(updated.quantity, equals(2));
    });

    test('copyWith can set originalPrice to a new value', () {
      final original = CartItem(
        product: testProduct,
        quantity: 1,
      );

      final updated = original.copyWith(originalPrice: '£25.00');
      
      expect(updated.originalPrice, equals('£25.00'));
    });

    test('toJson serializes cart item correctly with all fields', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 3,
        selectedSize: 'L',
        selectedColor: 'Red',
        originalPrice: '£20.00',
      );

      final json = cartItem.toJson();

      expect(json['productId'], equals('test-1'));
      expect(json['productTitle'], equals('Test Product'));
      expect(json['productPrice'], equals('£15.50'));
      expect(json['productImageUrl'], equals('assets/test.png'));
      expect(json['quantity'], equals(3));
      expect(json['selectedSize'], equals('L'));
      expect(json['selectedColor'], equals('Red'));
      expect(json['originalPrice'], equals('£20.00'));
    });

    test('toJson serializes cart item with null optional fields', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 2,
      );

      final json = cartItem.toJson();

      expect(json['productId'], equals('test-1'));
      expect(json['productTitle'], equals('Test Product'));
      expect(json['productPrice'], equals('£15.50'));
      expect(json['quantity'], equals(2));
      expect(json['selectedSize'], isNull);
      expect(json['selectedColor'], isNull);
      expect(json['originalPrice'], isNull);
    });

    test('fromJson deserializes cart item correctly with all fields', () {
      final json = {
        'productId': 'prod-123',
        'productTitle': 'Test Item',
        'productPrice': '£25.99',
        'productImageUrl': 'assets/item.png',
        'productDescription': 'A test description',
        'quantity': 5,
        'selectedSize': 'XL',
        'selectedColor': 'Green',
        'originalPrice': '£30.00',
      };

      final cartItem = CartItem.fromJson(json);

      expect(cartItem.product.id, equals('prod-123'));
      expect(cartItem.product.title, equals('Test Item'));
      expect(cartItem.product.price, equals('£25.99'));
      expect(cartItem.product.imageUrl, equals('assets/item.png'));
      expect(cartItem.product.description, equals('A test description'));
      expect(cartItem.quantity, equals(5));
      expect(cartItem.selectedSize, equals('XL'));
      expect(cartItem.selectedColor, equals('Green'));
      expect(cartItem.originalPrice, equals('£30.00'));
    });

    test('fromJson deserializes cart item with null optional fields', () {
      final json = {
        'productId': 'prod-456',
        'productTitle': 'Simple Item',
        'productPrice': '£10.00',
        'productImageUrl': 'assets/simple.png',
        'quantity': 1,
        'selectedSize': null,
        'selectedColor': null,
        'originalPrice': null,
      };

      final cartItem = CartItem.fromJson(json);

      expect(cartItem.product.id, equals('prod-456'));
      expect(cartItem.product.title, equals('Simple Item'));
      expect(cartItem.product.price, equals('£10.00'));
      expect(cartItem.product.description, equals(''));
      expect(cartItem.quantity, equals(1));
      expect(cartItem.selectedSize, isNull);
      expect(cartItem.selectedColor, isNull);
      expect(cartItem.originalPrice, isNull);
    });

    test('fromJson handles missing productDescription', () {
      final json = {
        'productId': 'prod-789',
        'productTitle': 'No Desc Item',
        'productPrice': '£5.00',
        'productImageUrl': 'assets/nodesc.png',
        'quantity': 2,
      };

      final cartItem = CartItem.fromJson(json);

      expect(cartItem.product.description, equals(''));
    });

    test('toJson and fromJson roundtrip preserves data', () {
      final original = CartItem(
        product: const Product(
          id: 'round-1',
          title: 'Roundtrip Product',
          price: '£15.00',
          imageUrl: 'assets/roundtrip.png',
          description: 'Test description',
        ),
        quantity: 4,
        selectedSize: 'M',
        selectedColor: 'Blue',
        originalPrice: '£18.00',
      );

      final json = original.toJson();
      final reconstructed = CartItem.fromJson(json);

      expect(reconstructed.product.id, equals(original.product.id));
      expect(reconstructed.product.title, equals(original.product.title));
      expect(reconstructed.product.price, equals(original.product.price));
      expect(reconstructed.product.imageUrl, equals(original.product.imageUrl));
      expect(reconstructed.quantity, equals(original.quantity));
      expect(reconstructed.selectedSize, equals(original.selectedSize));
      expect(reconstructed.selectedColor, equals(original.selectedColor));
      expect(reconstructed.originalPrice, equals(original.originalPrice));
    });
  });
}
