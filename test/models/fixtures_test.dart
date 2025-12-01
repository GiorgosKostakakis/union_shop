import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/fixtures.dart';

void main() {
  group('Fixtures Model Tests', () {
    test('productById returns correct product when id exists', () {
      final product = productById('product-a');
      expect(product, isNotNull);
      expect(product!.id, equals('product-a'));
      expect(product.title, equals('Product A'));
    });

    test('productById returns null for non-existent id', () {
      final product = productById('invalid-id');
      expect(product, isNull);
    });

    test('collectionById returns correct collection when id exists', () {
      final collection = collectionById('clothing');
      expect(collection, isNotNull);
      expect(collection!.id, equals('clothing'));
      expect(collection.title, equals('Clothing'));
    });

    test('collectionById returns null for non-existent id', () {
      final collection = collectionById('invalid-id');
      expect(collection, isNull);
    });

    test('saleItems contains expected data', () {
      expect(saleItems, hasLength(3));
      expect(saleItems[0]['product'].id, equals('product-b'));
      expect(saleItems[0]['price'], equals(12.50));
      expect(saleItems[0]['discountPercent'], equals(20));
    });

    test('products list contains all products', () {
      expect(products, hasLength(6));
      expect(products[0].id, equals('product-a'));
      expect(products[0].title, equals('Product A'));
    });

    test('collections list contains all collections', () {
      expect(collections, hasLength(6));
      expect(collections[0].id, equals('clothing'));
      expect(collections[0].title, equals('Clothing'));
    });
  });
}
