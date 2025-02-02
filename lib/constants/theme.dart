import 'package:flutter/material.dart';
import 'package:price_pulse/constants/dark_theme.dart';
import 'package:price_pulse/constants/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

// getter for _themeData
  ThemeData get themeData => _themeData;

  //gettter for what state we are in
  bool get isDarkMode => _themeData == darkMode;

  //setter for this dark Mode
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
