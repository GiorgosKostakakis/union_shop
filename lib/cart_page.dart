import 'package:flutter/material.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Cart();
    final cartItems = cart.items;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),
            
            // Page Title
            Container(
              padding: const EdgeInsets.all(40),
              child: const Text(
                'Shopping Cart',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Cart items or empty state
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: cartItems.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(48),
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : Column(
                      children: cartItems.map((item) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product image
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: item.product.imageUrl.isNotEmpty
                                      ? Image.network(
                                          item.product.imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                              const Icon(Icons.image, size: 40),
                                        )
                                      : const Icon(Icons.image, size: 40),
                                ),
                                const SizedBox(width: 16),
                                // Product details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.product.price,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF4d2963),
                                        ),
                                      ),
                                      if (item.selectedSize != null) ...[
                                        const SizedBox(height: 4),
                                        Text('Size: ${item.selectedSize}'),
                                      ],
                                      if (item.selectedColor != null) ...[
                                        const SizedBox(height: 4),
                                        Text('Color: ${item.selectedColor}'),
                                      ],
                                      const SizedBox(height: 8),
                                      // Quantity controls
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove_circle_outline),
                                            iconSize: 20,
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            onPressed: () {
                                              setState(() {
                                                if (item.quantity > 1) {
                                                  cart.decrementQuantity(item.key);
                                                } else {
                                                  cart.removeItem(item.key);
                                                }
                                              });
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            child: Text(
                                              '${item.quantity}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add_circle_outline),
                                            iconSize: 20,
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            onPressed: () {
                                              setState(() {
                                                cart.incrementQuantity(item.key);
                                              });
                                            },
                                          ),
                                          const SizedBox(width: 16),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                cart.removeItem(item.key);
                                              });
                                            },
                                            child: const Text(
                                              'Remove',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Item total price
                                Text(
                                  '£${item.totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),

            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
