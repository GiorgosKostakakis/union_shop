import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/collection.dart';

// Small set of product fixtures used across the app. Keep items simple; tests
// or exercises can extend this list as needed.
const List<Product> products = [
  Product(
    id: 'product-a',
    title: 'University Hoodie',
    price: '£10.00',
    imageUrl: 'assets/hoodie.png',
    description: 'Cozy and warm university branded hoodie, perfect for campus life and chilly days.',
  ),
  Product(
    id: 'product-b',
    title: 'Varsity T-Shirt',
    price: '£12.50',
    imageUrl: 'assets/tshirt.png',
    description: 'Classic varsity style t-shirt with university logo. Comfortable cotton blend.',
  ),
  Product(
    id: 'product-c',
    title: 'Campus Sweatshirt',
    price: '£15.00',
    imageUrl: 'assets/sweatshirt.png',
    description: 'Comfortable campus sweatshirt featuring university branding. Great for everyday wear.',
  ),
  Product(
    id: 'product-d',
    title: 'College Cap',
    price: '£20.00',
    imageUrl: 'assets/cap.png',
    description: 'Stylish college cap with embroidered university logo. Adjustable fit.',
  ),
  Product(
    id: 'product-e',
    title: 'Student Backpack',
    price: '£8.50',
    imageUrl: 'assets/backpack.png',
    description: 'Durable student backpack with multiple compartments for books and laptop.',
  ),
  Product(
    id: 'product-f',
    title: 'University Jacket',
    price: '£30.00',
    imageUrl: 'assets/jacket.png',
    description: 'Premium university jacket with full zip and side pockets. Water-resistant material.',
  ),
  Product(
    id: 'product-g',
    title: 'Sports Polo Shirt',
    price: '£18.00',
    imageUrl: 'assets/polo.png',
    description: 'Athletic polo shirt perfect for sports and casual wear. Breathable fabric.',
  ),
  Product(
    id: 'product-h',
    title: 'Zip-Up Hoodie',
    price: '£35.00',
    imageUrl: 'assets/zip_hoodie.png',
    description: 'Premium zip-up hoodie with university branding. Full front zipper and hood.',
  ),
  Product(
    id: 'product-i',
    title: 'Track Pants',
    price: '£25.00',
    imageUrl: 'assets/pants.png',
    description: 'Comfortable track pants with university logo. Perfect for gym or leisure.',
  ),
  Product(
    id: 'product-j',
    title: 'University Scarf',
    price: '£12.00',
    imageUrl: 'assets/scarf.png',
    description: 'Warm knitted scarf in university colors. Perfect accessory for cold weather.',
  ),
  Product(
    id: 'product-k',
    title: 'Water Bottle',
    price: '£8.00',
    imageUrl: 'assets/water_bottle.png',
    description: 'Reusable water bottle with university logo. BPA-free, 500ml capacity.',
  ),
  Product(
    id: 'product-l',
    title: 'University Mug',
    price: '£6.50',
    imageUrl: 'assets/mug.png',
    description: 'Ceramic mug featuring university branding. Dishwasher and microwave safe.',
  ),
  Product(
    id: 'product-m',
    title: 'Laptop Sleeve',
    price: '£15.00',
    imageUrl: 'assets/laptop_sleeve.png',
    description: 'Protective laptop sleeve with university logo. Fits up to 15-inch laptops.',
  ),
  Product(
    id: 'product-n',
    title: 'Graduation Gown',
    price: '£45.00',
    imageUrl: 'assets/jacket.png',
    description: 'Traditional graduation gown for ceremony day. High-quality material.',
  ),
  Product(
    id: 'product-o',
    title: 'Graduation Cap',
    price: '£15.00',
    imageUrl: 'assets/cap.png',
    description: 'Classic graduation cap (mortarboard) with tassel. Complete your ceremony attire.',
  ),
  Product(
    id: 'product-p',
    title: 'University Pen Set',
    price: '£5.00',
    imageUrl: 'assets/logo.png',
    description: 'Set of three ballpoint pens with university branding. Smooth writing.',
  ),
  Product(
    id: 'product-q',
    title: 'Notebook Bundle',
    price: '£10.00',
    imageUrl: 'assets/logo.png',
    description: 'Bundle of three A5 notebooks with university logo. Ruled pages, perfect for notes.',
  ),
  Product(
    id: 'product-r',
    title: 'Sports Shorts',
    price: '£16.00',
    imageUrl: 'assets/pants.png',
    description: 'Comfortable sports shorts with university branding. Lightweight and breathable.',
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
    imageUrl: 'assets/hoodie.png',
    products: [products[2], products[3], products[5], products[7]],
  ),
  Collection(
    id: 'merch',
    title: 'Merchandise',
    imageUrl: 'assets/mug.png',
    products: [products[10], products[11], products[15], products[16]],
  ),
  Collection(
    id: 'graduation',
    title: 'Graduation',
    imageUrl: 'assets/jacket.png',
    products: [products[13], products[14]],
  ),
  Collection(
    id: 'essentials',
    title: 'Student Essentials',
    imageUrl: 'assets/backpack.png',
    products: [products[4], products[12], products[15], products[16]],
  ),
  Collection(
    id: 'sale',
    title: 'Featured Items',
    imageUrl: 'assets/tshirt.png',
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
