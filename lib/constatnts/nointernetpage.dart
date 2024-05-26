import 'package:flashnews/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../screens/helper/theme_provider.dart';
import 'package:provider/provider.dart';
import 'appbar.dart';
import 'constants.dart';


class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: customAppBar(themeProvider),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    child: SvgPicture.asset('assets/network_error.svg'), // Use SvgPicture.asset
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 260,left: 95),
                    child: Text(
                      'No Internet',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
                    ),
                  )
                ]
            ),
            // Icon(Icons.wifi_off, size: 100, color: Color(0xffef5252)),
            Text(
              'Somethimg wrong with your connection,\nplease check and try again.',textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Color(0xff757575)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:  themeProvider.isDarkMode ? DarkPrimaryColor : LightPrimaryColor, // Background color
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text('Try Again',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
