import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:go_router/go_router.dart';

class CollectionPage extends StatelessWidget {
  final Collection? collection;

  const CollectionPage({
    super.key,
    this.collection,
  });

  @override
  Widget build(BuildContext context) {
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
                    collection?.title ?? 'Collection',
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
                      onChanged: (v) {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  DropdownButton<String>(
                    value: 'Sort',
                    items: const [
                      DropdownMenuItem(value: 'Sort', child: Text('Sort')),
                      DropdownMenuItem(value: 'Low', child: Text('Price: Low to High')),
                      DropdownMenuItem(value: 'High', child: Text('Price: High to Low')),
                    ],
                    onChanged: (v) {},
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
                children: collection != null
                    ? collection!.products.map((Product p) {
                        return GestureDetector(
                          onTap: () {
                              // Navigate to the nested collection/product path so URL becomes
                              // /#/collections/<collectionId>/products/<productId>
                              if (collection != null) {
                                context.push('/collections/${collection!.id}/products/${p.id}', extra: p);
                              } else {
                                context.push('/product/${p.id}', extra: p);
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
