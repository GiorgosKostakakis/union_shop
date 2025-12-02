# Union Shop - Flutter E-Commerce Application

A fully-featured e-commerce application built with Flutter, inspired by the University of Portsmouth Student Union shop. This mobile-first web application provides a complete shopping experience with product browsing, authentication, cart management, and personalization features.

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-2.17+-0175C2?logo=dart)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Integrated-FFCA28?logo=firebase)](https://firebase.google.com)
[![Test Coverage](https://img.shields.io/badge/Coverage-89.97%25-brightgreen)](./coverage)

## 📋 Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Getting Started](#-getting-started)
- [Project Structure](#-project-structure)
- [Architecture](#-architecture)
- [External Services](#-external-services)
- [Testing](#-testing)
- [Development](#-development)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Features

### 🔐 Authentication & User Management
- **Firebase Authentication** with email/password
- **Google Sign-In** integration for quick access
- **User Dashboard** displaying order history and account information
- Secure logout and session management
- Password reset functionality

### 🛍️ Shopping Experience
- **Homepage** with featured products and hero sections
- **Collections Page** with multiple product categories
- **Individual Collection Pages** with sorting and filtering:
  - Sort by product count or alphabetically
  - Search within collections
  - Responsive grid layouts
- **Product Detail Pages** with:
  - Multiple product variants (size, color, etc.)
  - Quantity selectors
  - Dynamic pricing display
  - Image galleries
- **Sale Items** section with discounted pricing

### 🛒 Shopping Cart
- Add products to cart with selected options
- Modify quantities directly in cart
- Remove items from cart
- Real-time price calculations
- Original price display for sale items
- Persistent cart state
- Smooth checkout flow

### 🎨 Personalization (Print Shack)
- Custom text personalization service
- Multiple logo style options (Small, Large, Two Line, Three Line, Four Line)
- Font selection with live preview
- Text input validation
- Dynamic price updates based on selections
- Add personalized items to cart

### 🔍 Search Functionality
- Full-text product search across all items
- Real-time search results
- Search accessible from header and footer
- Product navigation from search results

### 📱 Responsive Design
- **Mobile-first** approach optimized for smartphones
- **Desktop-responsive** layouts for wider screens
- Adaptive navigation with mobile drawer
- Flexible grid layouts that adjust to screen size
- Touch-friendly UI elements

### 🎯 Navigation
- **Go Router** for declarative routing
- Deep linking support
- Browser back/forward button support
- Breadcrumb navigation
- Persistent navigation history
- Clean URL structure

### ℹ️ Informational Pages
- About Us page with company information
- Print Shack About page explaining personalization services
- Footer with quick links and information

## 📸 Screenshots

> **Note**: Screenshots showcase the application in mobile view (primary target) and desktop view (responsive layout).

### Homepage & Navigation
- Hero section with featured products
- Product grid showcasing popular items
- Header with navigation and cart indicator
- Mobile-friendly drawer menu

### Product Browsing
- Collections overview page
- Individual collection with filters
- Product detail pages with variants
- Sale items with discount badges

### Shopping & Checkout
- Shopping cart with item management
- User dashboard with order history
- Authentication screens (login/signup)
- Personalization interface

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:
- **Flutter SDK** (3.0 or higher)
- **Dart SDK** (2.17 or higher)
- **Git**
- A code editor (VS Code, Android Studio, or IntelliJ IDEA)
- **Google Chrome** (for web development)

Verify your Flutter installation:
```bash
flutter doctor
```

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/GiorgosKostakakis/union_shop.git
   cd union_shop
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run -d chrome
   ```

   The application will open in Chrome. Open DevTools (F12) and enable mobile device emulation for the best experience.

### Firebase Configuration

This application uses Firebase for authentication and data storage. The Firebase configuration is already set up in the repository. If you need to use your own Firebase project:

1. Create a new Firebase project at [firebase.google.com](https://firebase.google.com)
2. Enable **Firebase Authentication** (Email/Password and Google Sign-In)
3. Enable **Cloud Firestore** database
4. Download the configuration files:
   - `google-services.json` for Android (place in `android/app/`)
   - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)
   - Web configuration (update `lib/config/firebase_options.dart`)

## 📁 Project Structure

```
union_shop/
├── lib/
│   ├── main.dart                      # Application entry point and routing
│   ├── auth/                          # Authentication UI
│   │   ├── auth_widgets.dart          # Reusable auth components
│   │   ├── login_page.dart            # Login screen
│   │   └── signup_page.dart           # Signup screen
│   ├── config/
│   │   └── firebase_options.dart      # Firebase configuration
│   ├── models/                        # Data models
│   │   ├── cart.dart                  # Cart model
│   │   ├── cart_item.dart             # Cart item model
│   │   ├── collection.dart            # Collection model
│   │   ├── fixtures.dart              # Sample data
│   │   ├── order.dart                 # Order model
│   │   └── product.dart               # Product model
│   ├── services/                      # Business logic
│   │   ├── auth_provider.dart         # Authentication state management
│   │   ├── auth_service.dart          # Firebase Auth wrapper
│   │   ├── navigation_history.dart    # Navigation tracking
│   │   └── order_service.dart         # Order management
│   ├── views/                         # UI screens
│   │   ├── about_page.dart            # About Us page
│   │   ├── cart_page.dart             # Shopping cart
│   │   ├── collection_page.dart       # Individual collection view
│   │   ├── collections_page.dart      # All collections
│   │   ├── dashboard_page.dart        # User dashboard
│   │   ├── home_page.dart             # Homepage
│   │   ├── personalisation_page.dart  # Print Shack customization
│   │   ├── product_page.dart          # Product details
│   │   ├── sale_page.dart             # Sale items
│   │   └── search_page.dart           # Search results
│   └── widgets/                       # Reusable widgets
│       ├── footer.dart                # Footer component
│       └── header.dart                # Navigation header
├── test/                              # Test files (mirrors lib/ structure)
│   ├── auth/
│   ├── models/
│   ├── services/
│   ├── views/
│   └── widgets/
├── assets/                            # Images and static resources
├── coverage/                          # Test coverage reports
├── android/                           # Android-specific files
├── ios/                               # iOS-specific files
├── web/                               # Web-specific files
├── pubspec.yaml                       # Dependencies and assets
└── README.md                          # This file
```

## 🏗️ Architecture

### Design Patterns

- **Provider Pattern**: Used via `ChangeNotifier` for state management (Cart, AuthProvider)
- **Service Layer**: Business logic separated into service classes (AuthService, OrderService)
- **Repository Pattern**: Data models with clear separation of concerns
- **Declarative Routing**: Go Router for type-safe navigation

### State Management

- **ChangeNotifierProvider**: For cart state management
- **StreamBuilder**: For real-time Firebase data
- **StatefulWidget**: For local component state
- **InheritedWidget**: For auth state propagation

### Key Dependencies

```yaml
dependencies:
  flutter: sdk
  cupertino_icons: ^1.0.0
  go_router: ^17.0.0           # Declarative routing
  firebase_core: ^3.6.0        # Firebase initialization
  firebase_auth: ^5.3.1        # Authentication
  google_sign_in: ^6.2.1       # Google OAuth
  cloud_firestore: ^5.4.4      # NoSQL database
```

## 🔌 External Services

### 1. Firebase Authentication

**Purpose**: User authentication and account management

**Features**:
- Email/password authentication
- Google Sign-In integration
- Password reset via email
- User profile management (display name, photo URL)
- Account deletion

**Implementation**:
- Service wrapper: `lib/services/auth_service.dart`
- UI components: `lib/auth/login_page.dart`, `lib/auth/signup_page.dart`
- State management: `lib/services/auth_provider.dart`

**Usage Example**:
```dart
// Sign in with email
await authService.signInWithEmail('user@example.com', 'password');

// Sign in with Google
await authService.signInWithGoogle();

// Check authentication state
final user = authService.currentUser;
```

### 2. Cloud Firestore

**Purpose**: NoSQL database for storing orders and user data

**Features**:
- Real-time order synchronization
- User-specific order history
- Scalable document-based storage
- Offline persistence

**Implementation**:
- Service wrapper: `lib/services/order_service.dart`
- Data models: `lib/models/order.dart`

**Database Structure**:
```
orders/
  └── {orderId}/
      ├── userId: string
      ├── items: array
      ├── totalPrice: number
      ├── createdAt: timestamp
      └── status: string
```

**Usage Example**:
```dart
// Save an order
await orderService.saveOrder(userId, cart);

// Retrieve user orders
final orders = await orderService.getOrdersForUser(userId);

// Listen to order changes (real-time)
orderService.getOrdersStream(userId).listen((orders) {
  // Update UI with new orders
});
```

### 3. Google Sign-In

**Purpose**: OAuth authentication for quick user onboarding

**Features**:
- One-tap sign-in
- Automatic account creation
- Profile information import (name, email, photo)

**Implementation**: Integrated within `AuthService` with fallback handling

## 🧪 Testing

### Test Coverage

Current test coverage: **89.97%** (1740/1934 lines)

The application has comprehensive test coverage across all layers:

- **420 tests** in total
- **Unit tests**: Models, services, and business logic
- **Widget tests**: UI components and pages
- **Integration tests**: Navigation flows and user journeys

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/views/cart_page_test.dart

# Run tests in watch mode (requires external tool)
flutter test --watch
```

### Coverage Report

View the detailed coverage report:
```bash
# Generate HTML coverage report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Test Structure

Tests follow the same structure as the lib/ directory:

```
test/
├── auth/
│   ├── login_page_test.dart           # 19 tests
│   └── signup_page_test.dart          # 21 tests
├── models/
│   ├── cart_test.dart                 # Model validation tests
│   └── product_test.dart              # Product model tests
├── services/
│   ├── auth_service_test.dart         # 38 tests
│   └── order_service_test.dart        # 21 tests
├── views/
│   ├── cart_page_test.dart            # 12 tests
│   ├── collection_page_test.dart      # 28 tests
│   ├── dashboard_page_test.dart       # 14 tests
│   └── [other view tests]
└── widgets/
    ├── footer_test.dart               # 1 test
    └── header_test.dart               # 33 tests
```

### Test Categories

1. **Authentication Tests**: Login, signup, Google sign-in flows
2. **Cart Tests**: Add/remove items, quantity changes, price calculations
3. **Navigation Tests**: Route changes, back button, deep linking
4. **UI Tests**: Widget rendering, user interactions, responsive layouts
5. **Service Tests**: Firebase integration, order management, error handling

## 💻 Development

### Code Style

This project follows the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style) and uses `flutter_lints` for static analysis.

```bash
# Analyze code
flutter analyze

# Format code
dart format lib/ test/

# Fix auto-fixable issues
dart fix --apply
```

### Adding New Features

1. Create feature branch: `git checkout -b feature/my-new-feature`
2. Implement feature with tests
3. Ensure tests pass: `flutter test`
4. Ensure no analysis issues: `flutter analyze`
5. Format code: `dart format .`
6. Commit changes: `git commit -m "Add new feature"`
7. Push to repository: `git push origin feature/my-new-feature`

### Hot Reload

Flutter supports hot reload for rapid development:
- Press `r` in the terminal to hot reload
- Press `R` to hot restart
- Press `q` to quit

### Debugging

Enable debug mode features:
- **Flutter DevTools**: Run `flutter pub global run devtools`
- **Widget Inspector**: Available in IDE or DevTools
- **Performance Overlay**: Press `P` while app is running
- **Debug Paint**: Press `p` to show widget boundaries

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Write tests for new features
4. Ensure all tests pass (`flutter test`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Commit Message Convention

Follow conventional commits:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `test:` Adding or updating tests
- `refactor:` Code refactoring
- `style:` Code style changes (formatting)
- `chore:` Maintenance tasks

## 📄 License

This project was created as coursework for the University of Portsmouth. All rights reserved.

---

## 📞 Support

For questions or issues:
- **Repository**: [github.com/GiorgosKostakakis/union_shop](https://github.com/GiorgosKostakakis/union_shop)
- **Issues**: Use GitHub Issues for bug reports and feature requests

## 🙏 Acknowledgments

- University of Portsmouth for the coursework specification
- Flutter team for the excellent framework and documentation
- Firebase for backend services
- All contributors and testers

---

**Built with ❤️ using Flutter**
