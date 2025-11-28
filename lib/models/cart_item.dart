import 'package:union_shop/models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  final String? selectedSize;
  final String? selectedColor;
  final String? originalPrice; // For sale items

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedSize,
    this.selectedColor,
    this.originalPrice,
  });

  // Calculate total price for this cart item
  double get totalPrice {
    // Parse price string (e.g., "£10.00" -> 10.00)
    final priceString = product.price.replaceAll('£', '').trim();
    final price = double.tryParse(priceString) ?? 0.0;
    return price * quantity;
  }

  // Create a copy with updated values
  CartItem copyWith({
    Product? product,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
    String? originalPrice,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      originalPrice: originalPrice ?? this.originalPrice,
    );
  }

  // Generate a unique key for this cart item (includes product + options)
  String get key {
    return '${product.id}_${selectedSize ?? 'nosize'}_${selectedColor ?? 'nocolor'}';
  }
}
