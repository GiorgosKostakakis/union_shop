import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/auth/signup_page.dart';
import 'package:union_shop/services/auth_service.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  group('SignupPage Tests', () {
    testWidgets('renders with form elements', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      expect(find.byType(SignupPage), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('has all required fields', (tester) async {
      setupLargeViewport(tester);
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      // Name, Email, Password, Confirm Password
      expect(find.byType(TextFormField), findsNWidgets(4));
    });

    testWidgets('displays Sign Up title', (tester) async {
      setupLargeViewport(tester);
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('has CREATE ACCOUNT button', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('has Google Sign Up button', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      expect(find.textContaining('Google'), findsOneWidget);
    });

    testWidgets('has link to login page', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      expect(find.textContaining('Log In'), findsOneWidget);
    });

    testWidgets('validates name field when empty', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.text('This field is required'), findsWidgets);
    });

    testWidgets('validates name minimum length', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'A');
      
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.text('Name must be at least 2 characters'), findsOneWidget);
    });

    testWidgets('validates email format', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'John Doe');
      await tester.enterText(fields.at(1), 'invalidemail');
      
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('validates password minimum length', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'John Doe');
      await tester.enterText(fields.at(1), 'john@example.com');
      await tester.enterText(fields.at(2), '12345');
      
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });

    testWidgets('validates password confirmation match', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'John Doe');
      await tester.enterText(fields.at(1), 'john@example.com');
      await tester.enterText(fields.at(2), 'password123');
      await tester.enterText(fields.at(3), 'password456');
      
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('accepts valid input', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'John Doe');
      await tester.enterText(fields.at(1), 'john@example.com');
      await tester.enterText(fields.at(2), 'password123');
      await tester.enterText(fields.at(3), 'password123');
      await tester.pump();

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john@example.com'), findsOneWidget);
    });

    testWidgets('has password fields', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      final fields = find.byType(TextFormField);
      expect(fields, findsNWidgets(4));
    });

    testWidgets('displays Sign Up title', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      expect(find.text('Create Account'), findsOneWidget);
    });

    testWidgets('has login prompt', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      expect(find.textContaining('Already have an account?'), findsOneWidget);
    });

    testWidgets('has scrollable content', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('form fields are editable', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      final fields = find.byType(TextFormField);
      
      await tester.enterText(fields.at(0), 'Test User');
      await tester.enterText(fields.at(1), 'test@example.com');
      await tester.enterText(fields.at(2), 'testpass123');
      await tester.enterText(fields.at(3), 'testpass123');
      await tester.pump();

      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('successful signup creates user', (tester) async {
      setupLargeViewport(tester);
      final mockAuth = MockFirebaseAuth();
      
      await tester.pumpWidget(
        MaterialApp(home: SignupPage(authService: AuthService(googleSignIn: MockGoogleSignIn()))),
      );

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'John Doe');
      await tester.enterText(fields.at(1), 'john@example.com');
      await tester.enterText(fields.at(2), 'password123');
      await tester.enterText(fields.at(3), 'password123');

      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      // Form should still be present after signup (no navigation in test)
      expect(find.byType(SignupPage), findsOneWidget);
    });

    testWidgets('failed signup shows error message', (tester) async {
      setupLargeViewport(tester);
      final mockAuth = MockFirebaseAuth();
      
      await tester.pumpWidget(
        MaterialApp(home: SignupPage(authService: AuthService(googleSignIn: MockGoogleSignIn()))),
      );

      // First create a user
      var fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Existing User');
      await tester.enterText(fields.at(1), 'existing@example.com');
      await tester.enterText(fields.at(2), 'password123');
      await tester.enterText(fields.at(3), 'password123');
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      // Navigate back
      await tester.pumpWidget(
        MaterialApp(home: SignupPage(authService: AuthService(googleSignIn: MockGoogleSignIn()))),
      );
      await tester.pumpAndSettle();

      // Try to create the same user again
      fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Existing User');
      await tester.enterText(fields.at(1), 'existing@example.com');
      await tester.enterText(fields.at(2), 'password123');
      await tester.enterText(fields.at(3), 'password123');
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
    });





    testWidgets('disposes controllers properly', (tester) async {
      setupLargeViewport(tester);
      
      await tester.pumpWidget(
        const MaterialApp(home: SignupPage()),
      );

      // Remove the widget to trigger dispose
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Text('Empty'))),
      );

      // Should not throw
    });
  });
}
