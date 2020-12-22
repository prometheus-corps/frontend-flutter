import 'dart:async';
import 'dart:ui';
import 'package:crowdgain/utilities/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CreateLockScreen extends StatefulWidget {
  @override
  _CreateLockScreenState createState() => _CreateLockScreenState();
}

String pinKey;

class _CreateLockScreenState extends State<CreateLockScreen> {
  var onTapRecognizer;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Create Password',
                          style: GoogleFonts.raleway(
                            fontSize: ScreenUtil().setSp(65),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            '''Create 4 Digit Screen Lock Password''',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(
                              fontSize: ScreenUtil().setSp(42),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: ScreenUtil().setWidth(150),
                      ),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        obscureText: true,
                        obscuringCharacter: '*',
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v.length < 3) {
                            return '';
                          } else {
                            return null;
                          }
                        },
                        backgroundColor: Color(0xFFEFEFF2),
                        pinTheme: PinTheme(
                          inactiveFillColor: whiteColor,
                          activeColor: whiteColor,
                          activeFillColor: whiteColor,
                          inactiveColor: whiteColor,
                          selectedFillColor: whiteColor,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: ScreenUtil().setHeight(200),
                          fieldWidth: ScreenUtil().setWidth(140),
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        textStyle: TextStyle(fontSize: 20, height: 1.6),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        boxShadows: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          return true;
                        },
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(36),
                    horizontal: ScreenUtil().setWidth(140),
                  ),
                  child: ButtonTheme(
                    minWidth: ScreenUtil().setWidth(1080),
                    height: ScreenUtil().setHeight(150),
                    child: RaisedButton(
                      onPressed: () {},
                      color: blueColor,
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
