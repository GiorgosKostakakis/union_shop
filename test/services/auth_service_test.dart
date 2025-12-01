import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/auth_provider.dart' as auth_provider;
import '../test_helpers.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late AuthService authService;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    auth_provider.AuthProvider.setMockInstance(mockAuth);
    authService = AuthService(googleSignIn: mockGoogleSignIn);
  });

  tearDown(() {
    mockAuth.dispose();
  });

  group('AuthService Tests', () {
    test('currentUser returns null initially', () {
      expect(authService.currentUser, isNull);
    });

    test('isAuthenticated returns false initially', () {
      expect(authService.isAuthenticated, isFalse);
    });

    test('authStateChanges provides stream', () {
      expect(authService.authStateChanges, isA<Stream<User?>>());
    });

    test('signUpWithEmail creates new user', () async {
      final user = await authService.signUpWithEmail(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(user, isNotNull);
      expect(user?.email, 'test@example.com');
      expect(authService.currentUser, isNotNull);
      expect(authService.isAuthenticated, isTrue);
    });

    test('signUpWithEmail with display name', () async {
      final user = await authService.signUpWithEmail(
        email: 'named@example.com',
        password: 'password123',
        displayName: 'Test User',
      );

      expect(user, isNotNull);
      expect(user?.email, 'named@example.com');
    });

    test('signUpWithEmail throws on duplicate email', () async {
      // Create first user
      await authService.signUpWithEmail(
        email: 'duplicate@example.com',
        password: 'password123',
      );

      // Sign out to attempt second signup
      await authService.signOut();

      // Try to create duplicate
      expect(
        () => authService.signUpWithEmail(
          email: 'duplicate@example.com',
          password: 'password456',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('signInWithEmail succeeds with correct credentials', () async {
      // Create user first
      await authService.signUpWithEmail(
        email: 'signin@example.com',
        password: 'password123',
      );

      // Sign out
      await authService.signOut();
      expect(authService.isAuthenticated, isFalse);

      // Sign in
      final user = await authService.signInWithEmail(
        email: 'signin@example.com',
        password: 'password123',
      );

      expect(user, isNotNull);
      expect(user?.email, 'signin@example.com');
      expect(authService.isAuthenticated, isTrue);
    });

    test('signInWithEmail throws on wrong password', () async {
      // Create user
      await authService.signUpWithEmail(
        email: 'wrongpass@example.com',
        password: 'correctpassword',
      );

      await authService.signOut();

      // Try wrong password
      expect(
        () => authService.signInWithEmail(
          email: 'wrongpass@example.com',
          password: 'wrongpassword',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('signInWithEmail throws on non-existent user', () async {
      expect(
        () => authService.signInWithEmail(
          email: 'nonexistent@example.com',
          password: 'password123',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('signOut clears current user', () async {
      // Sign in first
      await authService.signUpWithEmail(
        email: 'signout@example.com',
        password: 'password123',
      );

      expect(authService.isAuthenticated, isTrue);

      // Sign out
      await authService.signOut();

      expect(authService.currentUser, isNull);
      expect(authService.isAuthenticated, isFalse);
    });

    test('sendPasswordResetEmail succeeds', () async {
      await authService.sendPasswordResetEmail('reset@example.com');
      // Should not throw
    });

    test('updateProfile updates display name', () async {
      // Sign in first
      await authService.signUpWithEmail(
        email: 'update@example.com',
        password: 'password123',
      );

      await authService.updateProfile(displayName: 'New Name');
      // Should not throw
    });

    test('updateProfile throws when no user logged in', () async {
      expect(
        () => authService.updateProfile(displayName: 'Test'),
        throwsA(isA<Exception>()),
      );
    });

    test('deleteAccount removes user', () async {
      // Sign in first
      await authService.signUpWithEmail(
        email: 'delete@example.com',
        password: 'password123',
      );

      expect(authService.isAuthenticated, isTrue);

      await authService.deleteAccount();

      // User should be gone
      expect(authService.currentUser, isNull);
    });

    test('signInWithGoogle handles user cancellation', () async {
      // GoogleSignIn returns null when user cancels (mobile)
      // Should not throw an exception
      final user = await authService.signInWithGoogle();
      
      // User can be null if they cancel, which is fine
      expect(user, isNull);
    });

    test('handles multiple sign in/out cycles', () async {
      for (int i = 0; i < 3; i++) {
        await authService.signUpWithEmail(
          email: 'cycle$i@example.com',
          password: 'password123',
        );
        expect(authService.isAuthenticated, isTrue);

        await authService.signOut();
        expect(authService.isAuthenticated, isFalse);
      }
    });

    test('notifies listeners on auth state changes', () async {
      int listenerCallCount = 0;
      authService.addListener(() {
        listenerCallCount++;
      });

      await authService.signUpWithEmail(
        email: 'listener@example.com',
        password: 'password123',
      );

      expect(listenerCallCount, greaterThan(0));
    });
  });
}
