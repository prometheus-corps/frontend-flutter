import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: SafeArea(
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
                                color: mainTextColor,
                              ),
                            ),
                            Text(
                              'Create a 4-digit code',
                              style: GoogleFonts.raleway(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: fadeColor,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 65, vertical: 20),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 40,
                      top: MediaQuery.of(context).size.height * 0.7),
                  child: GradientButton(
                    increaseHeightBy: 20,
                    increaseWidthBy: 250,
                    gradient: gradientBtn,
                    shapeRadius: BorderRadius.circular(5),
                    child: Text(
                      'Enter',
                      style: GoogleFonts.raleway(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    callback: () async {
                      if (pinKey != null && pinKey != '') {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        try {
                          setState(() {
                            prefs.setBool('isNew', true);
                            prefs.setInt('userPass', int.tryParse(pinKey));
                          });
                        } catch (e) {}
                        Navigator.pushNamed(context, 'userHome');
                      } else {
                        _scaffold.currentState.showSnackBar(SnackBar(
                          backgroundColor: errorCardColor,
                          content: Text(
                            'Try Another Password',
                            style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          duration: Duration(seconds: 3),
                        ));
                      }
                      _controller.clear();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
