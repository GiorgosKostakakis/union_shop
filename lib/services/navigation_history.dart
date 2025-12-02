import 'package:flutter/foundation.dart';

/// Tracks navigation history for back button functionality
class NavigationHistory extends ChangeNotifier {
  static final NavigationHistory _instance = NavigationHistory._internal();
  factory NavigationHistory() => _instance;
  NavigationHistory._internal();

  final List<String> _history = ['/'];

  List<String> get history => List.unmodifiable(_history);

  String get currentLocation => _history.isNotEmpty ? _history.last : '/';

  bool get canGoBack => _history.length > 1;

  void push(String location) {
    // Don't add duplicate consecutive entries
    if (_history.isEmpty || _history.last != location) {
      _history.add(location);
      notifyListeners();
    }
  }

  String? pop() {
    if (_history.length > 1) {
      _history.removeLast();
      notifyListeners();
      return _history.last;
    }
    return null;
  }

  void clear() {
    _history.clear();
    _history.add('/');
    notifyListeners();
  }
}
