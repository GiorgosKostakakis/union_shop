import 'package:union_shop/models/order.dart';
import 'package:union_shop/models/cart_item.dart';

/// Service to manage order history (in-memory)
class OrderService {
  // Singleton pattern
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  // Store orders in memory (userId -> List of Orders)
  final Map<String, List<Order>> _ordersByUser = {};

  /// Save a new order for a user
  Future<void> saveOrder({
    required String userId,
    required List<CartItem> items,
    required double total,
  }) async {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      items: List.from(items), // Create a copy of items
      total: total,
      timestamp: DateTime.now(),
    );

    if (!_ordersByUser.containsKey(userId)) {
      _ordersByUser[userId] = [];
    }

    _ordersByUser[userId]!.add(order);
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
  }

  /// Get all orders for a user
  List<Order> getOrdersForUser(String userId) {
    return _ordersByUser[userId] ?? [];
  }

  /// Get order count for a user
  int getOrderCount(String userId) {
    return _ordersByUser[userId]?.length ?? 0;
  }

  /// Clear all orders (for testing)
  void clearAllOrders() {
    _ordersByUser.clear();
  }
}
