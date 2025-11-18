import 'package:union_shop/models/product.dart';

class Collection {
  final String title;
  final String imageUrl;
  final List<Product> products;

  const Collection({
    required this.title,
    required this.imageUrl,
    required this.products,
  });
}
