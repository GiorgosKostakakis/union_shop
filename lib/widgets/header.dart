import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/services/auth_provider.dart' as auth_provider;
import 'package:union_shop/services/navigation_history.dart';

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

  void _showNavigationDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: const Icon(Icons.home, color: Color(0xFF4d2963)),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Color(0xFF4d2963)),
                title: const Text('About Us'),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/about');
                },
              ),
              ListTile(
                leading: const Icon(Icons.grid_view, color: Color(0xFF4d2963)),
                title: const Text('Collections'),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/collections');
                },
              ),
              ListTile(
                leading: const Icon(Icons.local_offer, color: Color(0xFF4d2963)),
                title: const Text('Sales'),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/sale');
                },
              ),
              ExpansionTile(
                leading: const Icon(Icons.print, color: Color(0xFF4d2963)),
                title: const Text('Print Shack'),
                tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                childrenPadding: const EdgeInsets.only(left: 16),
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 32),
                    title: const Text('Personalisation'),
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/personalisation');
                    },
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 32),
                    title: const Text('About Print Shack'),
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/print-shack-about');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Cart();
    final cartItemCount = cart.itemCount;
    final isNarrow = MediaQuery.of(context).size.width < 900;
    final navHistory = NavigationHistory();
    
    // Try to get router, but handle gracefully if not available (e.g., in tests)
    GoRouter? router;
    String currentLocation = '/';
    try {
      router = GoRouter.of(context);
      currentLocation = router.routeInformationProvider.value.uri.path;
      // Track current location in history
      navHistory.push(currentLocation);
    } catch (_) {
      // Router not available in this context (e.g., tests)
    }
    
    // Show back button when we have history to go back to
    final showBackButton = navHistory.canGoBack && router != null;

    return Material(
      color: Colors.white,
      child: SizedBox(
        height: showBackButton ? 130 : 100,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: const Color(0xFF4d2963),
              child: const Text(
                'Union Shop',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            if (showBackButton)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      onPressed: () {
                        final previousLocation = navHistory.pop();
                        if (previousLocation != null) {
                          context.go(previousLocation);
                        }
                      },
                      tooltip: 'Go back',
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        final previousLocation = navHistory.pop();
                        if (previousLocation != null) {
                          context.go(previousLocation);
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: const Size(0, 32),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isNarrow ? 4 : 10),
                child: Row(
                  children: [
                    // Left: logo
                    GestureDetector(
                      onTap: widget.onLogoTap ?? () => context.go('/'),
                      child: Image.asset(
                        'assets/logo.png',
                        height: isNarrow ? 32 : 40,
                        fit: BoxFit.contain,
                      ),
                    ),

                    // Center: navigation buttons (hidden on narrow screens)
                    if (!isNarrow)
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

                  // Spacer on narrow screens
                  if (isNarrow) const Spacer(),

                  // Right: icons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search, size: 18, color: Color(0xFF4d2963)),
                        padding: EdgeInsets.all(isNarrow ? 4 : 8),
                        constraints: BoxConstraints(minWidth: isNarrow ? 28 : 32, minHeight: isNarrow ? 28 : 32),
                        onPressed: () => context.go('/search'),
                      ),
                      IconButton(
                        icon: Icon(
                          auth_provider.AuthProvider.instance.currentUser != null 
                            ? Icons.person 
                            : Icons.person_outline,
                          size: 18,
                          color: const Color(0xFF4d2963),
                        ),
                        padding: EdgeInsets.all(isNarrow ? 4 : 8),
                        constraints: BoxConstraints(minWidth: isNarrow ? 28 : 32, minHeight: isNarrow ? 28 : 32),
                        onPressed: () {
                          if (auth_provider.AuthProvider.instance.currentUser != null) {
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
                            padding: EdgeInsets.all(isNarrow ? 4 : 8),
                            constraints: BoxConstraints(minWidth: isNarrow ? 28 : 32, minHeight: isNarrow ? 28 : 32),
                            onPressed: () => context.go('/cart'),
                          ),
                          if (cartItemCount > 0)
                            Positioned(
                              right: 4,
                              top: 4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
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
                      if (isNarrow)
                        IconButton(
                          icon: const Icon(Icons.menu, size: 18, color: Color(0xFF4d2963)),
                          padding: EdgeInsets.all(isNarrow ? 4 : 8),
                          constraints: BoxConstraints(minWidth: isNarrow ? 28 : 32, minHeight: isNarrow ? 28 : 32),
                          onPressed: () => _showNavigationDrawer(context),
                        ),
                    ],
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
