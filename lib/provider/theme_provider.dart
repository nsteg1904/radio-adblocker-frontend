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