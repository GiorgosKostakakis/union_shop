import 'package:flutter/material.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';

// Simple in-memory cart (no provider/state management)
class Cart {
  // Singleton pattern for global access
  static final Cart _instance = Cart._internal();
  factory Cart() => _instance;
  Cart._internal();

  // Map of cart items using unique keys
  final Map<String, CartItem> _items = {};
  
  // Callbacks for notifying UI of changes
  final List<VoidCallback> _listeners = [];

  // Register a listener
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  // Remove a listener
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  // Notify all listeners
  void _notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }

  // Get all cart items
  List<CartItem> get items => _items.values.toList();

  // Get number of items in cart (total quantity)
  int get itemCount {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  // Get number of unique products in cart
  int get uniqueItemCount => _items.length;

  // Calculate total price
  double get totalAmount {
    return _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  // Add item to cart
  void addItem({
    required Product product,
    int quantity = 1,
    String? selectedSize,
    String? selectedColor,
    String? originalPrice,
  }) {
    final cartItem = CartItem(
      product: product,
      quantity: quantity,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
      originalPrice: originalPrice,
    );

    final key = cartItem.key;

    if (_items.containsKey(key)) {
      // Update quantity if item already exists
      _items[key] = _items[key]!.copyWith(
        quantity: _items[key]!.quantity + quantity,
      );
    } else {
      // Add new item
      _items[key] = cartItem;
    }
    _notifyListeners();
  }

  // Remove item from cart completely
  void removeItem(String key) {
    _items.remove(key);
    _notifyListeners();
  }

  // Update quantity of an item
  void updateQuantity(String key, int quantity) {
    if (_items.containsKey(key)) {
      if (quantity <= 0) {
        _items.remove(key);
      } else {
        _items[key] = _items[key]!.copyWith(quantity: quantity);
      }
      _notifyListeners();
    }
  }

  // Increment quantity
  void incrementQuantity(String key) {
    if (_items.containsKey(key)) {
      _items[key] = _items[key]!.copyWith(
        quantity: _items[key]!.quantity + 1,
      );
      _notifyListeners();
    }
  }

  // Decrement quantity
  void decrementQuantity(String key) {
    if (_items.containsKey(key)) {
      final currentQuantity = _items[key]!.quantity;
      if (currentQuantity > 1) {
        _items[key] = _items[key]!.copyWith(
          quantity: currentQuantity - 1,
        );
      } else {
        _items.remove(key);
      }
      _notifyListeners();
    }
  }

  // Clear entire cart
  void clear() {
    _items.clear();
    _notifyListeners();
  }

  // Check if product is in cart (with specific options)
  bool isInCart({
    required String productId,
    String? selectedSize,
    String? selectedColor,
  }) {
    final key = '${productId}_${selectedSize ?? 'nosize'}_${selectedColor ?? 'nocolor'}';
    return _items.containsKey(key);
  }
}
