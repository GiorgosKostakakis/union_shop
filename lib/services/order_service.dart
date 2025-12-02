import 'package:union_shop/models/order.dart' as app_order;
import 'package:union_shop/models/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

/// Service to manage order history using Firestore
class OrderService {
  // Singleton pattern
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  // Firestore instance (lazily initialized)
  FirebaseFirestore? _firestore;
  
  // Flag to enable/disable Firestore (for testing)
  bool _useFirestore = true;

  // Local cache for orders (userId -> List of Orders)
  final Map<String, List<app_order.Order>> _ordersByUser = {};
  
  /// Disable Firestore for testing
  void disableFirestore() {
    _useFirestore = false;
    _firestore = null;
  }
  
  /// Enable Firestore for production
  void enableFirestore() {
    _useFirestore = true;
    _firestore = FirebaseFirestore.instance;
  }
  
  /// Get or initialize Firestore instance
  FirebaseFirestore _getFirestore() {
    _firestore ??= FirebaseFirestore.instance;
    return _firestore!;
  }

  /// Save a new order for a user
  Future<void> saveOrder({
    required String userId,
    required List<CartItem> items,
    required double total,
  }) async {
    final order = app_order.Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      items: List.from(items), // Create a copy of items
      total: total,
      timestamp: DateTime.now(),
    );

    // Save to Firestore if enabled
    if (_useFirestore) {
      try {
        developer.log('Saving order ${order.id} for user $userId to Firestore');
        await _getFirestore()
            .collection('orders')
            .doc(order.id)
            .set(order.toJson());
        developer.log('Order ${order.id} saved successfully');
      } catch (e) {
        developer.log('Error saving order to Firestore: $e', error: e);
        // Still add to cache even if Firestore fails
      }
    } else {
      // Simulate network delay for tests
      await Future.delayed(const Duration(milliseconds: 100));
    }
    
    // Always update local cache
    if (!_ordersByUser.containsKey(userId)) {
      _ordersByUser[userId] = [];
    }
    _ordersByUser[userId]!.add(order);
  }

  /// Get all orders for a user from Firestore
  Future<List<app_order.Order>> getOrdersForUser(String userId) async {
    // If Firestore disabled, use cache only
    if (!_useFirestore) {
      return _ordersByUser[userId] ?? [];
    }

    // Always fetch from Firestore to get latest data
    try {
      developer.log('Fetching orders for user $userId from Firestore');
      final querySnapshot = await _getFirestore()
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      developer.log('Found ${querySnapshot.docs.length} orders for user $userId');
      final orders = querySnapshot.docs
          .map((doc) => app_order.Order.fromJson(doc.data()))
          .toList();

      // Update local cache
      _ordersByUser[userId] = orders;
      return orders;
    } catch (e) {
      developer.log('Error fetching orders from Firestore: $e', error: e);
      // Return cached data or empty list if Firestore fails
      return _ordersByUser[userId] ?? [];
    }
  }

  /// Get order count for a user
  Future<int> getOrderCount(String userId) async {
    final orders = await getOrdersForUser(userId);
    return orders.length;
  }

  /// Clear all orders (for testing)
  void clearAllOrders() {
    _ordersByUser.clear();
  }
}
