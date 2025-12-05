import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/header.dart';
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
  String _sortOption =
      'Name'; // 'Name', 'Product Count High', 'Product Count Low'
  int _currentPage = 1;
  final int _itemsPerPage = 6;

  List<Collection> _getFilteredAndSortedCollections() {
    // Filter by search query
    var filtered = collections.where((collection) {
      return collection.title
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
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

  List<Collection> _getPaginatedCollections(List<Collection> collections) {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;

    if (startIndex >= collections.length) {
      return [];
    }

    return collections.sublist(
      startIndex,
      endIndex > collections.length ? collections.length : endIndex,
    );
  }

  int _getTotalPages(List<Collection> collections) {
    return (collections.length / _itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCollections = _getFilteredAndSortedCollections();
    final paginatedCollections = _getPaginatedCollections(filteredCollections);
    final totalPages = _getTotalPages(filteredCollections);

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Use column layout on narrow screens
                  if (constraints.maxWidth < 600) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              _currentPage = 1;
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
                            DropdownMenuItem(
                                value: 'Name', child: Text('Name (A-Z)')),
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
                                _currentPage = 1;
                              });
                            }
                          },
                        ),
                      ],
                    );
                  }

                  // Use row layout on wider screens
                  return Row(
                    mainAxisSize: MainAxisSize.min,
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
                              _currentPage = 1;
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
                            DropdownMenuItem(
                                value: 'Name', child: Text('Name (A-Z)')),
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
                                _currentPage = 1;
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

            // Results count and pagination info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_searchQuery.isNotEmpty)
                    Text(
                      '${filteredCollections.length} collection(s) found',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  if (totalPages > 1)
                    Text(
                      'Page $_currentPage of $totalPages',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                ],
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 1;
                        if (constraints.maxWidth > 1200) {
                          crossAxisCount = 3;
                        } else if (constraints.maxWidth > 600) {
                          crossAxisCount = 2;
                        }

                        return GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.2,
                          children: paginatedCollections.map((Collection col) {
                            return GestureDetector(
                              onTap: () {
                                // Navigate to collection by id using go_router with context.go to update URL
                                context.go('/collections/${col.id}',
                                    extra: col);
                              },
                              child: Card(
                                elevation: 2,
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        col.imageUrl,
                                        fit: BoxFit.contain,
                                        width: double.infinity,
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
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            col.title,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 24),

            // Pagination Controls
            if (totalPages > 1)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Previous button
                      IconButton(
                        onPressed: _currentPage > 1
                            ? () {
                                setState(() {
                                  _currentPage--;
                                });
                              }
                            : null,
                        icon: const Icon(Icons.chevron_left),
                        tooltip: 'Previous page',
                      ),
                      const SizedBox(width: 16),

                      // Page numbers
                      ...List.generate(totalPages, (index) {
                        final pageNum = index + 1;

                        // Show first page, last page, current page, and pages around current
                        if (pageNum == 1 ||
                            pageNum == totalPages ||
                            (pageNum >= _currentPage - 1 &&
                                pageNum <= _currentPage + 1)) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: pageNum == _currentPage
                                ? Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4d2963),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$pageNum',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        _currentPage = pageNum;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey[300]!),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$pageNum',
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          );
                        } else if (pageNum == _currentPage - 2 ||
                            pageNum == _currentPage + 2) {
                          // Show ellipsis
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Text('...'),
                          );
                        }
                        return const SizedBox.shrink();
                      }),

                      const SizedBox(width: 16),
                      // Next button
                      IconButton(
                        onPressed: _currentPage < totalPages
                            ? () {
                                setState(() {
                                  _currentPage++;
                                });
                              }
                            : null,
                        icon: const Icon(Icons.chevron_right),
                        tooltip: 'Next page',
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}
