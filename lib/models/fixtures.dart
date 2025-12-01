import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/collection.dart';

// Small set of product fixtures used across the app. Keep items simple; tests
// or exercises can extend this list as needed.
const List<Product> products = [
  Product(
    id: 'product-a',
    title: 'University Hoodie',
    price: '£10.00',
    imageUrl: 'assets/product1.png',
  ),
  Product(
    id: 'product-b',
    title: 'Varsity T-Shirt',
    price: '£12.50',
    imageUrl: 'assets/product2.png',
  ),
  Product(
    id: 'product-c',
    title: 'Campus Sweatshirt',
    price: '£15.00',
    imageUrl: 'assets/product3.png',
  ),
  Product(
    id: 'product-d',
    title: 'College Cap',
    price: '£20.00',
    imageUrl: 'assets/product4.png',
  ),
  Product(
    id: 'product-e',
    title: 'Student Backpack',
    price: '£8.50',
    imageUrl: 'assets/product5.png',
  ),
  Product(
    id: 'product-f',
    title: 'University Jacket',
    price: '£30.00',
    imageUrl: 'assets/product6.png',
  ),
  Product(
    id: 'product-g',
    title: 'Sports Polo Shirt',
    price: '£18.00',
    imageUrl: 'assets/product1.png',
  ),
  Product(
    id: 'product-h',
    title: 'Zip-Up Hoodie',
    price: '£35.00',
    imageUrl: 'assets/product2.png',
  ),
  Product(
    id: 'product-i',
    title: 'Track Pants',
    price: '£25.00',
    imageUrl: 'assets/product3.png',
  ),
  Product(
    id: 'product-j',
    title: 'University Scarf',
    price: '£12.00',
    imageUrl: 'assets/product4.png',
  ),
  Product(
    id: 'product-k',
    title: 'Water Bottle',
    price: '£8.00',
    imageUrl: 'assets/product5.png',
  ),
  Product(
    id: 'product-l',
    title: 'University Mug',
    price: '£6.50',
    imageUrl: 'assets/product6.png',
  ),
  Product(
    id: 'product-m',
    title: 'Laptop Sleeve',
    price: '£15.00',
    imageUrl: 'assets/product1.png',
  ),
  Product(
    id: 'product-n',
    title: 'Graduation Gown',
    price: '£45.00',
    imageUrl: 'assets/product2.png',
  ),
  Product(
    id: 'product-o',
    title: 'Graduation Cap',
    price: '£15.00',
    imageUrl: 'assets/product3.png',
  ),
  Product(
    id: 'product-p',
    title: 'University Pen Set',
    price: '£5.00',
    imageUrl: 'assets/product4.png',
  ),
  Product(
    id: 'product-q',
    title: 'Notebook Bundle',
    price: '£10.00',
    imageUrl: 'assets/product5.png',
  ),
  Product(
    id: 'product-r',
    title: 'Sports Shorts',
    price: '£16.00',
    imageUrl: 'assets/product6.png',
  ),
];

// Example collections mapping to subsets of `products` above.
final List<Collection> collections = [
  Collection(
    id: 'clothing',
    title: 'Clothing',
    imageUrl: 'assets/collection_clothing.png',
    products: [products[0], products[1], products[2], products[5], products[6], products[7], products[8], products[17]],
  ),
  Collection(
    id: 'signature',
    title: 'Signature Range',
    imageUrl: 'assets/logo.png', // Fallback to existing asset
    products: [products[2], products[3], products[5], products[7]],
  ),
  Collection(
    id: 'merch',
    title: 'Merchandise',
    imageUrl: 'assets/product3.png', // Fallback to existing asset
    products: [products[10], products[11], products[15], products[16]],
  ),
  Collection(
    id: 'graduation',
    title: 'Graduation',
    imageUrl: 'assets/product4.png', // Fallback to existing asset
    products: [products[13], products[14]],
  ),
  Collection(
    id: 'essentials',
    title: 'Student Essentials',
    imageUrl: 'assets/product1.png', // Fallback to existing asset
    products: [products[4], products[12], products[15], products[16]],
  ),
  Collection(
    id: 'sale',
    title: 'Featured Items',
    imageUrl: 'assets/product2.png', // Fallback to existing asset
    products: [products[1], products[5], products[2], products[7]],
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
