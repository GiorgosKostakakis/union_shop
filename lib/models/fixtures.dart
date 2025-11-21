import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/collection.dart';

// Small set of product fixtures used across the app. Keep items simple; tests
// or exercises can extend this list as needed.
const List<Product> products = [
  Product(
    title: 'Product A',
    price: '£10.00',
    imageUrl: 'assets/product1.png',
  ),
  Product(
    title: 'Product B',
    price: '£12.50',
    imageUrl: 'assets/product2.png',
  ),
  Product(
    title: 'Product C',
    price: '£15.00',
    imageUrl: 'assets/product3.png',
  ),
  Product(
    title: 'Product D',
    price: '£20.00',
    imageUrl: 'assets/product4.png',
  ),
  Product(
    title: 'Product E',
    price: '£8.50',
    imageUrl: 'assets/product5.png',
  ),
  Product(
    title: 'Product F',
    price: '£30.00',
    imageUrl: 'assets/product6.png',
  ),
];

// Example collections mapping to subsets of `products` above.
final List<Collection> collections = [
  Collection(
    title: 'Clothing',
    imageUrl: 'assets/collection_clothing.png',
    products: [products[0], products[1], products[2]],
  ),
  Collection(
    title: 'Signature Range',
    imageUrl: 'assets/collection_signature.png',
    products: [products[2], products[3]],
  ),
  Collection(
    title: 'Merchandise',
    imageUrl: 'assets/collection_merchandise.png',
    products: [products[0], products[3], products[4]],
  ),
  Collection(
    title: 'Graduation',
    imageUrl: 'assets/collection_graduation.png',
    products: [products[4], products[5]],
  ),
  Collection(
    title: 'Student Essentials',
    imageUrl: 'assets/collection_essentials.png',
    products: [products[0], products[1]],
  ),
  Collection(
    title: 'SALE',
    imageUrl: 'assets/collection_sale.png',
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
