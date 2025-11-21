Task: Add product options UI (color / size / quantity) to ProductPage and wire them to local state.

Files to edit:
- lib/product_page.dart

Change summary (small numbered steps):
1. Convert `ProductPage` to a StatefulWidget (keep the existing optional `Product? product` param and the `displayProduct` fallback).
2. Add local state fields:
   - String selectedSize (default 'M')
   - String selectedColor (default first option, e.g., 'Black')
   - int quantity (default 1, min 1)
3. Add UI controls (non-network, display-only) near the existing options area:
   - Size: DropdownButton<String> with items ['S','M','L']
   - Color: DropdownButton<String> with items ['Black','White','Blue'] (shows the selection; you may render a small color swatch next to the label)
   - Quantity: horizontal row with a decrement IconButton (-), a Text showing quantity, and an increment IconButton (+). Clamp quantity ≥ 1.
4. Ensure selecting size/color or tapping +/- updates the local state and the UI immediately.
5. Expose the selected options visibly near the Add to cart / Buy now buttons (e.g., small Text lines: "Size: M  •  Color: Black  •  Qty: 1").
6. Add Keys for testability:
   - Key('sizeDropdown'), Key('colorDropdown'), Key('qtyText'), Key('qtyIncrement'), Key('qtyDecrement').
7. Keep the rest of the page as-is: header/footer, image loading from assets, placeholder product fallback, errorBuilders, and CTA buttons. Do not wire to a cart provider — keep local state only.
8. Keep edits minimal, preserve existing formatting and code structure as much as possible.

Constraints
- Do not add new packages.
- Do not change public APIs beyond converting `ProductPage` to a StatefulWidget and keeping the same constructor signature.
- Keep all existing tests working; if you must update tests because of stateful widget class name changes, do so minimally.
- Use `Image.asset` for images (no network fetch).
- Make the UI mobile-friendly (simple vertical stacking on narrow screens).

Acceptance criteria (how I should verify the change)
- The app compiles (no analyzer/compile errors).
- On `ProductPage`:
  - There are two dropdowns (size and color) and a quantity selector.
  - Changing size updates the size shown in the UI.
  - Changing color updates the color shown in the UI.
  - Tapping + increments the quantity; tapping - decrements it but never drops below 1.
  - The Keys above exist and can be used in widget tests to find the controls.
- Run widget tests (existing suite). All tests pass. Optionally add one focused widget test that:
  - Instantiates `ProductPage` with a Product fixture.
  - Finds and taps the size dropdown and selects another size.
  - Taps the qty increment and verifies the qty text updates.
  - Asserts the visible summary text reflects the chosen size/color/qty.

Suggested test additions (optional, I can add them for you):
- test/product_options_test.dart
  - Test: 'product options update local state'
  - Steps: pump ProductPage(product: fixtures.products.first), tap size dropdown and choose 'L', press qty increment, assert Key('qtyText') shows '2', and assert summary text contains 'Size: L'.

Suggested commit message
- feat(product): add size/color/quantity UI and local state to ProductPage

Deliverables
- A minimal patch that edits only `lib/product_page.dart` (and a test file if you ask me to add the optional test).
- Verification: run `flutter test` and show results.

If that looks good, reply "Go implement" and I will apply the patch, run tests, and report back with what I changed and test output.