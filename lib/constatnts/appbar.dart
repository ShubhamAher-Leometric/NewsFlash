import 'package:flutter/material.dart';
import '../screens/helper/theme_provider.dart';
import 'constants.dart';

PreferredSizeWidget customAppBar(ThemeProvider themeProvider) {
  return AppBar(
    backgroundColor: themeProvider.isDarkMode ? DarkPrimaryColor : LightPrimaryColor,
    leading: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image.asset(
        'assets/logo.png',
      ),
    ),
    title: const Text('NewsFlash',style:TextStyle(fontWeight: FontWeight.w500),),
    titleSpacing: 0,
  );
}

