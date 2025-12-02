import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/navigation_history.dart';

void main() {
  group('NavigationHistory Tests', () {
    late NavigationHistory navHistory;

    setUp(() {
      navHistory = NavigationHistory();
      // Clear history to start with just '/'
      navHistory.clear();
    });

    test('singleton returns same instance', () {
      final instance1 = NavigationHistory();
      final instance2 = NavigationHistory();

      expect(instance1, same(instance2));
    });

    test('canGoBack is false when history is empty', () {
      expect(navHistory.canGoBack, isFalse);
    });

    test('push adds location to history', () {
      navHistory.push('/home');

      expect(navHistory.canGoBack, isTrue);
    });

    test('pop returns previous location', () {
      navHistory.push('/home');
      navHistory.push('/about');

      final previous = navHistory.pop();

      expect(previous, equals('/home'));
    });

    test('pop returns null when history is empty', () {
      final result = navHistory.pop();

      expect(result, isNull);
    });

    test('pop removes last location from history', () {
      navHistory.push('/home');
      navHistory.push('/about');

      navHistory.pop();

      expect(navHistory.canGoBack, isTrue); // /home still there
      final previous = navHistory.pop();
      expect(previous, equals('/')); // Back to root
      expect(navHistory.canGoBack, isFalse);
    });

    test('push does not add duplicate consecutive locations', () {
      navHistory.push('/home');
      navHistory.push('/home'); // Duplicate

      final previous = navHistory.pop();
      expect(previous, equals('/')); // Back to root after removing duplicate
      expect(navHistory.canGoBack, isFalse);
    });

    test('push allows same location if not consecutive', () {
      navHistory.push('/home');
      navHistory.push('/about');
      navHistory.push('/home'); // Not consecutive, should be added

      final first = navHistory.pop();
      expect(first, equals('/about'));

      final second = navHistory.pop();
      expect(second, equals('/home'));
    });

    test('canGoBack updates correctly after multiple operations', () {
      expect(navHistory.canGoBack, isFalse);

      navHistory.push('/page1');
      expect(navHistory.canGoBack, isTrue);

      navHistory.push('/page2');
      expect(navHistory.canGoBack, isTrue);

      navHistory.pop();
      expect(navHistory.canGoBack, isTrue);

      navHistory.pop();
      expect(navHistory.canGoBack, isFalse);
    });

    test('handles multiple pushes and pops correctly', () {
      navHistory.push('/page1');
      navHistory.push('/page2');
      navHistory.push('/page3');
      navHistory.push('/page4');

      expect(navHistory.pop(), equals('/page3'));
      expect(navHistory.pop(), equals('/page2'));
      expect(navHistory.pop(), equals('/page1'));
      expect(navHistory.pop(), equals('/')); // Back to root
      expect(navHistory.pop(), isNull); // Can't go back further
      expect(navHistory.canGoBack, isFalse);
    });

    test('push handles empty string', () {
      navHistory.push('');

      expect(navHistory.canGoBack, isTrue);
      expect(navHistory.pop(), equals('/'));
    });

    test('push handles root route', () {
      navHistory.push('/');

      // Pushing '/' when already at '/' is a duplicate, so nothing happens
      expect(navHistory.canGoBack, isFalse);
    });

    test('push handles routes with query parameters', () {
      navHistory.push('/search?q=test');
      navHistory.push('/product?id=123');

      expect(navHistory.pop(), equals('/search?q=test'));
    });

    test('history getter returns unmodifiable list', () {
      navHistory.push('/page1');
      navHistory.push('/page2');

      final history = navHistory.history;

      expect(history, isA<List<String>>());
      expect(history.length, equals(3)); // '/', '/page1', '/page2'
      expect(history[0], equals('/'));
      expect(history[1], equals('/page1'));
      expect(history[2], equals('/page2'));

      // Should throw if we try to modify it
      expect(() => history.add('/page3'), throwsUnsupportedError);
    });

    test('currentLocation returns last location in history', () {
      expect(navHistory.currentLocation, equals('/'));

      navHistory.push('/page1');
      expect(navHistory.currentLocation, equals('/page1'));

      navHistory.push('/page2');
      expect(navHistory.currentLocation, equals('/page2'));

      navHistory.pop();
      expect(navHistory.currentLocation, equals('/page1'));
    });

    test('clear resets history to root', () {
      navHistory.push('/page1');
      navHistory.push('/page2');
      navHistory.push('/page3');

      navHistory.clear();

      expect(navHistory.canGoBack, isFalse);
      expect(navHistory.currentLocation, equals('/'));
      expect(navHistory.history.length, equals(1));
    });
  });
}
