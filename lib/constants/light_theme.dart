import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color(0xff86b8ff),
    onPrimary: Colors.black,
    secondary: Color(0xff2281ff),
    onSecondary: Color(0xff2281ff),
    tertiary: Color(0xff2281ff),
    onTertiary: Color(0xff2281ff),
    background: Color(0xff2281ff),
    onBackground: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 100.0,
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
