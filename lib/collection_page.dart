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

            const SizedBox(height: 200, child: Center(child: Text('Products will appear here'))),

            const Footer(),
          ],
        ),
      ),
    );
  }
}
