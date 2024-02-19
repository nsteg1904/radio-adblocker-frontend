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

/// The default theme of the app.
 ThemeData darktheme = ThemeData(
   brightness: Brightness.dark,
   scaffoldBackgroundColor: const Color(0xFF191925),
   cardTheme: const CardTheme(
     color:  Color(0xff0b0b15),
   ),
   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
     backgroundColor: Color(0xFF191925),
     selectedItemColor: Color(0xfffb6580),
     unselectedItemColor: Color(0xff7b7b8b),
   ),

   dialogBackgroundColor: Colors.black,
   appBarTheme: const AppBarTheme(
     backgroundColor: Color(0xff191925),
   ),
   colorScheme: const ColorScheme.dark(
     background: Color(0xFF191925),
     onBackground: Colors.white,
     primary:Color(0xff191925),
     onPrimary: Color(0xff1d1d30),
     secondary: Color(0xff2d2c3c),
     onSecondary: Color(0xfffb6580),
   ),
   textTheme: const TextTheme(
     bodyLarge: TextStyle(color: Colors.white),
     bodyMedium: TextStyle(color: Colors.white),
   ),
   iconTheme: const IconThemeData(color: Colors.grey),

 );
/// The light theme of the app.
ThemeData lighttheme = ThemeData(
  cardTheme: const CardTheme(
    color: Color(0xfffb6580),
  ),
  brightness: Brightness.light,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.blueGrey,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white70,
  ),
  colorScheme: const ColorScheme.light(
    background: Colors.white70,
    onBackground: Colors.black,
    primary:Colors.black,
    onPrimary: Colors.grey,
    secondary: Color(0xffe3667b),
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
    ),
  ),
);