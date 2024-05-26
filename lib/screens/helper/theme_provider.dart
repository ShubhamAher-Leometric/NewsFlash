import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  String _language = 'en'; // Default language

  bool get isDarkMode => _isDarkMode;
  String get language => _language;

  void toggleTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }

  void setLanguage(String language) {
    _language = language;
    notifyListeners();
  }
}
