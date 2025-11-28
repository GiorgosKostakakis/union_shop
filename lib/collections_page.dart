import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/models/fixtures.dart';
import 'package:union_shop/models/collection.dart';
import 'package:go_router/go_router.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  String _searchQuery = '';
  String _sortOption = 'Name'; // 'Name', 'Product Count High', 'Product Count Low'

  List<Collection> _getFilteredAndSortedCollections() {
    // Filter by search query
    var filtered = collections.where((collection) {
      return collection.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // Sort based on selected option
    switch (_sortOption) {
      case 'Name':
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Product Count High':
        filtered.sort((a, b) => b.products.length.compareTo(a.products.length));
        break;
      case 'Product Count Low':
        filtered.sort((a, b) => a.products.length.compareTo(b.products.length));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filteredCollections = _getFilteredAndSortedCollections();

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

            // Search and Sort Controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Use column layout on narrow screens
                  if (constraints.maxWidth < 600) {
                    return Column(
                      children: [
                        // Search Field
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search collections...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        // Sort Dropdown
                        DropdownButtonFormField<String>(
                          initialValue: _sortOption,
                          decoration: InputDecoration(
                            labelText: 'Sort by',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'Name', child: Text('Name')),
                            DropdownMenuItem(
                                value: 'Product Count High',
                                child: Text('Most')),
                            DropdownMenuItem(
                                value: 'Product Count Low',
                                child: Text('Fewest')),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _sortOption = value;
                              });
                            }
                          },
                        ),
                      ],
                    );
                  }

                  // Use row layout on wider screens
                  return Row(
                    children: [
                      // Search Field
                      Expanded(
                        flex: 2,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search collections...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Sort Dropdown
                      Expanded(
                        flex: 1,
                        child: DropdownButtonFormField<String>(
                          initialValue: _sortOption,
                          decoration: InputDecoration(
                            labelText: 'Sort by',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'Name', child: Text('Name')),
                            DropdownMenuItem(
                                value: 'Product Count High',
                                child: Text('Most')),
                            DropdownMenuItem(
                                value: 'Product Count Low',
                                child: Text('Fewest')),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _sortOption = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Results count
            if (_searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${filteredCollections.length} collection(s) found',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Collections Grid - filtered and sorted
            filteredCollections.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(48),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No collections found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 800 ? 3 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 1.2,
                      children: filteredCollections.map((Collection col) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to collection by id using go_router with context.go to update URL
                            context.go('/collections/${col.id}', extra: col);
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
                                    errorBuilder:
                                        (context, error, stackTrace) {
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        col.title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${col.products.length} product${col.products.length != 1 ? 's' : ''}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
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
