import 'dart:async';
import 'package:crowdgain/utilities/constants.dart';
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
    Timer(Duration(seconds: 3), () => Navigator.pushNamed(context, 'routeKey'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        backgroundColor: blueColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                  vertical: 25,
                ),
                child: Image(
                  image: AssetImage('images/logo.png'),
                ),
              ),
              Text(
                'CrowdPay',
                style: TextStyle(
                  fontFamily: 'Bambino',
                  fontSize: 35,
                  color: whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
