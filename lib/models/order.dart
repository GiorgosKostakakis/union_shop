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

  /// Convert Order to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Create Order from Firestore JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}
