import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/auth_provider.dart' as auth_provider;

/// Mock Firebase Auth for testing that returns no user
class MockFirebaseAuth implements FirebaseAuth {
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
  
  // Set mock Firebase Auth instance
  auth_provider.AuthProvider.setMockInstance(MockFirebaseAuth());
}

