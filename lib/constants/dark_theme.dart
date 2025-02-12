import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Color(0xaa86b8ff),
    onPrimary: Colors.white.withOpacity(0.8),
    secondary: Color(0xaa2281ff),
    onSecondary: Colors.white,
    tertiary: Color(0xaa1145ff),
    onTertiary: Colors.black,
    background: Colors.black,
    onBackground: Colors.white,
    surface: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 80.0,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 50.0,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: TextStyle(
      fontSize: 100.0,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontSize: 100.0,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
);
