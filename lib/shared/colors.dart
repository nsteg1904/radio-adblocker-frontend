import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF191925);
const defaultFontColor = Color(0xFFFFFFFF);
const selectedElementColor = Color(0xfffb6580);
const areaColor =  Color(0xff2d2c3c);
const playButtonBackground = Color(0xff191925);
const playButton = Colors.white;
const unSelectedElementColor = Color(0x61E7DBDB);


const radioTileBackground = Color(0xff0b0b15);

const selectedFavIconColor = Colors.red;
const unSelectedFavIconColor = Color(0xff7b7b8b);

 ThemeData darktheme = ThemeData(
   brightness: Brightness.dark,
   scaffoldBackgroundColor: const Color(0xFF191925),
   cardTheme: const CardTheme(
     color: const Color(0xff0b0b15),
   ),
   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
     backgroundColor: Color(0xFF191925),
     selectedItemColor: Color(0xfffb6580),
     unselectedItemColor: Colors.grey,
   ),

   dialogBackgroundColor: Colors.black,
   appBarTheme: const AppBarTheme(
     backgroundColor: Color(0xff191925),
   ),
   colorScheme: const ColorScheme.dark(
     background: Color(0xFF191925),
     primary:Colors.grey,
     secondary: Colors.grey,
   ),
 );

ThemeData lighttheme = ThemeData(
  cardTheme: const CardTheme(
    color: const Color(0xff0b0b15),
  ),
  brightness: Brightness.light,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF191925),
    selectedItemColor: Color(0xfffb6580),
    unselectedItemColor: Colors.grey,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white70,
  ),
  colorScheme: const ColorScheme.light(
    background: Colors.white70,
    primary:Colors.black,
    secondary: Colors.black,
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
);