import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:go_router/go_router.dart';

class CollectionPage extends StatefulWidget {
  final Collection? collection;

  const CollectionPage({
    super.key,
    this.collection,
  });

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  String _searchQuery = '';
  String _sortOption = 'Sort';

  List<Product> _getFilteredAndSortedProducts() {
    if (widget.collection == null) return [];
    
    List<Product> products = List.from(widget.collection!.products);
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      products = products.where((p) {
        return p.title.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    
    // Sort by price
    if (_sortOption == 'Low') {
      products.sort((a, b) {
        final priceA = double.tryParse(a.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
        final priceB = double.tryParse(b.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
        return priceA.compareTo(priceB);
      });
    } else if (_sortOption == 'High') {
      products.sort((a, b) {
        final priceA = double.tryParse(a.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
        final priceB = double.tryParse(b.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
        return priceB.compareTo(priceA);
      });
    }
    
    return products;
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _getFilteredAndSortedProducts();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const Header(),

            // Page Title (minimal skeleton)
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    widget.collection?.title ?? 'Collection',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Filters row (UI only)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Search products',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  DropdownButton<String>(
                    value: _sortOption,
                    items: const [
                      DropdownMenuItem(value: 'Sort', child: Text('Sort')),
                      DropdownMenuItem(value: 'Low', child: Text('Price: Low to High')),
                      DropdownMenuItem(value: 'High', child: Text('Price: High to Low')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _sortOption = value;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),

                // Product Grid (static sample) - use collection.products when available
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
                children: widget.collection != null && filteredProducts.isNotEmpty
                    ? filteredProducts.map((Product p) {
                        return GestureDetector(
                          onTap: () {
                              // Navigate to the nested collection/product path with context.go to update URL
                              if (widget.collection != null) {
                                context.go('/collections/${widget.collection!.id}/products/${p.id}', extra: p);
                              } else {
                                context.go('/product/${p.id}', extra: p);
                              }
                          },
                          child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  p.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: const Center(child: Icon(Icons.image_not_supported)),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(p.title, style: const TextStyle(fontSize: 14)),
                                    const SizedBox(height: 4),
                                    Text(p.price, style: const TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      }).toList()
                    : widget.collection != null && filteredProducts.isEmpty
                        ? [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: Text(
                                  'No products found matching your search.',
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              ),
                            )
                          ]
                        : List.generate(6, (index) {
                            return Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey[300],
                                      child: const Center(child: Icon(Icons.image, size: 48)),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Product name', style: TextStyle(fontSize: 14)),
                                        SizedBox(height: 4),
                                        Text('£10.00', style: TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
              ),
            ),

            const Footer(),
          ],
        ),
      ),
    );
  }
}
