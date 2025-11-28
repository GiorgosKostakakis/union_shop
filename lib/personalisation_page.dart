import 'package:flutter/material.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/footer.dart';

class PersonalisationPage extends StatefulWidget {
  const PersonalisationPage({super.key});

  @override
  State<PersonalisationPage> createState() => _PersonalisationPageState();
}

class _PersonalisationPageState extends State<PersonalisationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),
            
            // Page Title
            Container(
              padding: const EdgeInsets.all(40),
              child: const Text(
                'Print Shack - Text Personalisation',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Placeholder for form content
            const Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                'Form will go here',
                style: TextStyle(fontSize: 18),
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
