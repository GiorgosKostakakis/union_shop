import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/models/cart.dart';

class Header extends StatefulWidget {
  final VoidCallback? onLogoTap;

  const Header({super.key, this.onLogoTap});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    super.initState();
    // Listen to cart changes and rebuild
    Cart().addListener(_onCartChanged);
  }

  @override
  void dispose() {
    Cart().removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cart = Cart();
    final cartItemCount = cart.itemCount;

    return Material(
      color: Colors.white,
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    // Left: logo
                    Image.asset(
                      'assets/logo.png',
                      height: 40,
                      fit: BoxFit.contain,
                    ),

                    // Center: navigation buttons (kept centered between logo and icons)
                    Expanded(
                      child: Center(
                        child: Wrap(
                          spacing: 8,
                          alignment: WrapAlignment.center,
                          children: [
                          TextButton(
                            onPressed: () => context.go('/'),
                            child: const Text(
                              'Home',
                              style: TextStyle(
                                color: Color(0xFF4d2963),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go('/about'),
                            child: const Text(
                              'About Us',
                              style: TextStyle(
                                color: Color(0xFF4d2963),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go('/collections'),
                            child: const Text(
                              'Collections',
                              style: TextStyle(
                                color: Color(0xFF4d2963),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go('/sale'),
                            child: const Text(
                              'Sales',
                              style: TextStyle(
                                color: Color(0xFF4d2963),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            offset: const Offset(0, 40),
                            onSelected: (String value) {
                              if (value == 'personalisation') {
                                context.go('/personalisation');
                              } else if (value == 'about') {
                                context.go('/print-shack-about');
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem<String>(
                                value: 'personalisation',
                                child: Text('Personalisation'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'about',
                                child: Text('About Print Shack'),
                              ),
                            ],
                            child: TextButton(
                              onPressed: null,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Print Shack',
                                    style: TextStyle(
                                      color: Color(0xFF4d2963),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF4d2963),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Right: icons
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search, size: 18, color: Color(0xFF4d2963)),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                          onPressed: () => context.go('/search'),
                        ),
                        IconButton(
                          icon: Icon(
                            FirebaseAuth.instance.currentUser != null 
                              ? Icons.person 
                              : Icons.person_outline,
                            size: 18,
                            color: const Color(0xFF4d2963),
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                          onPressed: () {
                            if (FirebaseAuth.instance.currentUser != null) {
                              context.go('/dashboard');
                            } else {
                              context.go('/login');
                            }
                          },
                        ),
                        // Cart icon with badge
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.shopping_bag_outlined, size: 18, color: Color(0xFF4d2963)),
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                              onPressed: () => context.go('/cart'),
                            ),
                            if (cartItemCount > 0)
                              Positioned(
                                right: 4,
                                top: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    cartItemCount > 99 ? '99+' : '$cartItemCount',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const IconButton(
                          icon: Icon(Icons.menu, size: 18, color: Colors.grey),
                          padding: EdgeInsets.all(8),
                          constraints: BoxConstraints(minWidth: 32, minHeight: 32),
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
    );
  }
}
