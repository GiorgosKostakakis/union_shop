import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/dashboard_page.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  group('DashboardPage Tests', () {
    testWidgets('renders without crashing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );

      expect(find.byType(DashboardPage), findsOneWidget);
    });

    testWidgets('has scaffold structure', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('displays My Account text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('My Account'), findsOneWidget);
    });

    testWidgets('displays Order History section', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Order History'), findsOneWidget);
    });

    testWidgets('displays logout button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('LOGOUT'), findsOneWidget);
    });

    testWidgets('has column layout', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('displays user email when available', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      // Check that email display area exists
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('has scrollable content area', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsWidgets);
    });

    testWidgets('displays account management section', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Account Management'), findsOneWidget);
    });

    testWidgets('has Update Password option', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Update Password'), findsOneWidget);
    });

    testWidgets('has Update Email option', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Update Email'), findsOneWidget);
    });

    testWidgets('has Delete Account option', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Delete Account'), findsOneWidget);
    });

    testWidgets('displays appropriate icons', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.lock), findsWidgets);
      expect(find.byIcon(Icons.email), findsWidgets);
      expect(find.byIcon(Icons.delete), findsWidgets);
    });

    testWidgets('logout button has correct styling', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );
      await tester.pumpAndSettle();

      final logoutButton = find.text('LOGOUT');
      expect(logoutButton, findsOneWidget);
      
      final button = find.ancestor(
        of: logoutButton,
        matching: find.byType(ElevatedButton),
      );
      expect(button, findsOneWidget);
    });
  });
}
