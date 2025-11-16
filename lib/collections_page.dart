import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

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
                  // Main header
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          // Logo image
                          Image.asset(
                            'assets/logo.png',
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 16),
                          // Home button
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Home',
                              style: TextStyle(
                                color: Color(0xFF4d2963),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: EdgeInsets.all(8),
                                  constraints: BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: null,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.person_outline,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: EdgeInsets.all(8),
                                  constraints: BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: null,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: EdgeInsets.all(8),
                                  constraints: BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: null,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.menu,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: EdgeInsets.all(8),
                                  constraints: BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Collections Title Section
            Container(
              padding: const EdgeInsets.all(40),
              child: const Text(
                'Collections',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
