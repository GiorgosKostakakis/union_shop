import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/footer.dart';

class PrintShackAboutPage extends StatelessWidget {
  const PrintShackAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),
            
            // Hero banner
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xFF4d2963),
              ),
              child: const Center(
                child: Text(
                  'About Print Shack',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Content
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What is Print Shack?',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Print Shack is our custom personalisation service that allows you to create unique, one-of-a-kind items with your own text and designs.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'What We Offer',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildFeatureItem(
                        'Text Personalisation',
                        'Add custom text to your items with your choice of font and style. Perfect for names, quotes, or special messages.',
                      ),
                      const SizedBox(height: 15),
                      _buildFeatureItem(
                        'Logo Printing',
                        'Upload your own logo or design to be printed on chest or back positions. Great for teams, clubs, or businesses.',
                      ),
                      const SizedBox(height: 15),
                      _buildFeatureItem(
                        'Multiple Font Options',
                        'Choose from a variety of professional fonts including Arial, Times New Roman, Georgia, and more.',
                      ),
                      const SizedBox(height: 15),
                      _buildFeatureItem(
                        'Flexible Placement',
                        'Select from one line, multiple lines, small logo chest placement, or large logo back placement.',
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'How It Works',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildStepItem('1', 'Choose your personalisation option'),
                      _buildStepItem('2', 'Enter your text or upload your design'),
                      _buildStepItem('3', 'Select your preferred font and style'),
                      _buildStepItem('4', 'Preview your design in real-time'),
                      _buildStepItem('5', 'Add to cart and checkout'),
                      const SizedBox(height: 30),
                      const Text(
                        'Quality Guarantee',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'All our personalised items are printed using high-quality materials and techniques to ensure durability and vibrant colors. Each item is carefully inspected before shipping to maintain our quality standards.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context.go('/personalisation');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            'START PERSONALISING',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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

  Widget _buildFeatureItem(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle,
          color: Color(0xFF4d2963),
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFF4d2963),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
