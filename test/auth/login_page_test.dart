import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/auth/login_page.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  group('LoginPage Tests', () {
    testWidgets('renders with form elements', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('has email and password fields', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('displays Login title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('has LOGIN button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      expect(find.text('LOGIN'), findsOneWidget);
    });

    testWidgets('has Google Sign In button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      expect(find.textContaining('Google'), findsOneWidget);
    });

    testWidgets('has link to signup page', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      expect(find.textContaining('Sign up'), findsOneWidget);
    });

    testWidgets('validates email field when empty', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      // Tap login without entering anything
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      expect(find.text('This field is required'), findsWidgets);
    });

    testWidgets('validates email format', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      // Enter invalid email
      final emailFields = find.byType(TextFormField);
      await tester.enterText(emailFields.first, 'invalidemail');
      
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('validates password minimum length', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      // Enter valid email but short password
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'test@example.com');
      await tester.enterText(fields.last, '12345');
      
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });

    testWidgets('accepts valid email format', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      final emailFields = find.byType(TextFormField);
      await tester.enterText(emailFields.first, 'test@example.com');
      await tester.pump();

      // Valid email should not show error yet
      expect(find.text('Please enter a valid email address'), findsNothing);
    });

    testWidgets('has header widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('form fields are editable', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      final fields = find.byType(TextFormField);
      
      await tester.enterText(fields.first, 'user@test.com');
      await tester.enterText(fields.last, 'password123');
      await tester.pump();

      expect(find.text('user@test.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('has password field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      // Password field exists
      final fields = find.byType(TextFormField);
      expect(fields, findsNWidgets(2));
    });

    testWidgets('displays OR divider', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      expect(find.text('OR'), findsOneWidget);
    });

    testWidgets('has create account prompt', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginPage()),
      );

      expect(find.textContaining('Don\'t have an account?'), findsOneWidget);
    });
  });
}
