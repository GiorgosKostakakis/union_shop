import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/views/collections_page.dart';
import 'package:union_shop/views/collection_page.dart';
import 'package:union_shop/views/about_page.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/views/sale_page.dart';
import 'package:union_shop/views/search_page.dart';
import 'package:union_shop/views/cart_page.dart';
import 'package:union_shop/models/fixtures.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/auth/login_page.dart';
import 'package:union_shop/auth/signup_page.dart';
import 'package:union_shop/views/dashboard_page.dart';
import 'package:union_shop/views/personalisation_page.dart';
import 'package:union_shop/views/print_shack_about_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const UnionShopApp());
}

/// Helper class to refresh GoRouter when auth state changes
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        final isAuthRoute = state.matchedLocation == '/login' || 
                           state.matchedLocation == '/signup';
        final isDashboard = state.matchedLocation == '/dashboard';

        // If user is not logged in and trying to access dashboard, redirect to login
        if (user == null && isDashboard) {
          return '/login';
        }

        // If user is logged in and on auth pages, redirect to dashboard
        if (user != null && isAuthRoute) {
          return '/dashboard';
        }

        // No redirect needed
        return null;
      },
      refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
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
            // Check if we have sale data passed via extra
            final extraData = state.extra;
            if (extraData != null && extraData is Map<String, dynamic>) {
              final saleProduct = extraData['product'] as Product?;
              final originalPrice = extraData['originalPrice'] as String?;
              if (saleProduct != null) {
                return ProductPage(
                  product: saleProduct,
                  originalPrice: originalPrice,
                );
              }
            } else if (extraData != null && extraData is Product) {
              // Backward compatibility for simple Product extra
              return ProductPage(product: extraData);
            }
            
            // Fallback to regular product lookup
            final pid = state.pathParameters['productId'];
            if (pid != null) {
              final p = productById(pid);
              if (p != null) return ProductPage(product: p);
            }
            return const ProductPage();
          },
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignupPage(),
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) {
            final query = state.uri.queryParameters['q'];
            return SearchPage(initialQuery: query);
          },
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CartPage(),
        ),
        GoRoute(
          path: '/personalisation',
          builder: (context, state) => const PersonalisationPage(),
        ),
        GoRoute(
          path: '/print-shack-about',
          builder: (context, state) => const PrintShackAboutPage(),
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