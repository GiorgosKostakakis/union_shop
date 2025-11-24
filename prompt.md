Create a "Sale" page and wire it into the app with a promo banner and sale product list. Follow these explicit steps, implement each subtask only in the listed files, run quick sanity checks, and stop after each subtask to explain what you changed and ask me to commit.

High-level description
- Add a new `SalePage` that shows a full-width promotional banner on top and a list of sale products below. Sale products should display original price, discounted price, and a visible sale badge.
- Keep all changes isolated and minimal: prefer `lib/sale_page.dart`, update `lib/models/fixtures.dart` (or add a sale fixtures file), and add a route in `lib/main.dart`. Add a single focused widget test `test/sale_page_test.dart`.
- After finishing each listed subtask, stop, explain the change, and ask me to commit before continuing.

Files to create/update
- Create: `lib/sale_page.dart` (page + widgets)
- Update: `lib/models/fixtures.dart` (add sample sale items with discount field) — if file not present, create it in the same pattern used by the project.
- Update: `lib/main.dart` to add a named route `/sale` that points to `SalePage()`.
- Create test: `test/sale_page_test.dart` (one widget test verifying banner and at least one sale product with badge and discounted price).
- Do not modify other files unless strictly necessary; if you need to, ask me first.

Contract (inputs / outputs)
- Input: No runtime API calls. Use app fixtures only.
- Output: A new page reachable at the named route `/sale` that visually shows:
  - Promotional banner at top (image or colored Container with text).
  - A vertical list/grid of sale products.
  - Each sale item shows:
    - Product title
    - Original price (struck or greyed)
    - Discounted price (prominent)
    - A badge with 'SALE' or '% off' (Key: `saleBadge:<product-id>` or `saleBadge` for test)
- Keys for testability:
  - Banner: Key('saleBanner')
  - Product tile: Key('saleProductTile_<index>') or Key('saleProductTile')
  - Sale badge: Key('saleBadge_<index>') or Key('saleBadge')
  - Discount price text: Key('discountPrice_<index>') or Key('discountPrice')
- Error modes: loading should use local assets or colored fallback; do not call network.

Constraints & style
- Do not add new packages.
- Use existing project theme/colors where reasonable (use Color(0xFF4d2963) for CTAs).
- Keep the UI accessible: readable font sizes and tappable area for tiles.
- Preserve existing models (add a `discount` or `isOnSale` field if needed in fixtures only).

Subtasks (execute sequentially; stop after each and ask to commit)
1) Add `SalePage` scaffold + banner
- Prompt: "Create `SalePage` with promotional banner and a list of sale products (discounted prices)."
- Implementation notes:
  - Create `lib/sale_page.dart` with a StatefulWidget / StatelessWidget that:
    - Renders a top banner (Key('saleBanner')) — use `Container` with background image from assets if available, else colored Container with centered promo Text.
    - Renders a list (ListView or GridView) for sale products (placeholder if fixtures not yet added).
  - Add minimal styling and a top-level `Header` if the app uses it (follow project conventions).
- Acceptance: Page displays a banner and an empty list or placeholder list.
- Files changed: `lib/sale_page.dart`
- Commit message: Add SalePage scaffold and banner
- After completing: stop, describe changes, and ask me to commit.

2) Add sample sale product fixtures with discount field
- Prompt: "Add sale fixtures with a `discount` field and sample discounted items."
- Implementation notes:
  - Update `lib/models/fixtures.dart` (or create) to include a sample product list with fields: title, price (string), imageUrl, and discount (double or percent). Example:
    { title: 'Hoodie', price: '£25.00', imageUrl: 'assets/hoodie.png', discountPercent: 30 }
  - Provide at least 3 sale items.
- Acceptance: fixtures contain sale items with discount info usable by `SalePage`.
- Files changed: `lib/models/fixtures.dart`
- Commit message: Add sale fixtures and sample discounted items
- After completing: stop, describe changes, and ask me to commit.

3) Render sale product list and discount badge UI
- Prompt: "Render sale product tiles showing original price, discounted price and a SALE badge."
- Implementation notes:
  - In `lib/sale_page.dart` use the fixtures to render tiles.
  - For each product:
    - Compute discounted price from original price string or parse numeric price in fixtures (prefer numeric price field).
    - Show original price as muted/strikethrough (TextStyle with decoration: TextDecoration.lineThrough or grey).
    - Show discounted price prominently (Key('discountPrice_<index>')).
    - Add a small corner/top-left badge with 'SALE' or '-30%' and Key('saleBadge_<index>').
    - Give each tile a Key('saleProductTile_<index>') for testing.
  - Make tiles tappable (no navigation required) and responsive (Grid on wide screens, List on narrow).
- Acceptance: On `/sale` page each sale product shows the badge and discounted price.
- Files changed: `lib/sale_page.dart` (update to use fixtures)
If you want, I can now implement subtask 1 immediately (create `SalePage` scaffold with banner) — say "implement subtask 1" and I'll proceed.


## Deep routing prompt (copy this to ask the assistant to implement deep links)

Implement deep routing for the Union Shop Flutter app (web & mobile): use declarative URL routes so pages can be opened directly by URL and route params are available to pages.

Files to edit:
- `lib/main.dart` (primary router setup)
- `lib/product_page.dart`, `lib/collection_page.dart`, `lib/sale_page.dart` (accept ids/lookup fixtures)
- `lib/models/fixtures.dart` (ensure stable `id` fields)
- tests under `test/` (add routing tests)

Change summary:
1. Add a routing solution (recommended: `go_router`) and wire routes for:
  - `/` -> Home/CollectionsPage
  - `/collections` -> CollectionsPage
  - `/collections/:collectionId` -> CollectionPage
  - `/collections/:collectionId/products/:productId` -> ProductPage
  - `/product/:productId` -> ProductPage
  - `/sale` -> SalePage
  - `/sale/products/:productId` -> ProductPage (from sale)
2. Make `ProductPage` and `CollectionPage` accept either a model object (via navigation extra) or an `id` param and lookup from `fixtures.dart` when necessary.
3. Ensure `fixtures.dart` products/collections have stable `id` fields (string or int) and update models if required.
4. Keep existing widget keys and behavior. Ensure URLs update in browser when navigating inside the app.

Acceptance criteria:
- Visiting `/product/<productId>` builds `ProductPage` showing the product title and price from fixtures.
- Visiting `/collections/<collectionId>/products/<productId>` loads the product in context of the collection.
- Visiting `/sale/products/<productId>` loads the product from sale fixtures.
- `ProductPage` works when navigated via widget push with a `Product` object and when opened directly by URL (lookup by id).
- Add widget tests for the above deep links.

Implementation notes & constraints:
- Preferred: use `go_router` for clean paths and web support. If using `go_router`, add it to `pubspec.yaml` and pin a stable version.
- Alternative (no dependency): implement `onGenerateRoute` Uri parsing in `lib/main.dart`.
- Do not change UI significantly. Keep edits minimal and focused on routing.
- Do not add network calls. Use `lib/models/fixtures.dart` for lookups.

Suggested commit messages:
- feat(routing): add deep routing using go_router
- chore(models): add id fields to product/collection fixtures
- test(routing): add widget tests for deep links

If you want me to implement this now, reply with either:
- "implement with go_router" — I'll add the dependency, implement routes, update pages to accept ids, add tests, and run `flutter analyze` and `flutter test`.
- "implement with onGenerateRoute" — I'll implement a dependency-free Uri-parsing router in `lib/main.dart` and do the same tests.

