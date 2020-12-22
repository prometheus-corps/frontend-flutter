import 'dart:ui';
import 'package:crowdgain/utilities/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateLockScreen extends StatefulWidget {
  @override
  _CreateLockScreenState createState() => _CreateLockScreenState();
}

String pinKey;

class _CreateLockScreenState extends State<CreateLockScreen> {
  TextEditingController _controller = TextEditingController();
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(1080, 2400), allowFontScaling: false);
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: MaterialApp(
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: white,
          canvasColor: Color(0xFFEFEFF4),
          iconTheme: IconThemeData(color: blackColor),
          primaryTextTheme: Typography.material2018().black,
          textTheme: Typography.material2018().black,
        ),
        darkTheme: ThemeData(
          primarySwatch: black,
          accentColor: black,
          brightness: Brightness.dark,
          canvasColor: blackColor,
          primaryTextTheme: Typography.material2018().white,
          textTheme: Typography.material2018().white,
        ),
        home: SafeArea(
          child: Scaffold(
            key: _scaffold,
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            backgroundColor: splashBgColor,
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Text(
                                'Create Password',
                                style: GoogleFonts.raleway(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Create a 4-digit code',
                                style: GoogleFonts.raleway(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return RadialGradient(
                                    center: Alignment.center,
                                    radius: 0.5,
                                    colors: <Color>[
                                      blueColor,
                                      blueColor,
                                    ],
                                    tileMode: TileMode.repeated,
                                  ).createShader(bounds);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 32.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 65, vertical: 20),
                    child: PinInputTextFormField(
                      controller: _controller,
                      pinLength: 4,
                      decoration: UnderlineDecoration(
                        colorBuilder: PinListenColorBuilder(
                            cardInsideColor, cardInsideColor),
                        textStyle: GoogleFonts.raleway(
                          fontWeight: FontWeight.bold,
                          color: mainTextColor,
                          fontSize: 32,
                        ),
                        obscureStyle: ObscureStyle(
                          isTextObscure: true,
                          obscureText: '*',
                        ),
                      ),
                      textInputAction: TextInputAction.go,
                      enabled: true,
                      keyboardType: TextInputType.number,
                      onChanged: (pin) {
                        setState(() {
                          pinKey = pin;
                        });
                      },
                      onSaved: (pin) {
                        setState(() {
                          pinKey = pin;
                        });
                      },
                      onSubmit: (pin) {
                        setState(() {
                          pinKey = pin;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(36),
                  ),
                  child: ButtonTheme(
                    minWidth: ScreenUtil().setWidth(1080),
                    height: ScreenUtil().setHeight(150),
                    child: RaisedButton(
                      onPressed: () {},
                      color: whiteColor,
                      child: Text('Enter'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
