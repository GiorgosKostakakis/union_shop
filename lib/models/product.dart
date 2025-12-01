class Product {
  final String id;
  final String title;
  final String price;
  final String imageUrl;
  final String description;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.description = '',
  });
}
