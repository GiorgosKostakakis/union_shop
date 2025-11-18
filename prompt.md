"I have a Flutter e-commerce app with a home page that displays product cards in a grid. Currently, the product cards show product images, titles, and prices, but clicking on them doesn't do anything.

I need to implement navigation so that when a user clicks/taps on a product card (specifically the product image), it navigates to the ProductPage and displays that specific product's details.

Current Setup:

I have a HomeScreen widget in main.dart that displays a GridView with ProductCard widgets
Each ProductCard has: product image, title, and price
I already have a ProductPage widget in product_page.dart
Navigation routing is set up using named routes with '/product': (context) => const ProductPage()
What I need:

Make the ProductCard (or at least the product image) clickable/tappable
When clicked, navigate to the ProductPage
Pass the product data (title, price, image) from the home screen to the ProductPage so it displays the correct product
Update ProductPage to accept and display the passed product data instead of placeholder text
Constraints:

Use Flutter's Navigator for navigation
Keep the existing route structure
Make the implementation clean and follow Flutter best practices
Ensure the product data is properly passed between screens
Please provide step-by-step code changes needed to implement this feature."