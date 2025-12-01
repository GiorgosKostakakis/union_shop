import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/config/firebase_options.dart';

void main() {
  group('DefaultFirebaseOptions Tests', () {
    test('currentPlatform returns correct options for web', () {
      debugDefaultTargetPlatformOverride = null;
      // This test runs on the current platform, so we just verify it doesn't throw
      expect(() => DefaultFirebaseOptions.currentPlatform, returnsNormally);
    });

    test('currentPlatform throws for unsupported linux platform', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
      expect(
        () => DefaultFirebaseOptions.currentPlatform,
        throwsA(isA<UnsupportedError>().having(
          (e) => e.message,
          'message',
          contains('linux'),
        )),
      );
      debugDefaultTargetPlatformOverride = null;
    });

    test('currentPlatform returns android options for android platform', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      final options = DefaultFirebaseOptions.currentPlatform;
      expect(options.projectId, equals('union-3c208'));
      expect(options.apiKey, equals(DefaultFirebaseOptions.android.apiKey));
      debugDefaultTargetPlatformOverride = null;
    });

    test('currentPlatform returns ios options for iOS platform', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final options = DefaultFirebaseOptions.currentPlatform;
      expect(options.projectId, equals('union-3c208'));
      expect(options.apiKey, equals(DefaultFirebaseOptions.ios.apiKey));
      debugDefaultTargetPlatformOverride = null;
    });

    test('currentPlatform returns macos options for macOS platform', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      final options = DefaultFirebaseOptions.currentPlatform;
      expect(options.projectId, equals('union-3c208'));
      expect(options.apiKey, equals(DefaultFirebaseOptions.macos.apiKey));
      debugDefaultTargetPlatformOverride = null;
    });

    test('currentPlatform returns windows options for windows platform', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;
      final options = DefaultFirebaseOptions.currentPlatform;
      expect(options.projectId, equals('union-3c208'));
      expect(options.apiKey, equals(DefaultFirebaseOptions.windows.apiKey));
      debugDefaultTargetPlatformOverride = null;
    });

    test('currentPlatform returns fuchsia options throws for unsupported platform', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
      expect(
        () => DefaultFirebaseOptions.currentPlatform,
        throwsA(isA<UnsupportedError>().having(
          (e) => e.message,
          'message',
          contains('not supported for this platform'),
        )),
      );
      debugDefaultTargetPlatformOverride = null;
    });

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
