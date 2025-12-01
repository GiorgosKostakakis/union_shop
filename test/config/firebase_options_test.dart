import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/config/firebase_options.dart';

void main() {
  group('DefaultFirebaseOptions Tests', () {
    test('web options are defined', () {
      expect(DefaultFirebaseOptions.web.apiKey, isNotEmpty);
      expect(DefaultFirebaseOptions.web.appId, isNotEmpty);
      expect(DefaultFirebaseOptions.web.projectId, equals('union-3c208'));
    });

    test('android options are defined', () {
      expect(DefaultFirebaseOptions.android.apiKey, isNotEmpty);
      expect(DefaultFirebaseOptions.android.appId, isNotEmpty);
      expect(DefaultFirebaseOptions.android.projectId, equals('union-3c208'));
    });

    test('ios options are defined', () {
      expect(DefaultFirebaseOptions.ios.apiKey, isNotEmpty);
      expect(DefaultFirebaseOptions.ios.appId, isNotEmpty);
      expect(DefaultFirebaseOptions.ios.projectId, equals('union-3c208'));
      expect(DefaultFirebaseOptions.ios.iosBundleId, equals('com.example.unionShop'));
    });

    test('macos options are defined', () {
      expect(DefaultFirebaseOptions.macos.apiKey, isNotEmpty);
      expect(DefaultFirebaseOptions.macos.appId, isNotEmpty);
      expect(DefaultFirebaseOptions.macos.projectId, equals('union-3c208'));
    });

    test('windows options are defined', () {
      expect(DefaultFirebaseOptions.windows.apiKey, isNotEmpty);
      expect(DefaultFirebaseOptions.windows.appId, isNotEmpty);
      expect(DefaultFirebaseOptions.windows.projectId, equals('union-3c208'));
    });

    test('all platforms use same project ID', () {
      expect(DefaultFirebaseOptions.web.projectId, equals('union-3c208'));
      expect(DefaultFirebaseOptions.android.projectId, equals('union-3c208'));
      expect(DefaultFirebaseOptions.ios.projectId, equals('union-3c208'));
      expect(DefaultFirebaseOptions.macos.projectId, equals('union-3c208'));
      expect(DefaultFirebaseOptions.windows.projectId, equals('union-3c208'));
    });

    test('all platforms use same storage bucket', () {
      const expectedBucket = 'union-3c208.firebasestorage.app';
      expect(DefaultFirebaseOptions.web.storageBucket, equals(expectedBucket));
      expect(DefaultFirebaseOptions.android.storageBucket, equals(expectedBucket));
      expect(DefaultFirebaseOptions.ios.storageBucket, equals(expectedBucket));
      expect(DefaultFirebaseOptions.macos.storageBucket, equals(expectedBucket));
      expect(DefaultFirebaseOptions.windows.storageBucket, equals(expectedBucket));
    });
  });
}
