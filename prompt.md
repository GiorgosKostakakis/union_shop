You are an expert Flutter/Dart developer. I have a Flutter app (repo root) with a `ProductPage` that currently loads a product image from a network URL. I want the Product page to be "static" (hardcoded product details are acceptable) and to load images from local assets (Image.asset) rather than Image.network.

Context:
- File to edit: lib/product_page.dart
- Current `ProductPage` accepts an optional Product and uses Image.network for the product image.
- There are fixtures in lib/models/fixtures.dart with product entries whose `imageUrl` values point to local assets (e.g. "assets/product1.png").
- Routes are defined in lib/main.dart with '/product' already wired to ProductPage.
- Tests exist under test/ (product_test.dart, header_test.dart, etc.) — keep test behavior intact.

Goals (make minimal, safe changes):
1. Make `ProductPage` static-friendly:
   - If a Product argument is passed, use it; otherwise fall back to a static/hardcoded product defined inside the page.
   - It’s acceptable to hardcode title, price, and a local asset path if no argument is supplied.

2. Replace network images with asset images:
   - Replace any Image.network usage for the product image with Image.asset when the image path refers to a local asset.
   - If the image path points to a network URL, it is okay to use a fallback asset image instead of loading from network.

3. Keep the page UI: title, price, description, size dropdown (UI-only), qty display, Add to cart and Buy now buttons should remain. These widgets do not need to be functional.

4. Keep all existing header/footer usage intact.

5. Make changes minimal and compile-ready. Do not introduce new package dependencies.

Concrete implementation notes (copy/paste friendly):
- In `lib/product_page.dart`:
  - Ensure the class has an optional `Product? product` field. On build, compute:
      final Product displayProduct = product ?? Product(title: 'Placeholder Product', price: '£12.00', imageUrl: 'assets/product1.png');
  - For the product image use:
      Widget productImage;
      if (displayProduct.imageUrl.startsWith('assets/')) {
        productImage = Image.asset(displayProduct.imageUrl, fit: BoxFit.cover, errorBuilder: ...);
      } else {
        // fallback: use a local asset instead of network
        productImage = Image.asset('assets/product1.png', fit: BoxFit.cover, errorBuilder: ...);
      }
  - Replace the Image.network(...) with productImage.

- Keep the layout unchanged: header, product detail column, dropdown, CTA buttons, footer. Keep errorBuilder for images.

Tests & verification:
- After edits, run:
    flutter test
  Expect existing widget tests (product_test.dart, header_test.dart, collection_to_product_test.dart) to still pass.
- Manual check: run the app and navigate from a collection to a product. The image should load from the local asset (no network call).

Edge cases and constraints:
- If any product image path is a remote URL, do not attempt to fetch it; use the local fallback asset instead.
- Avoid adding network permissions or new packages.
- Keep changes small and reversible; prefer a single small commit.

Suggested commit message:
- feat(product): make ProductPage static-friendly and use local asset images

Deliverable:
- A single-file patch for `lib/product_page.dart` implementing the above.