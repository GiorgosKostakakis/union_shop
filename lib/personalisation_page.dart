import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';

class PersonalisationPage extends StatefulWidget {
  const PersonalisationPage({super.key});

  @override
  State<PersonalisationPage> createState() => _PersonalisationPageState();
}

class _PersonalisationPageState extends State<PersonalisationPage> {
  String personalisationText = '';
  String line2Text = '';
  String line3Text = '';
  String line4Text = '';
  String selectedFont = 'Arial';
  String perLineOption = 'One Line of Text';
  int quantity = 1;

  bool get isTextOption => perLineOption.contains('Line');
  bool get isLogoOption => perLineOption.contains('Logo');
  int get numberOfLines {
    if (perLineOption == 'One Line of Text') return 1;
    if (perLineOption == 'Two Lines') return 2;
    if (perLineOption == 'Three Lines') return 3;
    if (perLineOption == 'Four Lines') return 4;
    return 1;
  }

  String _getFontFamily(String font) {
    // Map font names to Flutter-supported fonts
    switch (font) {
      case 'Times New Roman':
        return 'serif';
      case 'Courier New':
        return 'monospace';
      default:
        return 'sans-serif';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),

            // Product-style layout: centered max-width container
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(24),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Preview/Image area (left side on desktop)
                      final Widget previewWidget = SizedBox(
                        width:
                            constraints.maxWidth >= 800 ? 420 : double.infinity,
                        child: Center(
                          child: Container(
                            height: constraints.maxWidth >= 800 ? 420 : 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                            ),
                            child: Center(
                              child: personalisationText.isEmpty &&
                                      line2Text.isEmpty &&
                                      line3Text.isEmpty &&
                                      line4Text.isEmpty
                                  ? Text(
                                      isLogoOption
                                          ? 'Logo Preview\n(Upload feature coming soon)'
                                          : 'Preview Area\nYour text will appear here',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                      ),
                                    )
                                  : isLogoOption
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.image_outlined,
                                              size: perLineOption ==
                                                      'Small Logo Chest'
                                                  ? 80
                                                  : 150,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              perLineOption,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (personalisationText.isNotEmpty)
                                              Text(
                                                personalisationText,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontFamily: _getFontFamily(
                                                      selectedFont),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            if (numberOfLines >= 2 &&
                                                line2Text.isNotEmpty) ...[
                                              const SizedBox(height: 8),
                                              Text(
                                                line2Text,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontFamily: _getFontFamily(
                                                      selectedFont),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                            if (numberOfLines >= 3 &&
                                                line3Text.isNotEmpty) ...[
                                              const SizedBox(height: 8),
                                              Text(
                                                line3Text,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontFamily: _getFontFamily(
                                                      selectedFont),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                            if (numberOfLines >= 4 &&
                                                line4Text.isNotEmpty) ...[
                                              const SizedBox(height: 8),
                                              Text(
                                                line4Text,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontFamily: _getFontFamily(
                                                      selectedFont),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                            ),
                          ),
                        ),
                      );

                      // Form/Details column (right side on desktop)
                      final Widget detailsContent = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Page title
                          const Text(
                            'Print Shack - Text Personalisation',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              context.go('/print-shack-about');
                            },
                            child: const Text(
                              'Learn more about Print Shack →',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4d2963),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '£15.00',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4d2963),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Per Line dropdown
                          const Text(
                            'Per Line',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: perLineOption,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(
                                  value: 'One Line of Text',
                                  child: Text('One Line of Text')),
                              DropdownMenuItem(
                                  value: 'Two Lines', child: Text('Two Lines')),
                              DropdownMenuItem(
                                  value: 'Three Lines',
                                  child: Text('Three Lines')),
                              DropdownMenuItem(
                                  value: 'Four Lines',
                                  child: Text('Four Lines')),
                              DropdownMenuItem(
                                  value: 'Small Logo Chest',
                                  child: Text('Small Logo Chest')),
                              DropdownMenuItem(
                                  value: 'Large Logo Back',
                                  child: Text('Large Logo Back')),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  perLineOption = value;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 24),

                          // Text input fields (shown only for text options)
                          if (isTextOption) ...[
                            const Text(
                              'Enter Your Text - Line 1',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              maxLength: 50,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Type line 1 here...',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  personalisationText = value;
                                });
                              },
                            ),
                            const SizedBox(height: 24),
                          ],

                          // Line 2 (shown only for 2+ lines)
                          if (numberOfLines >= 2) ...[
                            const Text(
                              'Enter Your Text - Line 2',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              maxLength: 50,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Type line 2 here...',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  line2Text = value;
                                });
                              },
                            ),
                            const SizedBox(height: 24),
                          ],

                          // Line 3 (shown only for 3+ lines)
                          if (numberOfLines >= 3) ...[
                            const Text(
                              'Enter Your Text - Line 3',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              maxLength: 50,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Type line 3 here...',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  line3Text = value;
                                });
                              },
                            ),
                            const SizedBox(height: 24),
                          ],

                          // Line 4 (shown only for 4 lines)
                          if (numberOfLines >= 4) ...[
                            const Text(
                              'Enter Your Text - Line 4',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              maxLength: 50,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Type line 4 here...',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  line4Text = value;
                                });
                              },
                            ),
                            const SizedBox(height: 24),
                          ],

                          // Logo upload placeholder (shown only for logo options)
                          if (isLogoOption) ...[
                            const Text(
                              'Upload Your Logo',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(40),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    size: 48,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Click to upload logo',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '(Feature coming soon)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],

                          // Font dropdown (shown only for text options)
                          if (isTextOption) ...[
                            const Text(
                              'Select Font',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: selectedFont,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 'Arial', child: Text('Arial')),
                                DropdownMenuItem(
                                    value: 'Times New Roman',
                                    child: Text('Times New Roman')),
                                DropdownMenuItem(
                                    value: 'Courier New',
                                    child: Text('Courier New')),
                                DropdownMenuItem(
                                    value: 'Georgia', child: Text('Georgia')),
                                DropdownMenuItem(
                                    value: 'Verdana', child: Text('Verdana')),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedFont = value;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                          ],

                          // Quantity selector
                          const Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                              ),
                              Text(
                                '$quantity',
                                style: const TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Add to Cart button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Validation based on option type
                                if (isTextOption &&
                                    personalisationText.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please enter text for at least line 1'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                }

                                if (isLogoOption) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Logo upload feature coming soon!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                }

                                // Build description for multi-line text
                                String textDescription = personalisationText;
                                if (numberOfLines >= 2 &&
                                    line2Text.isNotEmpty) {
                                  textDescription += ' | $line2Text';
                                }
                                if (numberOfLines >= 3 &&
                                    line3Text.isNotEmpty) {
                                  textDescription += ' | $line3Text';
                                }
                                if (numberOfLines >= 4 &&
                                    line4Text.isNotEmpty) {
                                  textDescription += ' | $line4Text';
                                }

                                // Create a custom product for the personalised item
                                final personalisedProduct = Product(
                                  id: 'personalised-${DateTime.now().millisecondsSinceEpoch}',
                                  title: 'Print Shack - $perLineOption',
                                  price: '£15.00',
                                  imageUrl: 'assets/product1.png',
                                );

                                // Add to cart with custom options
                                Cart().addItem(
                                  product: personalisedProduct,
                                  quantity: quantity,
                                  selectedSize: perLineOption,
                                  selectedColor:
                                      'Text: $textDescription, Font: $selectedFont',
                                );

                                // Show success message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Added to cart!'),
                                    duration: const Duration(seconds: 2),
                                    action: SnackBarAction(
                                      label: 'VIEW CART',
                                      onPressed: () {
                                        context.go('/cart');
                                      },
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4d2963),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text(
                                'ADD TO CART',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );

                      // Responsive layout: side-by-side on wide screens, stacked on narrow
                      if (constraints.maxWidth >= 800) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            previewWidget,
                            const SizedBox(width: 32),
                            Expanded(child: detailsContent),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            previewWidget,
                            const SizedBox(height: 24),
                            detailsContent,
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
