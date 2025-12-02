import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/views/print_shack_about_page.dart';
import 'package:union_shop/views/personalisation_page.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  group('PrintShackAboutPage Tests', () {
    testWidgets('renders with title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PrintShackAboutPage()),
      );

      expect(find.text('About Print Shack'), findsOneWidget);
    });

    testWidgets('displays What is Print Shack section', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PrintShackAboutPage()),
      );

      expect(find.text('What is Print Shack?'), findsOneWidget);
      expect(find.textContaining('custom personalisation service'), findsOneWidget);
    });

    testWidgets('displays What We Offer section with features', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PrintShackAboutPage()),
      );

      expect(find.text('What We Offer'), findsOneWidget);
      expect(find.text('Text Personalisation'), findsOneWidget);
      expect(find.text('Logo Printing'), findsOneWidget);
      expect(find.text('Multiple Font Options'), findsOneWidget);
      expect(find.text('Flexible Placement'), findsOneWidget);
    });

    testWidgets('displays feature descriptions', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PrintShackAboutPage()),
      );

      expect(find.textContaining('Add custom text'), findsOneWidget);
      expect(find.textContaining('Upload your own logo'), findsOneWidget);
      expect(find.textContaining('variety of professional fonts'), findsOneWidget);
    });

    testWidgets('displays How It Works section with steps', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PrintShackAboutPage()),
      );

      expect(find.text('How It Works'), findsOneWidget);
      expect(find.text('Choose your personalisation option'), findsOneWidget);
      expect(find.text('Enter your text or upload your design'), findsOneWidget);
      expect(find.text('Select your preferred font and style'), findsOneWidget);
      expect(find.text('Preview your design in real-time'), findsOneWidget);
      expect(find.text('Add to cart and checkout'), findsOneWidget);
    });

    testWidgets('displays Quality Guarantee section', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PrintShackAboutPage()),
      );

      expect(find.text('Quality Guarantee'), findsOneWidget);
      expect(find.textContaining('high-quality materials'), findsOneWidget);
    });

    testWidgets('has START PERSONALISING button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PrintShackAboutPage()),
      );

      expect(find.text('START PERSONALISING'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('tapping START PERSONALISING button navigates to personalisation page', (tester) async {
      final router = GoRouter(
        initialLocation: '/print-shack-about',
        routes: [
          GoRoute(
            path: '/print-shack-about',
            builder: (context, state) => const PrintShackAboutPage(),
          ),
          GoRoute(
            path: '/personalisation',
            builder: (context, state) => const PersonalisationPage(),
          ),
        ],
      );
      
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );
      await tester.pumpAndSettle();

      // Scroll down to find the button
      await tester.dragUntilVisible(
        find.text('START PERSONALISING'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.pumpAndSettle();

      // Find and tap the button
      final button = find.text('START PERSONALISING');
      expect(button, findsOneWidget);
      
      await tester.tap(button);
      await tester.pumpAndSettle();

      // Should navigate to personalisation page
      expect(find.text('Print Shack - Text Personalisation'), findsOneWidget);
    });

    testWidgets('displays check icons for features', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PrintShackAboutPage()),
      );

      expect(find.byIcon(Icons.check_circle), findsWidgets);
    });

    testWidgets('displays numbered steps', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PrintShackAboutPage()),
      );

      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('has scrollable content', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PrintShackAboutPage()),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('has hero banner with correct color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PrintShackAboutPage()),
      );

      final container = tester.widget<Container>(
        find.ancestor(
          of: find.text('About Print Shack'),
          matching: find.byType(Container),
        ).first,
      );

      expect((container.decoration as BoxDecoration).color, const Color(0xFF4d2963));
    });

    testWidgets('content is constrained to max width', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PrintShackAboutPage()),
      );

      final constrainedBoxes = find.byType(ConstrainedBox);
      expect(constrainedBoxes, findsWidgets);

      // Find the one with maxWidth constraint of 800
      bool foundCorrectConstraint = false;
      for (int i = 0; i < tester.widgetList<ConstrainedBox>(constrainedBoxes).length; i++) {
        final widget = tester.widgetList<ConstrainedBox>(constrainedBoxes).elementAt(i);
        if (widget.constraints.maxWidth == 800) {
          foundCorrectConstraint = true;
          break;
        }
      }
      expect(foundCorrectConstraint, isTrue);
    });
  });
}
