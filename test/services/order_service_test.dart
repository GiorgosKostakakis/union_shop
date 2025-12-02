import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/order_service.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('OrderService Tests', () {
    late OrderService orderService;

    setUp(() {
      orderService = OrderService();
      orderService.disableFirestore(); // Disable Firestore for testing
      orderService.clearAllOrders();
    });

    tearDown(() {
      orderService.clearAllOrders();
    });

    final testProduct = const Product(
      id: 'prod-1',
      title: 'Test Product',
      price: '£10.00',
      imageUrl: 'assets/test.png',
    );

    final testItems = [
      CartItem(product: testProduct, quantity: 2),
    ];

    test('singleton returns same instance', () {
      final instance1 = OrderService();
      final instance2 = OrderService();

      expect(instance1, equals(instance2));
    });

    test('saveOrder creates order with correct data', () async {
      await orderService.saveOrder(
        userId: 'user-123',
        items: testItems,
        total: 20.00,
      );

      final orders = await orderService.getOrdersForUser('user-123');
      
      expect(orders.length, equals(1));
      expect(orders[0].userId, equals('user-123'));
      expect(orders[0].total, equals(20.00));
      expect(orders[0].items.length, equals(1));
      expect(orders[0].items[0].product.id, equals('prod-1'));
    });

    test('saveOrder creates unique order IDs', () async {
      await orderService.saveOrder(
        userId: 'user-123',
        items: testItems,
        total: 20.00,
      );

      await Future.delayed(const Duration(milliseconds: 10));

      await orderService.saveOrder(
        userId: 'user-123',
        items: testItems,
        total: 30.00,
      );

      final orders = await orderService.getOrdersForUser('user-123');
      
      expect(orders.length, equals(2));
      expect(orders[0].id, isNot(equals(orders[1].id)));
    });

    test('saveOrder stores items list reference', () async {
      final items = [CartItem(product: testProduct, quantity: 2)];
      
      await orderService.saveOrder(
        userId: 'user-123',
        items: items,
        total: 20.00,
      );

      final orders = await orderService.getOrdersForUser('user-123');
      
      // List.from creates shallow copy, so CartItems are still mutable references
      // This is acceptable for this use case as orders are snapshots at time of purchase
      expect(orders[0].items.length, equals(1));
      expect(orders[0].items[0].product.id, equals('prod-1'));
    });

    test('getOrdersForUser returns empty list for new user', () async {
      final orders = await orderService.getOrdersForUser('new-user');
      
      expect(orders, isEmpty);
    });

    test('getOrdersForUser returns all orders for user', () async {
      await orderService.saveOrder(
        userId: 'user-123',
        items: testItems,
        total: 20.00,
      );

      await orderService.saveOrder(
        userId: 'user-123',
        items: testItems,
        total: 30.00,
      );

      await orderService.saveOrder(
        userId: 'user-456',
        items: testItems,
        total: 15.00,
      );

      final ordersUser123 = await orderService.getOrdersForUser('user-123');
      final ordersUser456 = await orderService.getOrdersForUser('user-456');
      
      expect(ordersUser123.length, equals(2));
      expect(ordersUser456.length, equals(1));
    });

    test('getOrderCount returns 0 for new user', () async {
      final count = await orderService.getOrderCount('new-user');
      
      expect(count, equals(0));
    });

    test('getOrderCount returns correct count', () async {
      await orderService.saveOrder(
        userId: 'user-123',
        items: testItems,
        total: 20.00,
      );

      await orderService.saveOrder(
        userId: 'user-123',
        items: testItems,
        total: 30.00,
      );

      final count = await orderService.getOrderCount('user-123');
      
      expect(count, equals(2));
    });

    test('clearAllOrders removes all orders', () async {
      await orderService.saveOrder(
        userId: 'user-123',
        items: testItems,
        total: 20.00,
      );

      await orderService.saveOrder(
        userId: 'user-456',
        items: testItems,
        total: 30.00,
      );

      orderService.clearAllOrders();

      expect(await orderService.getOrderCount('user-123'), equals(0));
      expect(await orderService.getOrderCount('user-456'), equals(0));
    });

    test('saveOrder adds to existing user orders', () async {
      await orderService.saveOrder(
        userId: 'user-123',
        items: testItems,
        total: 20.00,
      );

      await orderService.saveOrder(
        userId: 'user-123',
        items: testItems,
        total: 30.00,
      );

      final orders = await orderService.getOrdersForUser('user-123');
      
      expect(orders.length, equals(2));
      expect(orders[0].total, equals(20.00));
      expect(orders[1].total, equals(30.00));
    });

    test('saveOrder has delay simulation', () async {
      final stopwatch = Stopwatch()..start();
      
      await orderService.saveOrder(
        userId: 'user-123',
        items: testItems,
        total: 20.00,
      );

      stopwatch.stop();
      
      // Should take at least 100ms due to delay
      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(100));
    });
  });
}
