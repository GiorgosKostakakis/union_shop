import 'package:flutter/material.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/footer.dart';

class PersonalisationPage extends StatefulWidget {
  const PersonalisationPage({super.key});

  @override
  State<PersonalisationPage> createState() => _PersonalisationPageState();
}

class _PersonalisationPageState extends State<PersonalisationPage> {
  String personalisationText = '';
  String selectedFont = 'Arial';
  String perLineOption = 'One Line of Text';
  int quantity = 1;

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
                        width: constraints.maxWidth >= 800 ? 420 : double.infinity,
                        child: Center(
                          child: Container(
                            height: constraints.maxWidth >= 800 ? 420 : 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                            ),
                            child: Center(
                              child: Text(
                                'Preview Area',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
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
                              DropdownMenuItem(value: 'One Line of Text', child: Text('One Line of Text')),
                              DropdownMenuItem(value: 'Two Lines', child: Text('Two Lines')),
                              DropdownMenuItem(value: 'Three Lines', child: Text('Three Lines')),
                              DropdownMenuItem(value: 'Four Lines', child: Text('Four Lines')),
                              DropdownMenuItem(value: 'Small Logo Chest', child: Text('Small Logo Chest')),
                              DropdownMenuItem(value: 'Large Logo Back', child: Text('Large Logo Back')),
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

                          // Text input
                          const Text(
                            'Enter Your Text',
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
                              hintText: 'Type your personalisation text here...',
                            ),
                            onChanged: (value) {
                              setState(() {
                                personalisationText = value;
                              });
                            },
                          ),
                          const SizedBox(height: 24),

                          // Font dropdown
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
                              DropdownMenuItem(value: 'Arial', child: Text('Arial')),
                              DropdownMenuItem(value: 'Times New Roman', child: Text('Times New Roman')),
                              DropdownMenuItem(value: 'Courier New', child: Text('Courier New')),
                              DropdownMenuItem(value: 'Georgia', child: Text('Georgia')),
                              DropdownMenuItem(value: 'Verdana', child: Text('Verdana')),
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
                                // TODO: Add to cart logic
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4d2963),
                                padding: const EdgeInsets.symmetric(vertical: 16),
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

