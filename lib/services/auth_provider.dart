import 'package:firebase_auth/firebase_auth.dart';

/// Provides access to Firebase Auth in a way that can be overridden for testing
class AuthProvider {
  static FirebaseAuth? _mockInstance;

  /// Get the Firebase Auth instance (or mock in tests)
  static FirebaseAuth get instance {
    return _mockInstance ?? FirebaseAuth.instance;
  }

  /// Override the auth instance for testing
  static void setMockInstance(FirebaseAuth? mock) {
    _mockInstance = mock;
  }

  /// Reset to use real Firebase Auth
  static void reset() {
    _mockInstance = null;
  }
}
