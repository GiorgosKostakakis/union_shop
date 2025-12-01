import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/about_page.dart';

import '../test_helpers.dart';

void main() {
  group('AboutPage', () {
    testWidgets('renders without errors', (tester) async {
      setupLargeViewport(tester);
      setupFirebaseMocks();

      await tester.pumpWidget(
        const MaterialApp(
          home: AboutPage(),
        ),
      );

      expect(find.byType(AboutPage), findsOneWidget);
    });

    testWidgets('displays hero section with title and subtitle', (tester) async {
      setupLargeViewport(tester);
      setupFirebaseMocks();

      await tester.pumpWidget(
        const MaterialApp(
          home: AboutPage(),
        ),
      );

      expect(find.text('About Union Shop'), findsOneWidget);
      expect(find.text('Your trusted student union shop'), findsOneWidget);
    });

    testWidgets('hero section has purple background', (tester) async {
      setupLargeViewport(tester);
      setupFirebaseMocks();

      await tester.pumpWidget(
        const MaterialApp(
          home: AboutPage(),
        ),
      );

      final heroContainer = tester.widget<Container>(
        find.ancestor(
          of: find.text('About Union Shop'),
          matching: find.byType(Container),
        ).first,
      );

      expect(heroContainer.color, const Color(0xFF4d2963));
    });

    testWidgets('displays About Us section with full text', (tester) async {
      setupLargeViewport(tester);
      setupFirebaseMocks();

      await tester.pumpWidget(
        const MaterialApp(
          home: AboutPage(),
        ),
      );

      // "About Us" appears in footer too, so check for at least one
      expect(find.text('About Us'), findsWidgets);
      expect(
        find.textContaining('Welcome to the Union Shop!'),
        findsOneWidget,
      );
      expect(
        find.textContaining('We\'re dedicated to giving you the very best University branded products'),
        findsOneWidget,
      );
      expect(
        find.textContaining('All online purchases are available for delivery or instore collection!'),
        findsOneWidget,
      );
      expect(
        find.textContaining('hello@upsu.net'),
        findsOneWidget,
      );
      expect(
        find.textContaining('Happy shopping!'),
        findsOneWidget,
      );
      expect(
        find.textContaining('The Union Shop & Reception Team'),
        findsOneWidget,
      );
    });

    testWidgets('is scrollable', (tester) async {
      setupLargeViewport(tester);
      setupFirebaseMocks();

      await tester.pumpWidget(
        const MaterialApp(
          home: AboutPage(),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('has header and footer', (tester) async {
      setupLargeViewport(tester);
      setupFirebaseMocks();

      await tester.pumpWidget(
        const MaterialApp(
          home: AboutPage(),
        ),
      );

      // Header and Footer widgets should be present
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(SingleChildScrollView),
          matching: find.byType(Column),
        ).first,
      );
      
      // Column should have multiple children (Header, hero, content, Footer)
      expect(column.children.length, greaterThan(2));
    });
  });
}
