import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:union_shop/services/auth_provider.dart' as auth_provider;

/// Helper to set up larger viewport and suppress layout overflow errors
void setupLargeViewport(WidgetTester tester, {bool suppressOverflow = true}) {
  tester.view.physicalSize = const Size(1920, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() => tester.view.reset());
  
  if (suppressOverflow) {
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (!details.toString().contains('overflow')) {
        originalOnError?.call(details);
      }
    };
    addTearDown(() => FlutterError.onError = originalOnError);
  }
}

/// Mock User for testing
class MockUser extends Fake implements User {
  final String _uid;
  final String? _email;
  final String? _displayName;
  final MockFirebaseAuth? _auth;
  
  MockUser({
    required String uid,
    String? email,
    String? displayName,
    MockFirebaseAuth? auth,
  })  : _uid = uid,
        _email = email,
        _displayName = displayName,
        _auth = auth;

  @override
  String get uid => _uid;

  @override
  String? get email => _email;

  @override
  String? get displayName => _displayName;

  @override
  Future<void> updateDisplayName(String? displayName) async {}

  @override
  Future<void> updatePhotoURL(String? photoURL) async {}

  @override
  Future<void> reload() async {}

  @override
  Future<void> delete() async {
    if (_auth != null && _email != null) {
      _auth!._users.remove(_email);
      _auth!._currentUser = null;
      _auth!._authStateController.add(null);
    }
  }
}

/// Mock UserCredential for testing
class MockUserCredential extends Fake implements UserCredential {
  final User? _user;

  MockUserCredential({User? user}) : _user = user;

  @override
  User? get user => _user;
}

/// Mock Firebase Auth for testing with controllable state
class MockFirebaseAuth implements FirebaseAuth {
  User? _currentUser;
  final StreamController<User?> _authStateController = StreamController<User?>.broadcast();
  final Map<String, String> _users = {}; // email -> password

  MockFirebaseAuth({User? currentUser}) : _currentUser = currentUser;

  @override
  Stream<User?> authStateChanges() => _authStateController.stream;

  @override
  Stream<User?> idTokenChanges() => _authStateController.stream;

  @override
  Stream<User?> userChanges() => _authStateController.stream;

  @override
  User? get currentUser => _currentUser;

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (_users.containsKey(email)) {
      throw FirebaseAuthException(
        code: 'email-already-in-use',
        message: 'The email address is already in use.',
      );
    }
    
    _users[email] = password;
    _currentUser = MockUser(
      uid: 'mock_uid_${email.hashCode}',
      email: email,
      auth: this,
    );
    _authStateController.add(_currentUser);
    
    return MockUserCredential(user: _currentUser);
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (!_users.containsKey(email)) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found for that email.',
      );
    }
    
    if (_users[email] != password) {
      throw FirebaseAuthException(
        code: 'wrong-password',
        message: 'Wrong password provided.',
      );
    }
    
    _currentUser = MockUser(
      uid: 'mock_uid_${email.hashCode}',
      email: email,
      auth: this,
    );
    _authStateController.add(_currentUser);
    
    return MockUserCredential(user: _currentUser);
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _authStateController.add(null);
  }

  @override
  Future<void> sendPasswordResetEmail({
    required String email,
    ActionCodeSettings? actionCodeSettings,
  }) async {
    // Mock implementation - just succeeds
  }

  @override
  Future<UserCredential> signInWithPopup(AuthProvider provider) async {
    _currentUser = MockUser(
      uid: 'mock_google_uid',
      email: 'test@google.com',
      displayName: 'Test User',
      auth: this,
    );
    _authStateController.add(_currentUser);
    return MockUserCredential(user: _currentUser);
  }

  @override
  Future<UserCredential> signInWithCredential(AuthCredential credential) async {
    _currentUser = MockUser(
      uid: 'mock_google_uid',
      email: 'test@google.com',
      displayName: 'Test User',
      auth: this,
    );
    _authStateController.add(_currentUser);
    return MockUserCredential(user: _currentUser);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  void dispose() {
    _authStateController.close();
  }
}

/// Simple Mock Firebase Auth that returns no user (for widgets that just need auth context)
class SimpleMockFirebaseAuth implements FirebaseAuth {
  @override
  Stream<User?> authStateChanges() => Stream.value(null);

  @override
  Stream<User?> idTokenChanges() => Stream.value(null);

  @override
  Stream<User?> userChanges() => Stream.value(null);

  @override
  User? get currentUser => null;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void setupFirebaseMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  // Set simple mock Firebase Auth instance for basic widget tests
  auth_provider.AuthProvider.setMockInstance(SimpleMockFirebaseAuth());
}

/// Mock GoogleSignIn for testing
class MockGoogleSignIn extends Fake implements GoogleSignIn {
  @override
  Future<GoogleSignInAccount?> signIn() async {
    // Return null to simulate user canceling
    return null;
  }

  @override
  Future<GoogleSignInAccount?> signOut() async {
    return null;
  }
}


