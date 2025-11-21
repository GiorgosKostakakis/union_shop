import 'package:flutter/material.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/footer.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleItems = List.generate(3, (i) => {
      'title': 'Sale Product ${i + 1}',
      'price': '£${(20 + i * 5).toStringAsFixed(2)}',
      'image': 'assets/product${i + 1}.png',
    });

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
                  children: List.generate(sampleItems.length, (index) {
                    final item = sampleItems[index];
                    return _SaleTile(
                      key: Key('saleProductTile_$index'),
                      title: item['title']!,
                      price: item['price']!,
                      image: item['image']!,
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
  final String title;
  final String price;
  final String image;
  final int index;

  const _SaleTile({super.key, required this.title, required this.price, required this.image, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    image,
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
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),

          // Sale badge
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
              child: const Text(
                'SALE',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
