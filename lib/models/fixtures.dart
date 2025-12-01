import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/collection.dart';

// Small set of product fixtures used across the app. Keep items simple; tests
// or exercises can extend this list as needed.
const List<Product> products = [
  Product(
    id: 'product-a',
    title: 'Product A',
    price: '£10.00',
    imageUrl: 'assets/product1.png',
  ),
  Product(
    id: 'product-b',
    title: 'Product B',
    price: '£12.50',
    imageUrl: 'assets/product2.png',
  ),
  Product(
    id: 'product-c',
    title: 'Product C',
    price: '£15.00',
    imageUrl: 'assets/product3.png',
  ),
  Product(
    id: 'product-d',
    title: 'Product D',
    price: '£20.00',
    imageUrl: 'assets/product4.png',
  ),
  Product(
    id: 'product-e',
    title: 'Product E',
    price: '£8.50',
    imageUrl: 'assets/product5.png',
  ),
  Product(
    id: 'product-f',
    title: 'Product F',
    price: '£30.00',
    imageUrl: 'assets/product6.png',
  ),
];

// Example collections mapping to subsets of `products` above.
final List<Collection> collections = [
  Collection(
    id: 'clothing',
    title: 'Clothing',
    imageUrl: 'assets/collection_clothing.png',
    products: [products[0], products[1], products[2]],
  ),
  Collection(
    id: 'signature',
    title: 'Signature Range',
    imageUrl: 'assets/logo.png', // Fallback to existing asset
    products: [products[2], products[3]],
  ),
  Collection(
    id: 'merch',
    title: 'Merchandise',
    imageUrl: 'assets/product3.png', // Fallback to existing asset
    products: [products[0], products[3], products[4]],
  ),
  Collection(
    id: 'graduation',
    title: 'Graduation',
    imageUrl: 'assets/product4.png', // Fallback to existing asset
    products: [products[4], products[5]],
  ),
  Collection(
    id: 'essentials',
    title: 'Student Essentials',
    imageUrl: 'assets/product1.png', // Fallback to existing asset
    products: [products[0], products[1]],
  ),
  Collection(
    id: 'sale',
    title: 'Featured Items',
    imageUrl: 'assets/product2.png', // Fallback to existing asset
    products: [products[1], products[5]],
  ),
];

// Sale fixtures: reference existing products and include numeric price and discount
final List<Map<String, dynamic>> saleItems = [
  {
    'product': products[1], // Product B
    'price': 12.50,
    'discountPercent': 20,
  },
  {
    'product': products[5], // Product F
    'price': 30.00,
    'discountPercent': 25,
  },
  {
    'product': products[2], // Product C
    'price': 15.00,
    'discountPercent': 10,
  },
];

// Helper lookups for routing and deep links
Product? productById(String id) {
  for (final p in products) {
    if (p.id == id) return p;
  }
  return null;
}

Collection? collectionById(String id) {
  for (final c in collections) {
    if (c.id == id) return c;
  }
  return null;
}
