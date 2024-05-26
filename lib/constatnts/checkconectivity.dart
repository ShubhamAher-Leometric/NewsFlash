import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flashnews/screens/homescreen.dart';
import 'package:flutter/cupertino.dart';

import 'nointernetpage.dart';

class ConnectivityCheck extends StatefulWidget {
  @override
  _ConnectivityCheckState createState() => _ConnectivityCheckState();
}

class _ConnectivityCheckState extends State<ConnectivityCheck> {
  late bool isOnline;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      isOnline = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isOnline ? HomeScreen() : NoInternetScreen();
  }
}
