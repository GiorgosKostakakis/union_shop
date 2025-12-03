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

## 📸 Screenshots & Demo

> **Note**: The application is optimized for mobile view but fully responsive for desktop.

### 🏠 Homepage
<img src="assets/hero.png" width="300" alt="Homepage Hero Section">

The homepage features a hero banner with featured products and a grid showcasing popular items.

### 🛍️ Collections & Products
Collections are organized by category with filtering and sorting capabilities. Each product page displays variants, pricing, and detailed information.

### 🛒 Shopping Cart
<img src="assets/logo.png" width="100" alt="Union Shop Logo">

Real-time cart management with quantity adjustments, price calculations, and checkout flow.

### 🔐 Authentication
Secure login and signup with email/password or Google Sign-In integration. User dashboard displays order history.

### 🎨 Personalization (Print Shack)
Custom text personalization with live preview, multiple logo styles, and font selection options.

### 📱 Responsive Design
The application adapts seamlessly between mobile and desktop views with touch-friendly UI elements.

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure your system meets the following requirements:

#### Operating System
- **macOS** (10.14 or later) for iOS development
- **Windows** (10 or later, 64-bit)
- **Linux** (64-bit)

#### Required Software & Tools

1. **Flutter SDK** (version 3.0 or higher)
   - Download from [flutter.dev](https://flutter.dev/docs/get-started/install)
   - Add Flutter to your system PATH

2. **Dart SDK** (version 2.17 or higher)
   - Included with Flutter SDK
   - Standalone download available at [dart.dev](https://dart.dev/get-dart)

3. **Git** (version control)
   - Download from [git-scm.com](https://git-scm.com/downloads)
   - Or install via package manager:
     - macOS: `brew install git`
     - Windows: `choco install git`
     - Linux: `sudo apt-get install git`

4. **Code Editor** (choose one)
   - [Visual Studio Code](https://code.visualstudio.com/) (recommended)
     - Install Flutter and Dart extensions
   - [Android Studio](https://developer.android.com/studio)
   - [IntelliJ IDEA](https://www.jetbrains.com/idea/)

5. **Google Chrome** (for web development)
   - Download from [google.com/chrome](https://www.google.com/chrome/)
   - Required for running and testing the web application

#### Verify Installation

After installing Flutter, verify your setup:
```bash
flutter doctor
```

This command checks your environment and displays a report. Ensure all required components show a checkmark (✓). Address any issues indicated by the doctor command before proceeding.

Expected output:
```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x, on macOS/Windows/Linux)
[✓] Chrome - develop for the web
[✓] VS Code (version x.x.x)
```

### Installation

Follow these step-by-step instructions to set up the project on your local machine:

#### Step 1: Clone the Repository

Open your terminal or command prompt and run:

```bash
git clone https://github.com/GiorgosKostakakis/union_shop.git
```

This will create a local copy of the repository in a folder named `union_shop`.

#### Step 2: Navigate to Project Directory

```bash
cd union_shop
```

#### Step 3: Install Dependencies

Install all required Flutter packages and dependencies:

```bash
flutter pub get
```

This command reads the `pubspec.yaml` file and downloads all necessary packages. Wait for the process to complete.

Expected output:
```
Running "flutter pub get" in union_shop...
Resolving dependencies...
Got dependencies!
```

#### Step 4: Verify Project Setup

Check that the project is properly configured:

```bash
flutter analyze
```

This ensures there are no immediate code issues. All checks should pass.

### Running the Application

This application is designed to run on **web** and is optimized for **mobile view**.

#### Option 1: Run from Command Line (Recommended)

```bash
flutter run -d chrome
```

This command will:
1. Build the application
2. Launch Google Chrome
3. Open the application in a new browser tab

#### Option 2: Run from VS Code

1. Open the project in VS Code
2. Press `F5` or click **Run > Start Debugging**
3. Select **Chrome** as the target device
4. The app will launch in Chrome

#### Option 3: Run from Android Studio/IntelliJ

1. Open the project in Android Studio/IntelliJ
2. Select **Chrome (web)** from the device dropdown
3. Click the **Run** button (green play icon)

### Viewing in Mobile Mode

Once the application is running in Chrome:

1. **Open Chrome DevTools**
   - Right-click on the page and select **Inspect**
   - Or press `F12` (Windows/Linux) or `Cmd+Option+I` (macOS)

2. **Enable Device Toolbar**
   - Click the **Toggle device toolbar** icon (looks like a phone/tablet)
   - Or press `Ctrl+Shift+M` (Windows/Linux) or `Cmd+Shift+M` (macOS)

3. **Select a Mobile Device**
   - From the **Dimensions** dropdown, choose a device:
     - iPhone 12 Pro
     - iPhone SE
     - Pixel 5
     - Galaxy S20
   - Or set custom dimensions (e.g., 375 x 667)

4. **Refresh the Page**
   - Press `F5` or `Ctrl+R` to reload with mobile viewport

### Firebase Configuration

This application uses Firebase for authentication and data storage. The Firebase configuration is already set up in the repository.

#### Using the Existing Configuration (Recommended)

The project includes pre-configured Firebase settings:
- Web configuration in `lib/config/firebase_options.dart`
- Android configuration in `android/app/google-services.json`
- iOS configuration in `ios/Runner/GoogleService-Info.plist`

No additional setup is required to run the application with the existing Firebase project.

#### Setting Up Your Own Firebase Project (Optional)

If you want to use your own Firebase instance:

1. **Create Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Click **Add Project**
   - Follow the setup wizard

2. **Enable Authentication**
   - In Firebase Console, navigate to **Authentication**
   - Click **Get Started**
   - Enable **Email/Password** sign-in method
   - Enable **Google** sign-in method
   - Add your domain to authorized domains

3. **Enable Cloud Firestore**
   - Navigate to **Firestore Database**
   - Click **Create Database**
   - Start in **test mode** (for development)
   - Choose a location

4. **Configure Web App**
   - Go to **Project Settings** > **Your apps**
   - Click the **Web** icon (</>)
   - Register your app
   - Copy the Firebase configuration
   - Update `lib/config/firebase_options.dart` with your values

5. **Configure Android (Optional)**
   - In Firebase Console, add an Android app
   - Download `google-services.json`
   - Place it in `android/app/`

6. **Configure iOS (Optional)**
   - In Firebase Console, add an iOS app
   - Download `GoogleService-Info.plist`
   - Place it in `ios/Runner/`

### Running Tests

Verify the application works correctly by running the test suite:

```bash
# Run all tests
flutter test

# Run tests with coverage report
flutter test --coverage

# Run specific test file
flutter test test/views/cart_page_test.dart
```

All 420 tests should pass successfully.

### Hot Reload & Hot Restart

During development, Flutter provides fast iteration:

- **Hot Reload** (`r` in terminal): Updates UI without losing state
- **Hot Restart** (`R` in terminal): Restarts app and resets state
- **Quit** (`q` in terminal): Stops the application

### Troubleshooting

#### Issue: "Flutter command not found"
**Solution**: Add Flutter to your PATH. See [Flutter installation guide](https://flutter.dev/docs/get-started/install).

#### Issue: Chrome not detected
**Solution**: Install Google Chrome and ensure it's in your system PATH.

#### Issue: Packages not found after `flutter pub get`
**Solution**: Try `flutter pub cache repair` then run `flutter pub get` again.

#### Issue: Firebase errors on startup
**Solution**: Ensure Firebase configuration files are present and valid. Check `lib/config/firebase_options.dart`.

#### Issue: Build fails on first run
**Solution**: Run `flutter clean` then `flutter pub get` and try again.

For more help, consult the [Flutter documentation](https://flutter.dev/docs) or check the [GitHub Issues](https://github.com/GiorgosKostakakis/union_shop/issues) page.

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

## 🏗️ Architecture & Technologies

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

### Technologies Used

**Frontend Framework**:
- Flutter SDK 3.0+ - Cross-platform UI toolkit
- Dart 2.17+ - Programming language

**Backend & Services**:
- Firebase Authentication - User authentication
- Cloud Firestore - NoSQL database
- Google Sign-In - OAuth provider

**Routing & Navigation**:
- Go Router 17.0.0 - Declarative routing with deep linking

**Development Tools**:
- Flutter Test - Testing framework
- Dart DevTools - Debugging and profiling
- Git - Version control

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
## 🐛 Known Issues & Limitations

### Current Limitations

1. **Web-Only Deployment**: Currently optimized for web deployment. Native mobile builds (iOS/Android) require additional configuration.

2. **Payment Integration**: Checkout flow is simulated - no real payment processing is implemented.

3. **Image Assets**: Uses local assets instead of a CDN or cloud storage solution for product images.

4. **Offline Support**: Limited offline functionality - requires internet connection for authentication and order management.

### Future Improvements

- [ ] Implement real payment gateway integration (Stripe/PayPal)
- [ ] Add product reviews and ratings system
- [ ] Implement wishlist functionality
- [ ] Add admin panel for product management
- [ ] Support for multiple currencies
- [ ] Enhanced analytics and user tracking
- [ ] Push notifications for order updates
- [ ] Native mobile app deployment

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
- `chore:` Maintenance taskslease follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
## 📞 Contact & Support

### Developer Information

**Giorgos Kostakakis**
- GitHub: [@GiorgosKostakakis](https://github.com/GiorgosKostakakis)
- Repository: [github.com/GiorgosKostakakis/union_shop](https://github.com/GiorgosKostakakis/union_shop)

### Getting Help

For questions or issues:
- **Bug Reports**: Use [GitHub Issues](https://github.com/GiorgosKostakakis/union_shop/issues) for bug reports
- **Feature Requests**: Submit feature requests via GitHub Issues with the `enhancement` label
- **Discussions**: Use GitHub Discussions for general questions

## 🙏 Acknowledgments

- **University of Portsmouth** for the coursework specification and support
- **Flutter Team** for the excellent framework and comprehensive documentation
- **Firebase Team** for robust backend services
- **Open Source Community** for the amazing packages and tools
- All contributors and testers who helped improve this project

---

## 📝 Project Information

**Course**: Programming Applications and Programming Languages (M30235) / User Experience Design and Implementation (M32605)  
**Institution**: University of Portsmouth  
**Academic Year**: 2024-2025  
**Project Type**: Coursework Assessment  

---

**Built with ❤️ using Flutter**

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
