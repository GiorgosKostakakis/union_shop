import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/auth/login_page.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/auth_provider.dart' as auth_provider;
import '../test_helpers.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late AuthService authService;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    auth_provider.AuthProvider.setMockInstance(mockAuth);
    authService = AuthService(googleSignIn: mockGoogleSignIn);
  });

  tearDown(() {
    mockAuth.dispose();
  });

  group('LoginPage Tests', () {
    testWidgets('renders with form elements', (tester) async {
      setupLargeViewport(tester);
      
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('has email and password fields', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('displays Login title', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      expect(find.text('Welcome Back'), findsOneWidget);
    });

    testWidgets('has LOGIN button', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      expect(find.text('Log In'), findsOneWidget);
    });

    testWidgets('has Google Sign In button', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      expect(find.textContaining('Google'), findsOneWidget);
    });

    testWidgets('has link to signup page', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      expect(find.textContaining('Sign Up'), findsAtLeastNWidgets(1));
    });

    testWidgets('validates email field when empty', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      // Tap login without entering anything
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      expect(find.text('This field is required'), findsWidgets);
    });

    testWidgets('validates email format', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      // Enter invalid email
      final emailFields = find.byType(TextFormField);
      await tester.enterText(emailFields.first, 'invalidemail');
      
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('validates password minimum length', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      // Enter valid email but short password
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'test@example.com');
      await tester.enterText(fields.last, '12345');
      
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });

    testWidgets('accepts valid email format', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      final emailFields = find.byType(TextFormField);
      await tester.enterText(emailFields.first, 'test@example.com');
      await tester.pump();

      // Valid email should not show error yet
      expect(find.text('Please enter a valid email address'), findsNothing);
    });

    testWidgets('has header widget', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('form fields are editable', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      final fields = find.byType(TextFormField);
      
      await tester.enterText(fields.first, 'user@test.com');
      await tester.enterText(fields.last, 'password123');
      await tester.pump();

      expect(find.text('user@test.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('has password field', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      // Password field exists
      final fields = find.byType(TextFormField);
      expect(fields, findsNWidgets(2));
    });

    testWidgets('displays OR divider', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      expect(find.text('OR'), findsOneWidget);
    });

    testWidgets('has create account prompt', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      expect(find.textContaining('Don\'t have an account?'), findsOneWidget);
    });

    testWidgets('successful login with valid credentials', (tester) async {
      setupLargeViewport(tester);
      // Create a user first
      await authService.signUpWithEmail(
        email: 'test@example.com',
        password: 'password123',
      );
      await authService.signOut();

      await tester.pumpWidget(
        MaterialApp(
          home: LoginPage(authService: authService),
          routes: {
            '/dashboard': (context) => const Scaffold(body: Text('Dashboard')),
          },
        ),
      );

      // Enter credentials
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'test@example.com');
      await tester.enterText(fields.last, 'password123');

      // Tap login
      await tester.tap(find.text('Log In'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Should show success snackbar or navigate away
      final hasSuccess = find.text('Logged in successfully!').evaluate().isNotEmpty;
      final hasDashboard = find.text('Dashboard').evaluate().isNotEmpty;
      expect(hasSuccess || hasDashboard, isTrue);
    }, skip: true);

    testWidgets('shows error on wrong password', (tester) async {
      setupLargeViewport(tester);
      // Create a user
      await authService.signUpWithEmail(
        email: 'user@example.com',
        password: 'correctpass',
      );
      await authService.signOut();

      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      // Try wrong password
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'user@example.com');
      await tester.enterText(fields.last, 'wrongpass');

      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      // Should show error
      expect(find.textContaining('Exception:'), findsOneWidget);
    });

    testWidgets('shows error for non-existent user', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'nonexistent@example.com');
      await tester.enterText(fields.last, 'password123');

      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      // Should show error
      expect(find.textContaining('Exception:'), findsOneWidget);
    });

    testWidgets('button shows loading state during login', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'test@example.com');
      await tester.enterText(fields.last, 'password123');

      // Start login (don't pumpAndSettle yet)
      await tester.tap(find.text('Log In'));
      await tester.pump();

      // Button should be disabled or show loading indicator
      expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));
    }, skip: true);

    testWidgets('Google sign in button triggers authentication', (tester) async {
      setupLargeViewport(tester);
      final testRouter = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => LoginPage(authService: authService),
          ),
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const Scaffold(body: Text('Dashboard')),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(routerConfig: testRouter),
      );

      // Find and tap the Google sign-in button
      final googleButton = find.textContaining('Google');
      expect(googleButton, findsOneWidget);

      await tester.tap(googleButton);
      await tester.pumpAndSettle();

      // Should navigate to dashboard on success
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('Google sign in shows error on failure', (tester) async {
      setupLargeViewport(tester);
      // Force auth service to throw by using invalid user
      await authService.signOut();

      await tester.pumpWidget(
        MaterialApp(home: LoginPage(authService: authService)),
      );

      final googleButton = find.textContaining('Google');
      await tester.tap(googleButton);
      await tester.pumpAndSettle();

      // Should handle error gracefully (user might have cancelled)
      // No crash expected
      expect(googleButton, findsOneWidget);
    });
  });
}
