Task: Center product image and product options/filter area on `ProductPage` to match the layout of
https://shop.upsu.net/collections/essential-range/products/limited-addition-essential-zip-hoodies

Files to edit:
- lib/product_page.dart
(only this file unless you tell me to refactor shared components)

Change summary (small numbered steps):
1. Wrap the existing product content in a centered max-width container:
   - Add a top-level centered container (e.g., Center -> ConstrainedBox or Align + SizedBox) with a sensible maxWidth (e.g., 1000 or 900 px).
   - This container becomes the main product layout area so the page content is visually centered regardless of screen width.

2. Use a responsive two-column layout inside the centered container:
   - On wide screens (width >= 800), display a Row with:
     - Left: product image area (flex 1 / fixed width around 420-480px)
     - Right: details/filters/CTAs area (flex 1)
   - On narrow screens (width < 800), fall back to a single-column layout where image sits above details.
   - Ensure both columns are vertically aligned at the top.

3. Center image and controls inside their column:
   - Image column: center the image horizontally inside its column, keep existing ClipRRect + Image.asset logic.
   - Details column: keep title/price/description and place the options/filter UI (size, color, qty) directly under the product title/price and aligned to the left of the column, but ensure the overall two-column block is centered on the page by the outer max-width container.

4. Maintain responsive spacing:
   - Use consistent padding inside the centered container (re-use existing padding 24).
   - Use SizedBox or SizedBox.expand with constraints to create the same visual spacing as the reference.
   - Keep mobile stacking with centered image and full-width details.

5. Keep behavior and keys:
   - Preserve all existing Keys and stateful controls (sizeDropdown, colorDropdown, qtyText, qtyIncrement, qtyDecrement).
   - Preserve image asset loading and errorBuilder.
   - Do not wire to cart provider; local state only.


Constraints
- Do not add new packages.
- Keep changes minimal and self-contained to `lib/product_page.dart`.
- Preserve existing widget keys, state, and testable behavior.
- Respect current color, typography, header/footer and CTA styles as much as possible.
- Make the layout responsive (desktop two-column; mobile stacked).

Acceptance criteria (how I should verify the change)
- The product content is visually centered on the page by a max-width container on wide screens.
- On wide viewports (>= 800px) the page shows two columns: image on the left, details/options on the right.
- On narrow viewports (< 800px) the content stacks vertically (image above details), and is horizontally centered.
- The size/color dropdowns and quantity controls remain functional and keep their Keys.
- The app compiles without analyzer errors.
- All existing widget tests pass (run `flutter test`). If tests need small updates, change them only as required to reflect the new layout.

Suggested commit message
- feat(product): center product content and use responsive two-column layout on ProductPage

Deliverables
- Edited `lib/product_page.dart` implementing the centered, responsive layout.
- (Optional) Small test update if required to keep tests green.
- Test run output showing green tests.

If that looks good reply "Go implement" and I will apply the patch, run the tests, and report back with the changes and test output.