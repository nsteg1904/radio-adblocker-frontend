import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class is responsible for managing the theme of the app.
class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }
/// Loads the theme from the shared preferences.
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = (prefs.getBool('isDarkMode') ?? true);
    notifyListeners();
  }
/// Toggles the theme of the app.
  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = !_isDarkMode;
    prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
