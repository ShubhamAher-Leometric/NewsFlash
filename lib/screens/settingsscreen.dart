import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constatnts/constants.dart';
import 'helper/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool light = true;
  String language = 'en';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      light = !(prefs.getBool('isDarkMode') ?? false);
      language = prefs.getString('language') ?? 'en';
    });
  }

  _saveTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      light = value;
      prefs.setBool('isDarkMode', !light);
      Provider.of<ThemeProvider>(context, listen: false).toggleTheme(!light);
    });
  }

  _saveLanguage(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      language = lang;
      prefs.setString('language', language);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: themeProvider.isDarkMode ? DarkPrimaryColor : LightPrimaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Use Dark Theme'),
              trailing:  Switch(
                value: !light,
                activeColor: Colors.red,
                onChanged: (bool value) {
                  _saveTheme(!value);
                },
              ),
            ),
            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Use Dark Theme'),
            //       Switch(
            //         value: !light,
            //         activeColor: Colors.red,
            //         onChanged: (bool value) {
            //           _saveTheme(!value);
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            Divider(),
            ListTile(
              title: Text('Language'),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(language.toUpperCase()),
              ),
              onTap: () {
                _showLanguageDialog(context);
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('English'),
                onTap: () {
                  _saveLanguage('en');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Spanish'),
                onTap: () {
                  _saveLanguage('es');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
