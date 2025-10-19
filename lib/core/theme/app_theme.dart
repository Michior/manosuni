import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFF2780D);
  static const Color backgroundLight = Colors.white;
  static const Color backgroundDark = Colors.black;

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundLight,
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: backgroundLight,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
    ),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      background: backgroundLight,
      surface: backgroundLight,
      onSurface: Colors.black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundDark,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: backgroundDark,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
    ),
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      background: backgroundDark,
      surface: backgroundDark,
      onSurface: Colors.white,
    ),
  );
}
