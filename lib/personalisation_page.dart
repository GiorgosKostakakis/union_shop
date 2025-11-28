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
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
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
