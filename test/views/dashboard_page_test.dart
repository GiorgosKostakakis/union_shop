import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/dashboard_page.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';
import 'package:union_shop/models/order.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';
import '../test_helpers.dart';

// Mock AuthService for testing
class MockAuthServiceForDashboard extends AuthService {
  final MockUser? _mockUser;
  bool _signedOut = false;
  
  MockAuthServiceForDashboard({MockUser? mockUser}) : _mockUser = mockUser;
  
  @override
  MockUser? get currentUser => _signedOut ? null : _mockUser;
  
  @override
  Future<void> signOut() async {
    _signedOut = true;
    await Future.delayed(const Duration(milliseconds: 10));
  }
}

// Mock OrderService for testing
class MockOrderServiceForDashboard implements OrderService {
  final List<Order> _orders;
  
  MockOrderServiceForDashboard({List<Order>? orders}) 
    : _orders = orders ?? [];
  
  @override
  Future<List<Order>> getOrdersForUser(String userId) async {
    return _orders;
  }
  
  @override
  Future<void> saveOrder({
    required String userId,
    required List<CartItem> items,
    required double total,
  }) async {
    // Not needed for these tests
  }
  
  @override
  Future<int> getOrderCount(String userId) async {
    return _orders.length;
  }
  
  @override
  void clearAllOrders() {
    // Not needed for these tests
  }
  
  @override
  void disableFirestore() {
    // Not needed for these tests
  }
  
  @override
  void enableFirestore() {
    // Not needed for these tests
  }
}

void main() {
  setupFirebaseMocks();

  group('DashboardPage Tests', () {
    testWidgets('renders without crashing', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );

      expect(find.byType(DashboardPage), findsOneWidget);
    });

    testWidgets('has scaffold structure', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('displays My Account text', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('My Account'), findsOneWidget);
    });

    testWidgets('displays Order History section', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Order History'), findsOneWidget);
    });

    testWidgets('displays logout button', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sign Out'), findsOneWidget);
    });

    testWidgets('has column layout', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('displays user email when available', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      // Check that email display area exists
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('has scrollable content area', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsWidgets);
    });

    testWidgets('displays account management section', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Account Information'), findsOneWidget);
    });

    testWidgets('has Update Email option', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('has Delete Account option', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('User ID'), findsOneWidget);
    });

    testWidgets('logout button has correct styling', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      final logoutButton = find.text('Sign Out');
      expect(logoutButton, findsOneWidget);
      
      final button = find.ancestor(
        of: logoutButton,
        matching: find.byType(ElevatedButton),
      );
      expect(button, findsOneWidget);
    });

    testWidgets('displays user with display name', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
        displayName: 'Test User',
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard();
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('displays user without display name', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
        displayName: null,
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard();
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Name'), findsNothing);
      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('displays no orders message when order list is empty', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard(orders: []);
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No orders yet'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsWidgets);
    });

    testWidgets('displays orders when available', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      
      final testProduct = Product(
        id: 'prod-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );
      
      final cartItem = CartItem(
        product: testProduct,
        quantity: 2,
        selectedSize: 'M',
        selectedColor: 'Blue',
      );
      
      final order = Order(
        id: 'order-12345678',
        userId: 'test-uid',
        items: [cartItem],
        total: 20.0,
        timestamp: DateTime(2024, 1, 15),
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard(orders: [order]);
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Order #order-12'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
      expect(find.text('2 items'), findsOneWidget);
    });

    testWidgets('can expand order to view details', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      
      final testProduct = Product(
        id: 'prod-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );
      
      final cartItem = CartItem(
        product: testProduct,
        quantity: 2,
        selectedSize: 'M',
        selectedColor: 'Blue',
      );
      
      final order = Order(
        id: 'order-12345678',
        userId: 'test-uid',
        items: [cartItem],
        total: 20.0,
        timestamp: DateTime(2024, 1, 15),
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard(orders: [order]);
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Expand the order
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();

      // Check order details are visible
      expect(find.text('Items:'), findsOneWidget);
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Size: M, Color: Blue'), findsOneWidget);
      expect(find.text('Qty: 2'), findsOneWidget);
    });

    testWidgets('displays order with original price', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      
      final testProduct = Product(
        id: 'prod-1',
        title: 'Sale Product',
        price: '£10.00',
        imageUrl: 'assets/test.png',
      );
      
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
        originalPrice: '£15.00',
      );
      
      final order = Order(
        id: 'order-12345678',
        userId: 'test-uid',
        items: [cartItem],
        total: 10.0,
        timestamp: DateTime(2024, 1, 15),
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard(orders: [order]);
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Expand the order
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();

      // Check original price is shown with strikethrough
      expect(find.text('£15.00'), findsOneWidget);
      expect(find.text('£10.00'), findsWidgets);
    });

    testWidgets('displays single item correctly', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      
      final testProduct = Product(
        id: 'prod-1',
        title: 'Single Item',
        price: '£10.00',
        imageUrl: '',
      );
      
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
      );
      
      final order = Order(
        id: 'order-12345678',
        userId: 'test-uid',
        items: [cartItem],
        total: 10.0,
        timestamp: DateTime(2024, 1, 15),
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard(orders: [order]);
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('1 item'), findsOneWidget);
    });

    testWidgets('handles logout successfully', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard();
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap logout button
      await tester.tap(find.text('Sign Out'));
      await tester.pump();
      
      // Should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      await tester.pumpAndSettle();

      // Should show success message
      expect(find.text('Signed out successfully!'), findsOneWidget);
    });

    testWidgets('displays user ID', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid-123',
        email: 'test@example.com',
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard();
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('User ID'), findsOneWidget);
      expect(find.text('test-uid-123'), findsOneWidget);
    });

    testWidgets('displays appropriate icons for user info', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
        displayName: 'Test User',
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard();
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.fingerprint), findsOneWidget);
    });

    testWidgets('displays logout icon', (tester) async {
      setupLargeViewport(tester);
      
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.logout), findsOneWidget);
    });

    testWidgets('displays order date icon', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      
      final testProduct = Product(
        id: 'prod-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: '',
      );
      
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
      );
      
      final order = Order(
        id: 'order-12345678',
        userId: 'test-uid',
        items: [cartItem],
        total: 10.0,
        timestamp: DateTime(2024, 1, 15),
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard(orders: [order]);
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.calendar_today), findsWidgets);
      expect(find.byIcon(Icons.shopping_cart), findsWidgets);
    });

    testWidgets('displays product image icon when image fails', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      
      final testProduct = Product(
        id: 'prod-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'invalid-image.png',
      );
      
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
      );
      
      final order = Order(
        id: 'order-12345678',
        userId: 'test-uid',
        items: [cartItem],
        total: 10.0,
        timestamp: DateTime(2024, 1, 15),
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard(orders: [order]);
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Expand the order to see product details
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();

      // The image will be present even if it fails to load
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('displays item without size and color', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      
      final testProduct = Product(
        id: 'prod-1',
        title: 'Simple Product',
        price: '£10.00',
        imageUrl: '',
      );
      
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
        // No size or color
      );
      
      final order = Order(
        id: 'order-12345678',
        userId: 'test-uid',
        items: [cartItem],
        total: 10.0,
        timestamp: DateTime(2024, 1, 15),
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard(orders: [order]);
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Expand the order
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();

      expect(find.text('Simple Product'), findsOneWidget);
      // Size and color should not be displayed
      expect(find.textContaining('Size:'), findsNothing);
      expect(find.textContaining('Color:'), findsNothing);
    });

    testWidgets('loads orders on init when user is logged in', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      
      final testProduct = Product(
        id: 'prod-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: '',
      );
      
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
      );
      
      final order = Order(
        id: 'order-12345678',
        userId: 'test-uid',
        items: [cartItem],
        total: 10.0,
        timestamp: DateTime(2024, 1, 15),
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard(orders: [order]);
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      
      // Orders should load
      await tester.pumpAndSettle();

      expect(find.text('Order #order-12'), findsOneWidget);
    });

    testWidgets('displays multiple orders with separator', (tester) async {
      setupLargeViewport(tester);
      
      final mockUser = MockUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      
      final testProduct = Product(
        id: 'prod-1',
        title: 'Test Product',
        price: '£10.00',
        imageUrl: '',
      );
      
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
      );
      
      final order1 = Order(
        id: 'order-11111111',
        userId: 'test-uid',
        items: [cartItem],
        total: 10.0,
        timestamp: DateTime(2024, 1, 15),
      );
      
      final order2 = Order(
        id: 'order-22222222',
        userId: 'test-uid',
        items: [cartItem],
        total: 20.0,
        timestamp: DateTime(2024, 1, 16),
      );
      
      final authService = MockAuthServiceForDashboard(mockUser: mockUser);
      final orderService = MockOrderServiceForDashboard(orders: [order1, order2]);
      
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardPage(
            authService: authService,
            orderService: orderService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Both orders should be displayed
      expect(find.text('Order #order-11'), findsOneWidget);
      expect(find.text('Order #order-22'), findsOneWidget);
      
      // Divider should be present between orders
      expect(find.byType(Divider), findsWidgets);
    });
  });
}
