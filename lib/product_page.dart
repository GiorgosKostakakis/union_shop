import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart.dart';

class ProductPage extends StatefulWidget {
  final Product? product;

  const ProductPage({super.key, this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // Local UI state for product options
  String selectedSize = 'M';
  String selectedColor = 'Black';
  int quantity = 1;

  void _incrementQty() {
    setState(() {
      quantity += 1;
    });
  }

  void _decrementQty() {
    setState(() {
      if (quantity > 1) quantity -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ensure we always have a product to display; fallback to a static local-asset product
    final Product displayProduct = widget.product ??
        const Product(
          id: 'placeholder',
          title: 'Placeholder Product Name',
          price: '£15.00',
          imageUrl: 'assets/product1.png',
        );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),

            // Product details wrapped in a centered max-width container
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(24),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Image widget (keeps ClipRRect and Image.asset logic)
                      final Widget imageWidget = SizedBox(
                        width: constraints.maxWidth >= 800 ? 420 : double.infinity,
                        child: Center(
                          child: Container(
                            height: constraints.maxWidth >= 800 ? 420 : 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: displayProduct.imageUrl.startsWith('assets/')
                                  ? Image.asset(
                                      displayProduct.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Center(child: Icon(Icons.image_not_supported)),
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      'assets/product1.png',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Center(child: Icon(Icons.image_not_supported)),
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                      );

                      // Details column (title, price, description, options, CTA)
                      final Widget detailsContent = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product name
                          Text(
                            displayProduct.title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Product price
                          Text(
                            displayProduct.price,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4d2963),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Product options wired to local state
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('Size: '),
                                  const SizedBox(width: 8),
                                  DropdownButton<String>(
                                    key: const Key('sizeDropdown'),
                                    value: selectedSize,
                                    items: const [
                                      DropdownMenuItem(value: 'S', child: Text('S')),
                                      DropdownMenuItem(value: 'M', child: Text('M')),
                                      DropdownMenuItem(value: 'L', child: Text('L')),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() {
                                        selectedSize = v;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 24),
                                  const Text('Color: '),
                                  const SizedBox(width: 8),
                                  DropdownButton<String>(
                                    key: const Key('colorDropdown'),
                                    value: selectedColor,
                                    items: const [
                                      DropdownMenuItem(value: 'Black', child: Text('Black')),
                                      DropdownMenuItem(value: 'White', child: Text('White')),
                                      DropdownMenuItem(value: 'Blue', child: Text('Blue')),
                                    ],
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() {
                                        selectedColor = v;
                                      });
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Quantity selector
                              Row(
                                children: [
                                  const Text('Qty: '),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    key: const Key('qtyDecrement'),
                                    onPressed: _decrementQty,
                                    icon: const Icon(Icons.remove_circle_outline),
                                  ),
                                  Text(
                                    '$quantity',
                                    key: const Key('qtyText'),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    key: const Key('qtyIncrement'),
                                    onPressed: _incrementQty,
                                    icon: const Icon(Icons.add_circle_outline),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Visible summary of selection
                              Text('Size: $selectedSize  •  Color: $selectedColor  •  Qty: $quantity'),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Product description (moved under the filters)
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'This is a placeholder description for the product. Students should replace this with real product information and implement proper data management.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // CTA Button
                          ElevatedButton(
                            onPressed: () {
                              final cart = Cart();
                              cart.addItem(
                                product: displayProduct,
                                quantity: quantity,
                                selectedSize: selectedSize,
                                selectedColor: selectedColor,
                              );
                              
                              // Show confirmation snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Added ${displayProduct.title} to cart',
                                  ),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'VIEW CART',
                                    onPressed: () {
                                      context.go('/cart');
                                    },
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4d2963),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              'ADD TO CART',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      );

                      if (constraints.maxWidth >= 800) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            imageWidget,
                            const SizedBox(width: 32),
                            Expanded(child: detailsContent),
                          ],
                        );
                      }

                      // Narrow / mobile layout: stacked
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          imageWidget,
                          const SizedBox(height: 24),
                          detailsContent,
                        ],
                      );
                    },
                  ),
                  ),
                ),
              ),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}
