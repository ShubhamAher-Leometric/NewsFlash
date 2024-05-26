import 'package:flutter/material.dart';
import '../screens/helper/theme_provider.dart';
import 'constants.dart';

PreferredSizeWidget customAppBar(ThemeProvider themeProvider) {
  return AppBar(
    backgroundColor: themeProvider.isDarkMode ? DarkPrimaryColor : LightPrimaryColor,
    title: const Text('FlashNews'),
  );
}

