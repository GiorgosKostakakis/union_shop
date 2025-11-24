import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/models/fixtures.dart';
import 'package:union_shop/models/collection.dart';
import 'package:go_router/go_router.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
                // Header
                const Header(),

            // Collections Title Section
            Container(
              padding: const EdgeInsets.all(40),
              child: const Text(
                'Collections',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Collections Grid - generated from fixtures
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.2,
                  children: collections.map((Collection col) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to collection by id using go_router
                        context.push('/collections/${col.id}', extra: col);
                      },
                      child: Card(
                        elevation: 2,
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: Image.asset(
                                col.imageUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 64,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                col.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )),
            const SizedBox(height: 40),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}
