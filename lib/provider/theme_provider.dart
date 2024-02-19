 /*import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = ThemeData.dark();

  ThemeData get theme => _theme;

  void toggleTheme() {
    final isDark = _theme == ThemeData.dark();
    if (isDark) {
      _theme = ThemeData.light();
    } else {
      _theme = ThemeData.dark();
    }
    notifyListeners();
  }
}*/

/*import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeData _lightTheme = ThemeData.light().copyWith(
    // Set your desired text, icon, and button colors for light mode here
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      // ...other text styles
    ),
    primaryIconTheme: const IconThemeData(color: Colors.blue),
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.light(),
    ),
  );

  final ThemeData _darkTheme = ThemeData.dark().copyWith(
    // Set your desired text, icon, and button colors for dark mode here
    primaryColorDark: const Color(0xff0b0b15),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      // ...other text styles
    ),
    primaryIconTheme: const IconThemeData(color: Colors.blue),
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.dark(),
    ),
  );

  ThemeData get theme => _isDark ? _darkTheme : _lightTheme;

  bool _isDark = true; // Start with dark mode by default

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
*/

 import 'package:flutter/material.dart';
 /// A provider that manages the theme of the app.
 class ThemeProvider with ChangeNotifier {
   bool _isDarkMode = true;

   bool get isDarkMode => _isDarkMode;

   void toggleTheme() {
     _isDarkMode = !_isDarkMode;
     notifyListeners();
   }
 }