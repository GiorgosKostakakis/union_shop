import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/order.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Order Model Tests', () {
    final testProducts = [
      const Product(
        id: 'prod-1',
        title: 'Test Product 1',
        price: '£10.00',
        imageUrl: 'assets/test1.png',
      ),
      const Product(
        id: 'prod-2',
        title: 'Test Product 2',
        price: '£20.00',
        imageUrl: 'assets/test2.png',
      ),
    ];

    final testItems = [
      CartItem(product: testProducts[0], quantity: 2),
      CartItem(product: testProducts[1], quantity: 1),
    ];

    test('creates order with all required fields', () {
      final timestamp = DateTime(2024, 12, 1, 14, 30);
      final order = Order(
        id: 'order-123',
        userId: 'user-456',
        items: testItems,
        total: 40.00,
        timestamp: timestamp,
      );

      expect(order.id, equals('order-123'));
      expect(order.userId, equals('user-456'));
      expect(order.items, equals(testItems));
      expect(order.total, equals(40.00));
      expect(order.timestamp, equals(timestamp));
    });

    test('itemCount returns total quantity of all items', () {
      final order = Order(
        id: 'order-123',
        userId: 'user-456',
        items: testItems,
        total: 40.00,
        timestamp: DateTime.now(),
      );

      // 2 + 1 = 3 items total
      expect(order.itemCount, equals(3));
    });

    test('itemCount returns 0 for empty order', () {
      final order = Order(
        id: 'order-123',
        userId: 'user-456',
        items: [],
        total: 0.00,
        timestamp: DateTime.now(),
      );

      expect(order.itemCount, equals(0));
    });

    test('itemCount with single item', () {
      final singleItem = [CartItem(product: testProducts[0], quantity: 5)];
      final order = Order(
        id: 'order-123',
        userId: 'user-456',
        items: singleItem,
        total: 50.00,
        timestamp: DateTime.now(),
      );

      expect(order.itemCount, equals(5));
    });

    test('formattedDate returns properly formatted date string', () {
      final timestamp = DateTime(2024, 12, 25, 9, 5);
      final order = Order(
        id: 'order-123',
        userId: 'user-456',
        items: testItems,
        total: 40.00,
        timestamp: timestamp,
      );

      expect(order.formattedDate, equals('25/12/2024 9:05'));
    });

    test('formattedDate pads minutes with zero', () {
      final timestamp = DateTime(2024, 1, 5, 14, 3);
      final order = Order(
        id: 'order-123',
        userId: 'user-456',
        items: testItems,
        total: 40.00,
        timestamp: timestamp,
      );

      expect(order.formattedDate, equals('5/1/2024 14:03'));
    });

    test('formattedDate handles midnight correctly', () {
      final timestamp = DateTime(2024, 12, 31, 0, 0);
      final order = Order(
        id: 'order-123',
        userId: 'user-456',
        items: testItems,
        total: 40.00,
        timestamp: timestamp,
      );

      expect(order.formattedDate, equals('31/12/2024 0:00'));
    });

    test('order with multiple items calculates itemCount correctly', () {
      final multipleItems = [
        CartItem(product: testProducts[0], quantity: 3),
        CartItem(product: testProducts[1], quantity: 2),
        CartItem(product: testProducts[0], quantity: 1),
      ];

      final order = Order(
        id: 'order-456',
        userId: 'user-789',
        items: multipleItems,
        total: 100.00,
        timestamp: DateTime.now(),
      );

      // 3 + 2 + 1 = 6 items total
      expect(order.itemCount, equals(6));
    });

    test('toJson serializes order correctly', () {
      final timestamp = DateTime(2024, 12, 25, 14, 30);
      final order = Order(
        id: 'order-999',
        userId: 'user-111',
        items: testItems,
        total: 40.00,
        timestamp: timestamp,
      );

      final json = order.toJson();

      expect(json['id'], equals('order-999'));
      expect(json['userId'], equals('user-111'));
      expect(json['total'], equals(40.00));
      expect(json['timestamp'], equals('2024-12-25T14:30:00.000'));
      expect(json['items'], isA<List>());
      expect((json['items'] as List).length, equals(2));
    });

    test('fromJson deserializes order correctly', () {
      final json = {
        'id': 'order-888',
        'userId': 'user-222',
        'total': 75.50,
        'timestamp': '2024-11-15T10:45:00.000',
        'items': [
          {
            'productId': 'prod-1',
            'productTitle': 'JSON Product',
            'productPrice': '£30.00',
            'productImageUrl': 'assets/json.png',
            'productDescription': 'Test desc',
            'quantity': 2,
            'selectedSize': null,
            'selectedColor': null,
            'originalPrice': null,
          }
        ],
      };

      final order = Order.fromJson(json);

      expect(order.id, equals('order-888'));
      expect(order.userId, equals('user-222'));
      expect(order.total, equals(75.50));
      expect(order.timestamp, equals(DateTime.parse('2024-11-15T10:45:00.000')));
      expect(order.items.length, equals(1));
      expect(order.items[0].product.title, equals('JSON Product'));
      expect(order.items[0].quantity, equals(2));
    });

    test('toJson and fromJson roundtrip preserves data', () {
      final timestamp = DateTime(2024, 10, 20, 8, 15);
      final original = Order(
        id: 'order-777',
        userId: 'user-333',
        items: testItems,
        total: 55.00,
        timestamp: timestamp,
      );

      final json = original.toJson();
      final reconstructed = Order.fromJson(json);

      expect(reconstructed.id, equals(original.id));
      expect(reconstructed.userId, equals(original.userId));
      expect(reconstructed.total, equals(original.total));
      expect(reconstructed.timestamp, equals(original.timestamp));
      expect(reconstructed.items.length, equals(original.items.length));
    });

    test('fromJson handles total as integer', () {
      final json = {
        'id': 'order-666',
        'userId': 'user-444',
        'total': 50, // Integer instead of double
        'timestamp': '2024-09-10T12:00:00.000',
        'items': [],
      };

      final order = Order.fromJson(json);

      expect(order.total, equals(50.0));
      expect(order.total, isA<double>());
    });
  });
}
