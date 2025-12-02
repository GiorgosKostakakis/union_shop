class Product {
  final String id;
  final String title;
  final String price;
  final String imageUrl;
  final String description;
  final List<String>? availableSizes;
  final List<String>? availableColors;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.description = '',
    this.availableSizes,
    this.availableColors,
  });
}
