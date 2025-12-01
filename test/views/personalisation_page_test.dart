import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/views/personalisation_page.dart';
import 'package:union_shop/models/cart.dart';
import '../test_helpers.dart';

void main() {
  setupFirebaseMocks();

  setUp(() {
    Cart().clear();
  });

  group('PersonalisationPage Tests', () {
    testWidgets('renders with default state', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('Preview Area\nYour text will appear here'), findsOneWidget);
      expect(find.text('Print Shack - Text Personalisation'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
    });

    testWidgets('displays "Learn more" link', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('Learn more about Print Shack →'), findsOneWidget);
    });

    testWidgets('has personalisation options dropdown', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.byType(DropdownButtonFormField<String>), findsWidgets);
      expect(find.text('Per Line'), findsOneWidget);
    });

    testWidgets('has text input field for One Line option', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('Enter Your Text - Line 1'), findsOneWidget);
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('displays entered text in preview', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Find text field and enter text
      final textField = find.widgetWithText(TextField, 'Type line 1 here...');
      await tester.enterText(textField, 'Test Text');
      await tester.pump();

      expect(find.text('Test Text'), findsWidgets);
    });

    testWidgets('shows font selection dropdown for text options', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('Select Font'), findsOneWidget);
      expect(find.text('Arial'), findsWidgets);
    });

    testWidgets('can change font selection', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Find the font dropdown (second dropdown)
      final fontDropdowns = find.byType(DropdownButtonFormField<String>);
      expect(fontDropdowns, findsAtLeastNWidgets(2));
      
      // Tap the font dropdown
      await tester.tap(fontDropdowns.at(1));
      await tester.pumpAndSettle();

      // Select Times New Roman
      await tester.tap(find.text('Times New Roman').last);
      await tester.pumpAndSettle();

      expect(find.text('Times New Roman'), findsWidgets);
    });

    testWidgets('has quantity controls', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('Quantity'), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsWidgets);
      expect(find.byIcon(Icons.add), findsWidgets);
    });

    testWidgets('increments quantity when + button tapped', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Find the add button in quantity section
      final addButtons = find.byIcon(Icons.add);
      await tester.tap(addButtons.last);
      await tester.pump();

      expect(find.text('2'), findsWidgets);
    });

    testWidgets('decrements quantity when - button tapped', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // First increment to 2
      final addButtons = find.byIcon(Icons.add);
      await tester.tap(addButtons.last);
      await tester.pump();

      // Then decrement
      final removeButtons = find.byIcon(Icons.remove);
      await tester.tap(removeButtons.first);
      await tester.pump();

      expect(find.text('1'), findsWidgets);
    });

    testWidgets('does not decrement quantity below 1', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Try to decrement from 1
      final removeButtons = find.byIcon(Icons.remove);
      await tester.tap(removeButtons.first);
      await tester.pump();

      // Should still be 1
      expect(find.text('1'), findsWidgets);
    });

    testWidgets('has ADD TO CART button', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('ADD TO CART'), findsOneWidget);
    });

    testWidgets('shows validation error when adding to cart without text', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Tap ADD TO CART without entering text
      await tester.tap(find.text('ADD TO CART'));
      await tester.pump();

      expect(find.text('Please enter text for at least line 1'), findsOneWidget);
    });

    testWidgets('adds item to cart with text', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Enter text
      final textField = find.widgetWithText(TextField, 'Type line 1 here...');
      await tester.enterText(textField, 'My Custom Text');
      await tester.pump();

      // Tap ADD TO CART
      await tester.tap(find.text('ADD TO CART'));
      await tester.pump();

      // Check success message
      expect(find.text('Added to cart!'), findsOneWidget);
      expect(Cart().items.length, 1);
    });

    testWidgets('switches to Two Lines option', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Tap the Per Line dropdown
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();

      // Select Two Lines
      await tester.tap(find.text('Two Lines').last);
      await tester.pumpAndSettle();

      // Should show Line 2 input
      expect(find.text('Enter Your Text - Line 2'), findsOneWidget);
    });

    testWidgets('displays two lines of text in preview', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to Two Lines
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Two Lines').last);
      await tester.pumpAndSettle();

      // Enter text in line 1
      final line1Field = find.widgetWithText(TextField, 'Type line 1 here...');
      await tester.enterText(line1Field, 'Line One');
      await tester.pump();

      // Enter text in line 2
      final line2Field = find.widgetWithText(TextField, 'Type line 2 here...');
      await tester.enterText(line2Field, 'Line Two');
      await tester.pump();

      expect(find.text('Line One'), findsWidgets);
      expect(find.text('Line Two'), findsWidgets);
    });

    testWidgets('switches to Three Lines option', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to Three Lines
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Three Lines').last);
      await tester.pumpAndSettle();

      // Should show Line 2 and Line 3 inputs
      expect(find.text('Enter Your Text - Line 2'), findsOneWidget);
      expect(find.text('Enter Your Text - Line 3'), findsOneWidget);
    });

    testWidgets('displays three lines of text in preview', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to Three Lines
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Three Lines').last);
      await tester.pumpAndSettle();

      // Enter text in all three lines
      final line1Field = find.widgetWithText(TextField, 'Type line 1 here...');
      await tester.enterText(line1Field, 'Line One');
      await tester.pump();

      final line2Field = find.widgetWithText(TextField, 'Type line 2 here...');
      await tester.enterText(line2Field, 'Line Two');
      await tester.pump();

      final line3Field = find.widgetWithText(TextField, 'Type line 3 here...');
      await tester.enterText(line3Field, 'Line Three');
      await tester.pump();

      expect(find.text('Line One'), findsWidgets);
      expect(find.text('Line Two'), findsWidgets);
      expect(find.text('Line Three'), findsWidgets);
    });

    testWidgets('switches to Four Lines option', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to Four Lines
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Four Lines').last);
      await tester.pumpAndSettle();

      // Should show all 4 line inputs
      expect(find.text('Enter Your Text - Line 1'), findsOneWidget);
      expect(find.text('Enter Your Text - Line 2'), findsOneWidget);
      expect(find.text('Enter Your Text - Line 3'), findsOneWidget);
      expect(find.text('Enter Your Text - Line 4'), findsOneWidget);
    });

    testWidgets('displays four lines of text in preview', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to Four Lines
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Four Lines').last);
      await tester.pumpAndSettle();

      // Enter text in all four lines
      final line1Field = find.widgetWithText(TextField, 'Type line 1 here...');
      await tester.enterText(line1Field, 'Line 1');
      await tester.pump();

      final line2Field = find.widgetWithText(TextField, 'Type line 2 here...');
      await tester.enterText(line2Field, 'Line 2');
      await tester.pump();

      final line3Field = find.widgetWithText(TextField, 'Type line 3 here...');
      await tester.enterText(line3Field, 'Line 3');
      await tester.pump();

      final line4Field = find.widgetWithText(TextField, 'Type line 4 here...');
      await tester.enterText(line4Field, 'Line 4');
      await tester.pump();

      expect(find.text('Line 1'), findsWidgets);
      expect(find.text('Line 2'), findsWidgets);
      expect(find.text('Line 3'), findsWidgets);
      expect(find.text('Line 4'), findsWidgets);
    });

    testWidgets('switches to Small Logo Chest option', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to Small Logo Chest
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Small Logo Chest').last);
      await tester.pumpAndSettle();

      // Should show logo upload UI
      expect(find.text('Upload Your Logo'), findsOneWidget);
      expect(find.text('Click to upload logo'), findsOneWidget);
      expect(find.byIcon(Icons.cloud_upload_outlined), findsOneWidget);
    });

    testWidgets('shows logo preview for Small Logo Chest', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to Small Logo Chest
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Small Logo Chest').last);
      await tester.pumpAndSettle();

      // Should show logo preview - icon appears in preview area, not upload UI
      expect(find.text('Logo Preview\n(Upload feature coming soon)'), findsOneWidget);
      expect(find.text('Small Logo Chest'), findsWidgets);
    });

    testWidgets('switches to Large Logo Back option', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to Large Logo Back
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Large Logo Back').last);
      await tester.pumpAndSettle();

      // Should show logo upload UI
      expect(find.text('Upload Your Logo'), findsOneWidget);
      expect(find.text('Click to upload logo'), findsOneWidget);
    });

    testWidgets('shows logo preview for Large Logo Back', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to Large Logo Back
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Large Logo Back').last);
      await tester.pumpAndSettle();

      // Should show logo preview
      expect(find.text('Logo Preview\n(Upload feature coming soon)'), findsOneWidget);
      expect(find.text('Large Logo Back'), findsWidgets);
    });

    testWidgets('shows coming soon message for logo upload', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to logo option
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Small Logo Chest').last);
      await tester.pumpAndSettle();

      // Tap ADD TO CART
      await tester.tap(find.text('ADD TO CART'));
      await tester.pump();

      expect(find.text('Logo upload feature coming soon!'), findsOneWidget);
    });

    testWidgets('hides text inputs for logo options', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to logo option
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Small Logo Chest').last);
      await tester.pumpAndSettle();

      // Should not show text inputs or font selector
      expect(find.text('Enter Your Text - Line 1'), findsNothing);
      expect(find.text('Select Font'), findsNothing);
    });

    testWidgets('adds multi-line item to cart', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to Two Lines
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Two Lines').last);
      await tester.pumpAndSettle();

      // Enter text
      final line1Field = find.widgetWithText(TextField, 'Type line 1 here...');
      await tester.enterText(line1Field, 'First');
      await tester.pump();

      final line2Field = find.widgetWithText(TextField, 'Type line 2 here...');
      await tester.enterText(line2Field, 'Second');
      await tester.pump();

      // Tap ADD TO CART
      await tester.tap(find.text('ADD TO CART'));
      await tester.pump();

      expect(find.text('Added to cart!'), findsOneWidget);
      expect(Cart().items.length, 1);
    });

    testWidgets('can change font to Courier New', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Tap the font dropdown
      final fontDropdowns = find.byType(DropdownButtonFormField<String>);
      await tester.tap(fontDropdowns.at(1));
      await tester.pumpAndSettle();

      // Select Courier New
      await tester.tap(find.text('Courier New').last);
      await tester.pumpAndSettle();

      expect(find.text('Courier New'), findsWidgets);
    });

    testWidgets('can change font to Georgia', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Tap the font dropdown
      final fontDropdowns = find.byType(DropdownButtonFormField<String>);
      await tester.tap(fontDropdowns.at(1));
      await tester.pumpAndSettle();

      // Select Georgia
      await tester.tap(find.text('Georgia').last);
      await tester.pumpAndSettle();

      expect(find.text('Georgia'), findsWidgets);
    });

    testWidgets('can change font to Verdana', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Tap the font dropdown
      final fontDropdowns = find.byType(DropdownButtonFormField<String>);
      await tester.tap(fontDropdowns.at(1));
      await tester.pumpAndSettle();

      // Select Verdana
      await tester.tap(find.text('Verdana').last);
      await tester.pumpAndSettle();

      expect(find.text('Verdana'), findsWidgets);
    });

    testWidgets('has scrollable content', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('displays preview container', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('content is constrained to max width', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.byType(ConstrainedBox), findsWidgets);
    });

    testWidgets('increments quantity multiple times', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      final addButtons = find.byIcon(Icons.add);
      
      // Increment to 3
      await tester.tap(addButtons.last);
      await tester.pump();
      await tester.tap(addButtons.last);
      await tester.pump();

      expect(find.text('3'), findsWidgets);
    });

    testWidgets('adds item to cart with custom quantity', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Increment quantity
      final addButtons = find.byIcon(Icons.add);
      await tester.tap(addButtons.last);
      await tester.pump();

      // Enter text
      final textField = find.widgetWithText(TextField, 'Type line 1 here...');
      await tester.enterText(textField, 'Test');
      await tester.pump();

      // Add to cart
      await tester.tap(find.text('ADD TO CART'));
      await tester.pump();

      expect(Cart().items.length, 1);
      expect(Cart().items.first.quantity, 2);
    });

    testWidgets('shows logo preview when switching to logo option even without text', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Enter some text first
      final textField = find.widgetWithText(TextField, 'Type line 1 here...');
      await tester.enterText(textField, 'Some text');
      await tester.pump();

      // Switch to logo option
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Small Logo Chest').last);
      await tester.pumpAndSettle();

      // Should show logo preview with icon and option name (text persists in state)
      expect(find.text('Small Logo Chest'), findsWidgets);
    });

    testWidgets('shows default preview when no text entered', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      expect(find.text('Preview Area\nYour text will appear here'), findsOneWidget);
    });

    testWidgets('shows logo preview message when no logo uploaded', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to logo option before entering any text
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Small Logo Chest').last);
      await tester.pumpAndSettle();

      // Should show logo preview placeholder
      expect(find.text('Logo Preview\n(Upload feature coming soon)'), findsOneWidget);
    });

    testWidgets('Learn more link navigates to print shack about page', (tester) async {
      setupLargeViewport(tester);
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const PersonalisationPage(),
          ),
          GoRoute(
            path: '/print-shack-about',
            builder: (context, state) => const Scaffold(body: Text('Print Shack About')),
          ),
        ],
      );
      
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      // Tap the Learn more link
      await tester.tap(find.text('Learn more about Print Shack →'));
      await tester.pumpAndSettle();

      expect(find.text('Print Shack About'), findsOneWidget);
    });

    testWidgets('adds three line text with all lines in description', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to Three Lines
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Three Lines').last);
      await tester.pumpAndSettle();

      // Enter all three lines
      final line1Field = find.widgetWithText(TextField, 'Type line 1 here...');
      await tester.enterText(line1Field, 'First');
      await tester.pump();

      final line2Field = find.widgetWithText(TextField, 'Type line 2 here...');
      await tester.enterText(line2Field, 'Second');
      await tester.pump();

      final line3Field = find.widgetWithText(TextField, 'Type line 3 here...');
      await tester.enterText(line3Field, 'Third');
      await tester.pump();

      // Add to cart
      await tester.tap(find.text('ADD TO CART'));
      await tester.pump();

      expect(Cart().items.length, 1);
      expect(Cart().items.first.product.title, 'Print Shack - Three Lines');
      expect(Cart().items.first.selectedColor, contains('First'));
      expect(Cart().items.first.selectedColor, contains('Second'));
      expect(Cart().items.first.selectedColor, contains('Third'));
    });

    testWidgets('adds four line text with all lines in description', (tester) async {
      setupLargeViewport(tester);
      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Switch to Four Lines
      final perLineDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(perLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Four Lines').last);
      await tester.pumpAndSettle();

      // Enter all four lines
      final line1Field = find.widgetWithText(TextField, 'Type line 1 here...');
      await tester.enterText(line1Field, 'L1');
      await tester.pump();

      final line2Field = find.widgetWithText(TextField, 'Type line 2 here...');
      await tester.enterText(line2Field, 'L2');
      await tester.pump();

      final line3Field = find.widgetWithText(TextField, 'Type line 3 here...');
      await tester.enterText(line3Field, 'L3');
      await tester.pump();

      final line4Field = find.widgetWithText(TextField, 'Type line 4 here...');
      await tester.enterText(line4Field, 'L4');
      await tester.pump();

      // Add to cart
      await tester.tap(find.text('ADD TO CART'));
      await tester.pump();

      expect(Cart().items.length, 1);
      expect(Cart().items.first.product.title, 'Print Shack - Four Lines');
      expect(Cart().items.first.selectedColor, contains('L1'));
      expect(Cart().items.first.selectedColor, contains('L2'));
      expect(Cart().items.first.selectedColor, contains('L3'));
      expect(Cart().items.first.selectedColor, contains('L4'));
    });

    testWidgets('VIEW CART snackbar action navigates to cart', (tester) async {
      setupLargeViewport(tester);
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const PersonalisationPage(),
          ),
          GoRoute(
            path: '/cart',
            builder: (context, state) => const Scaffold(body: Text('Cart Page')),
          ),
        ],
      );
      
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      // Enter text
      final textField = find.widgetWithText(TextField, 'Type line 1 here...');
      await tester.enterText(textField, 'Test');
      await tester.pump();

      // Add to cart
      await tester.tap(find.text('ADD TO CART'));
      await tester.pump();

      // Tap VIEW CART - use ensureVisible to bring into viewport
      await tester.ensureVisible(find.text('VIEW CART'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('VIEW CART'));
      await tester.pumpAndSettle();

      expect(find.text('Cart Page'), findsOneWidget);
    });

    testWidgets('uses narrow layout on small screen', (tester) async {
      // Set narrow viewport (less than 800px)
      tester.view.physicalSize = const Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const MaterialApp(home: PersonalisationPage()),
      );

      // Should use Column layout (stacked)
      expect(find.byType(Column), findsWidgets);
    });
  });
}
