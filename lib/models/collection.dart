import 'package:union_shop/models/product.dart';

class Collection {
  final String id;
  final String title;
  final String imageUrl;
  final List<Product> products;

  const Collection({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.products,
  });
}
