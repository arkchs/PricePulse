import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color(0xff86b8ff),
    onPrimary: Colors.black,
    secondary: Color(0xff2281ff),
    onSecondary: Colors.white,
    tertiary: Color(0xff1145ff),
    onTertiary: Colors.white,
    background: Colors.white24,
    onBackground: Colors.black,
    surface: Colors.grey,
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
      fontSize: 50.0,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
);
