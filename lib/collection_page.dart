import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';

class CollectionPage extends StatelessWidget {
  final String title;

  const CollectionPage({
    super.key,
    this.title = 'Collection',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 100,
              color: Colors.white,
              child: Column(
                children: [
                  // Top banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: const Color(0xFF4d2963),
                    child: const Text(
                      'PLACEHOLDER HEADER TEXT',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            // Page Title (minimal skeleton)
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    title,
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

            // Product Grid (static sample)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
                children: List.generate(6, (index) {
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
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
