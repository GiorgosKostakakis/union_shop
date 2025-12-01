import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/auth_provider.dart';

import '../test_helpers.dart';

void main() {
  group('AuthProvider', () {
    tearDown(() {
      AuthProvider.setMockInstance(null);
    });

    test('returns mock instance when set', () {
      final mockAuth = SimpleMockFirebaseAuth();
      AuthProvider.setMockInstance(mockAuth);
      
      final instance = AuthProvider.instance;
      expect(instance, equals(mockAuth));
    });

    test('setMockInstance sets the instance', () {
      final mockAuth1 = SimpleMockFirebaseAuth();
      final mockAuth2 = SimpleMockFirebaseAuth();
      
      AuthProvider.setMockInstance(mockAuth1);
      expect(AuthProvider.instance, equals(mockAuth1));
      
      AuthProvider.setMockInstance(mockAuth2);
      expect(AuthProvider.instance, equals(mockAuth2));
    });
  });
}
