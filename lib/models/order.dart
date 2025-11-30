import 'package:union_shop/models/cart_item.dart';

/// Order model representing a completed purchase
class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double total;
  final DateTime timestamp;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.timestamp,
  });

  /// Get total number of items in order
  int get itemCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Format timestamp as readable date
  String get formattedDate {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}
