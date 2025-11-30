import 'package:flutter/material.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/fixtures.dart';
import 'package:go_router/go_router.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use saleItems from fixtures which contain product + numeric price + discountPercent
    final items = saleItems;

    return SingleChildScrollView(
      child: Column(
        children: [
          const Header(),

          // Promo banner
          Container(
            key: const Key('saleBanner'),
            width: double.infinity,
            height: 180,
            decoration: const BoxDecoration(
              color: Color(0xFF4d2963),
            ),
            child: const Center(
              child: Text(
                'BIG SALE — Limited time offers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Placeholder grid/list of sale products
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 800;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: isWide ? 3 : 1,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.75,
                  children: List.generate(items.length, (index) {
                    final entry = items[index];
                    return _SaleTile(
                      key: Key('saleProductTile_$index'),
                      saleEntry: entry,
                      index: index,
                    );
                  }),
                );
              },
            ),
          ),

          const Footer(),
        ],
      ),
    );
  }
}

class _SaleTile extends StatelessWidget {
  final Map<String, dynamic> saleEntry;
  final int index;

  const _SaleTile({super.key, required this.saleEntry, required this.index});

  @override
  Widget build(BuildContext context) {
    final Product product = saleEntry['product'] as Product;
    final double price = (saleEntry['price'] as num).toDouble();
    final int discount = (saleEntry['discountPercent'] as num).toInt();
    final double discounted = price * (1 - discount / 100.0);

    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  child: InkWell(
  onTap: () {
    // Create a product with the sale price
    final saleProduct = Product(
      id: product.id,
      title: product.title,
      price: '£${discounted.toStringAsFixed(2)}',
      imageUrl: product.imageUrl,
    );
    // Pass both the sale product and original price
    context.go('/sale/products/${product.id}', extra: {
      'product': saleProduct,
      'originalPrice': '£${price.toStringAsFixed(2)}',
    });
  },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // image box
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.image_not_supported, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.title,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '£${price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '£${discounted.toStringAsFixed(2)}',
                        key: Key('discountPrice_$index'),
                        style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sale badge with percent
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                key: Key('saleBadge_$index'),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '-$discount%',
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
