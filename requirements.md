# Project requirements and checklist

This file contains a structured feature checklist and step-by-step implementation instructions for the Union Shop Flutter app. Each feature is broken down into smaller subtasks with LLM-friendly prompts, acceptance criteria, and a commit message template.

---

## How to read this file
- Each feature is listed under Basic, Intermediate, or Advanced.
- For each feature you'll find:
  - A short description
  - Concrete sub-steps
  - A single LLM prompt to implement the step
  - Acceptance criteria (what "done" looks like)
  - A default commit message for the change

---

## Basic (40%)

### Static Homepage (5%) [x]
- Description: Mobile-first homepage layout, hardcoded product examples allowed.
- Steps & prompts:
  1. Create hero section and top navigation
     - Prompt: "Create a header section with a purple top bar, logo and navigation buttons. Add a hero with background image and a 'BROWSE PRODUCTS' button. Use placeholder text and assets." 
     - Acceptance: header shows in the app; hero title and button visible
     - Commit: `Add static homepage with hero and header`
  2. Implement products grid using `ProductCard` hardcoded examples
     - Prompt: "Add `GridView` or responsive layout with 4 ProductCard widgets (title, price, placeholder image).`"
     - Acceptance: grid displays 4 product cards with titles and prices
     - Commit: `Add products grid to homepage`

### About Us Page (5%) [x]
- Description: Simple about us screen with content and contact info.
- Steps & prompts:
  1. Create `AboutPage` route
     - Prompt: "Create a new `AboutPage` showing a hero banner and 'About Us' content paragraphs with contact details."
     - Acceptance: `About` route reachable; About content shown
     - Commit: `Add AboutPage with static content`

### Footer (4%) [x]
- Description: Footer with 'Opening Hours', 'Help & Info' and 'Latest Offers'. 
- Steps & prompts:
  1. Create `Footer` widget
     - Prompt: "Create `Footer` widget with Open Hours, simple links and Latest Offers; background grey; three columns." 
     - Acceptance: Footer visible and reusable across pages
     - Commit: `Add reusable Footer widget`

### Collections page (5%) [x]
- Description: Page showing product categories. Static cards allowed.
- Steps & prompts:
  1. Create `CollectionsPage` route and add to nav
     - Prompt: "Create `CollectionsPage` with heading 'Collections' and 6 sample collection cards."
     - Acceptance: `Collections` route accessible via nav button
     - Commit: `Add CollectionsPage with sample collections`

### Collection Example Page (5%)
- Description: Page for a single collection; filtering widgets may be non-functional.
- Steps & prompts:
  1. Create `CollectionPage` template
     - Prompt: "Create `CollectionPage` that lists products in a selected collection; include dropdowns/filters as form widgets (non-functional)."
     - Acceptance: Collection page shows product cards and filter UI
     - Commit: `Add Collection detail page template`

### Product Page (4%) [x]
- Description: Product detail page showing images and details; widgets may be non-functional.
- Steps & prompts:
  1. Create `ProductPage` with placeholders
     - Prompt: "Create `ProductPage` with big image, product title, price, description and quantity dropdown; placeholders ok." 
     - Acceptance: Product page displays placeholders properly
     - Commit: `Create ProductPage with placeholder data`

### Sale Collection (4%)
- Description: Page with sale products and promotional banner.
- Steps & prompts:
  1. Create `SalePage`
     - Prompt: "Create `SalePage` with promotional banner and a list of sale products (discounted prices)." 
     - Acceptance: Sale page displays products and a banner
     - Commit: `Add SalePage with discounted sample products`

### Authentication UI (3%)
- Description: Login/Signup screens; not connected to a backend (UI only).
- Steps & prompts:
  1. Add `Auth` pages
     - Prompt: "Create `LoginPage` and `RegisterPage` with forms for email/password and basic validation (UI-only)."
     - Acceptance: Forms present, validation errors are visible when invalid input provided
     - Commit: `Add Login and Register template pages`

### Static Navbar (5%) [x]
- Description: Top navigation for desktop; collapsible on mobile.
- Steps & prompts:
  1. Implement responsive navbar
     - Prompt: "Create a responsive navbar with logo, category links and icons; collapse into a menu button on small widths." 
     - Acceptance: Navbar collapses at small widths
     - Commit: `Add responsive navbar template`

---

## Intermediate (35%)

### Dynamic Collections (6%)
- Description: Collections loaded from a model or service; sorting and filtering UI works.
- Steps & prompts:
  1. Create `Collection` and `Product` models and fixtures
     - Prompt: "Create data models for collections and products and a `fixtures.dart` file that exports lists for initial data." 
     - Acceptance: Collections load from fixtures
     - Commit: `Add Collection and Product models with fixtures`
  2. Wire collections to `CollectionsPage` (dynamic)
     - Prompt: "Change `CollectionsPage` to load items from `fixtures.collections` and render them." 
     - Acceptance: Collections display from model data
     - Commit: `Load collections dynamically from fixtures`

### Collection Page dynamic listings (6%)
- Steps & prompts:
  1. Populate `CollectionPage` from model
     - Prompt: "Update `CollectionPage` to use Product model and show product cards with data from selected collection." 
     - Acceptance: Products for the chosen collection appear
     - Commit: `Populate CollectionPage dynamically`
  2. Add filtering/sorting behavior (UI or working)
     - Prompt: "Add sorting dropdown and simple filtering; implement filter to show only items with a matching property." 
     - Acceptance: Filter UI works on the displayed list
     - Commit: `Add sorting/filtering in CollectionPage`

### Product pages with real data (6%)
- Steps & prompts:
  1. Modify `ProductPage` to receive a `Product` object
     - Prompt: "Update `ProductPage` to accept a `Product` parameter and display its title, price, and image." 
     - Acceptance: Clicking a product navigates to product page with correct data
     - Commit: `Pass Product to ProductPage and display details`
  2. Add countdowns and color/size dropdowns (UI)
     - Prompt: "Add optional size/color dropdowns and quantity selector; maintain local state only." 
     - Acceptance: Dropdowns update local state
     - Commit: `Add product options UI`

### Shopping Cart basic (6%)
- Steps & prompts:
  1. Create Cart data model and in-memory provider
     - Prompt: "Create a `Cart` provider with items, add/remove functions, and total calculation." 
     - Acceptance: Cart can add/remove items in-memory
     - Commit: `Add basic Cart provider and model`
  2. Create `CartPage` and wire to add-to-cart button
     - Prompt: "Add `CartPage` showing list of cart items with quantity and remove actions. Connect product page 'Add to Cart' to this provider." 
     - Acceptance: Items show up in cart after add-to-cart operations
     - Commit: `Add CartPage and wire Add to Cart`

### Print Shack (Personalisation) (3%)
- Steps & prompts:
  1. Create `Personalisation` page with text inputs
     - Prompt: "Create a personalisation form with text input and dropdowns for font and color; update a preview area with live changes." 
     - Acceptance: Preview updates as inputs change
     - Commit: `Add Text personalisation page and live preview`

### Navigation (3%)
- Steps & prompts:
  1. Make sure all pages are reachable via Navigator.pushNamed
     - Prompt: "Add routes for Collections, CollectionPage, ProductPage, CartPage, AboutPage, Auth pages and link the UI to them" 
     - Acceptance: All routes reachable through navigation and buttons
     - Commit: `Add app routes and wire navigation`

### Responsiveness (5%) [x]
- Steps & prompts:
  1. Add breakpoints for grid and card layouts
     - Prompt: "Adjust GridView/Wrap to show 1 column on mobile and 3 columns on wide screens; test layout with browser width toggles." 
     - Acceptance: Layout adapts at different widths
     - Commit: `Make app responsive with grid breakpoints`

---

## Advanced (25%)

### Authentication system (8%)
- Steps & prompts:
  1. Add Firebase Auth or mock auth
     - Prompt: "Integrate Firebase/Mock auth, add login/signup flows with persistent session state and a dashboard page." 
     - Acceptance: Users can sign up, log in, and see a dashboard
     - Commit: `Add authentication flows and dashboard`

### Cart management (6%)
- Steps & prompts:
  1. Improve `Cart` persistence and totals
     - Prompt: "Persist cart to local storage; implement price calculations and per-item quantity edits and deletions." 
     - Acceptance: Cart persists between runs, quantities and totals update correctly
     - Commit: `Persist cart and add quantity/total calculations`

### Search (4%)
- Steps & prompts:
  1. Implement search across products
     - Prompt: "Add a search bar to the navbar and footer, wire to product model to show filtered results on the homepage and collection pages." 
     - Acceptance: Search returns filtered product lists
     - Commit: `Add search UI and filtering logic`

---

## Software development practices (25%)

### Git and commit discipline (8%)
- Steps:
  1. Commit each subtask with the suggested message templates
  2. Push regularly
  - Prompt: "Commit and push limited changes for each feature; include short commit messages"
  - Acceptance: Repo history shows small, descriptive commits

### README (5%)
- Steps:
  1. Replace default README with an accurate `README.md`
  2. Document how to run tests, dev server, and implemented features
  - Prompt: "Create README with 'How to run', 'Features implemented', 'Testing', 'Notes on data'"
  - Acceptance: README contains step-by-step start & test instructions

### Testing (6%) [x]
- Steps:
  1. Add widget tests for navigation and product-page rendering
  2. Ensure all tests pass
  - Prompt: "Add tests for header, footer, navigation to product page and cart add/remove"
  - Acceptance: All critical tests present and pass; tests added reflect new features

### External Services (6%)
- Steps:
  1. Choose an external service (Firebase recommended)
  2. Integrate auth/persistence if needed
  - Prompt: "Add integration for Firebase Auth/Firestore to store cart/session data" 
  - Acceptance: Basic service integration handles auth/persistence

---

## Prioritised implementation (step-by-step plan for this project)
1. Product model (done)
2. Make product images clickable on the home page (done)
3. ProductPage accepts a Product param and shows it (next)
4. Pass Product to ProductPage via Navigator and arguments
5. Collections: dynamic model + fixtures
6. Collection pages and linking
7. Cart skeleton and add-to-cart
8. Personalisation (Print Shack) page with live preview
9. Responsiveness and search
10. Authentication (Firebase or mock) and persistence

---

## Notes
- Prefer hardcoded data for the Basic assignments for speed; move to dynamic for intermediate tasks.
- Use `lib/models/fixtures.dart` to centralise sample data for products and collections.
- For images, prefer local assets (copyright-free or AI-generated) to avoid scraping the real site.

---

## Example LLM prompt format for each step:

"Implement [objective].
File: [path].
Change summary: [small numbered list of edits].
Constraints: [e.g., 'do not modify existing widget styles more than necessary'].
Acceptance criteria: [List - what will be checked in tests].
Commit message: [one-line message]."

This is the canonical structure to use when requesting code edits from an LLM: it keeps changes small, testable, and easy to commit.

---

End of checklist.
