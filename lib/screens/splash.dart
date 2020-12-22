import 'dart:async';
import 'package:flutter/material.dart';

String routeKey = 'createLock';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 3), () => Navigator.pushNamed(context, 'routeKey'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        backgroundColor: mainBgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image(
                width: MediaQuery.of(context).size.width * 0.6,
                image: AssetImage('images/icon1.png'),
              ),
            ),
            Center(
              child: Image(
                width: MediaQuery.of(context).size.width * 0.6,
                image: AssetImage('images/remito.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
