import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/collection_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/models/fixtures.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/product',
          builder: (context, state) => const ProductPage(),
        ),
        GoRoute(
          path: '/product/:productId',
          builder: (context, state) {
            final pid = state.pathParameters['productId'];
            if (pid != null) {
              final p = productById(pid);
              if (p != null) return ProductPage(product: p);
            }
            return const ProductPage();
          },
        ),
        GoRoute(
          path: '/collections',
          builder: (context, state) => const CollectionsPage(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutPage(),
        ),
        GoRoute(
          path: '/collections/:collectionId',
          builder: (context, state) {
            final cid = state.pathParameters['collectionId'];
            if (cid != null) {
              final c = collectionById(cid);
              if (c != null) return CollectionPage(collection: c);
            }
            return const CollectionPage();
          },
        ),
        GoRoute(
          path: '/collections/:collectionId/products/:productId',
          builder: (context, state) {
            final pid = state.pathParameters['productId'];
            if (pid != null) {
              final p = productById(pid);
              if (p != null) return ProductPage(product: p);
            }
            return const ProductPage();
          },
        ),
        GoRoute(
          path: '/sale',
          builder: (context, state) => const SalePage(),
        ),
        GoRoute(
          path: '/sale/products/:productId',
          builder: (context, state) {
            final pid = state.pathParameters['productId'];
            if (pid != null) {
              final p = productById(pid);
              if (p != null) return ProductPage(product: p);
            }
            return const ProductPage();
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      routerConfig: router,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),

            // Hero Section
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  // Hero background image
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/hero.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  ),
                  // Content overlay
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Placeholder Hero Title',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "This is placeholder text for the hero section.",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'BROWSE PRODUCTS',
                            style: TextStyle(fontSize: 14, letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Products Section
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const Text(
                      'PRODUCTS SECTION',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 48),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 48,
                      children: [
                        ProductCard(
                          productId: products[0].id,
                          title: products[0].title,
                          price: products[0].price,
                          imageUrl: products[0].imageUrl,
                        ),
                        ProductCard(
                          productId: products[1].id,
                          title: products[1].title,
                          price: products[1].price,
                          imageUrl: products[1].imageUrl,
                        ),
                        ProductCard(
                          productId: products[2].id,
                          title: products[2].title,
                          price: products[2].price,
                          imageUrl: products[2].imageUrl,
                        ),
                        ProductCard(
                          productId: products[3].id,
                          title: products[3].title,
                          price: products[3].price,
                          imageUrl: products[3].imageUrl,
                        ),
                      ],
                    ),
                  ],
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

class ProductCard extends StatelessWidget {
  final String productId;
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

      @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Use GoRouter navigation with product ID for deep routing
        context.go('/product/$productId');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Expanded(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
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
          ],
      ),
    );
  }
}