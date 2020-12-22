import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payup/backend/fcmToken.dart';
import 'package:payup/screens/carDetails.dart';
import 'package:payup/screens/login.dart';
import 'package:payup/screens/room.dart';
import 'package:payup/utilities/constants.dart';
import 'package:payup/widgets/textform.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

String fcmToken = '';
bool isWaiting = false;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _userNameController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
GlobalKey<ScaffoldState> _registerSaffoldKey = GlobalKey();

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    getReady();
    super.initState();
  }

  getReady() async {
    fcmToken = await getFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(1080, 2400), allowFontScaling: false);
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: white,
        canvasColor: Color(0xFFEFEFF4),
        iconTheme: IconThemeData(color: darkFadeTextColor),
        primaryTextTheme: Typography.material2018().black,
        textTheme: Typography.material2018().black,
      ),
      darkTheme: ThemeData(
        primarySwatch: black,
        accentColor: black,
        brightness: Brightness.dark,
        canvasColor: mainTextColor,
        primaryTextTheme: Typography.material2018().white,
        textTheme: Typography.material2018().white,
      ),
      home: SafeArea(
        child: Scaffold(
          key: _registerSaffoldKey,
          body: SingleChildScrollView(
            reverse: false,
            child: Container(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom * 0.1,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(250),
                            bottom: ScreenUtil().setHeight(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Text(
                                  'Sign up to PayUp',
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
                                    '''Car Pool with friends. It's always fun!!!''',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                      fontSize: ScreenUtil().setSp(40),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(75),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(125),
                                        bottom: ScreenUtil().setHeight(24),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ACCOUNT INFORMATION',
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: ScreenUtil().setSp(35),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  ScreenUtil().setHeight(24),
                                            ),
                                            child: TextFormWidget(
                                              hint: 'Name',
                                              firstNameController:
                                                  _nameController,
                                              type: TextInputType.name,
                                              obscure: false,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  ScreenUtil().setHeight(24),
                                            ),
                                            child: TextFormWidget(
                                              hint: 'Email',
                                              firstNameController:
                                                  _emailController,
                                              type: TextInputType.emailAddress,
                                              obscure: false,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  ScreenUtil().setHeight(24),
                                            ),
                                            child: TextFormWidget(
                                              hint: 'Username',
                                              firstNameController:
                                                  _userNameController,
                                              type: TextInputType.name,
                                              obscure: false,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  ScreenUtil().setHeight(24),
                                            ),
                                            child: TextFormWidget(
                                              hint: 'Phone Number',
                                              firstNameController:
                                                  _phoneController,
                                              type: TextInputType.phone,
                                              obscure: false,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  ScreenUtil().setHeight(24),
                                            ),
                                            child: TextFormWidget(
                                              hint: 'Password',
                                              firstNameController:
                                                  _passwordController,
                                              type:
                                                  TextInputType.visiblePassword,
                                              obscure: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SignInButton(
                                      Buttons.Google,
                                      padding: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(22.5),
                                        horizontal: ScreenUtil().setWidth(230),
                                      ),
                                      text: "Sign in with Google",
                                      onPressed: () {
                                        // Navigator.pushNamed(context, 'profile');
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(36),
                                      ),
                                      child: ButtonTheme(
                                        minWidth: ScreenUtil().setWidth(1080),
                                        height: ScreenUtil().setHeight(150),
                                        child: RaisedButton(
                                          color: whiteColor,
                                          child: isWaiting
                                              ? Container(
                                                  height: ScreenUtil()
                                                      .setHeight(120),
                                                  width: ScreenUtil()
                                                      .setWidth(120),
                                                  padding: EdgeInsets.all(8),
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            mainTextColor),
                                                  ),
                                                )
                                              : Text(
                                                  'Sign In',
                                                  style: GoogleFonts.openSans(
                                                    fontSize:
                                                        ScreenUtil().setSp(48),
                                                    color: darkFadeTextColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                          onPressed: isWaiting
                                              ? null
                                              : () async {
                                                  if (checkStatus()) {
                                                    final response =
                                                        await http.post(
                                                      'https://payup-backend.herokuapp.com/users/register/',
                                                      headers: <String, String>{
                                                        'Content-type':
                                                            'application/json',
                                                        'Accept':
                                                            'application/json',
                                                        // "Authorization": "Some token"
                                                      },
                                                      body: json.encode(
                                                        <String, dynamic>{
                                                          "email":
                                                              _emailController
                                                                  .text,
                                                          "password":
                                                              _passwordController
                                                                  .text,
                                                          "username":
                                                              _userNameController
                                                                  .text,
                                                          "full_name":
                                                              _nameController
                                                                  .text,
                                                          "auto_login": true,
                                                          "device_registeration_token":
                                                              fcmToken,
                                                          "phone_number": _phoneController
                                                                      .text
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          3) ==
                                                                  '+91'
                                                              ? _phoneController
                                                                  .text
                                                              : _phoneController
                                                                          .text
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              2) ==
                                                                      '91'
                                                                  ? '+' +
                                                                      _phoneController
                                                                          .text
                                                                  : '+91' +
                                                                      _phoneController
                                                                          .text
                                                        },
                                                      ),
                                                    );
                                                    if (response.statusCode ==
                                                        201) {
                                                      final SharedPreferences
                                                          prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs.setString(
                                                          'refreshToken',
                                                          jsonDecode(response
                                                                  .body)[
                                                              'refreshToken']);
                                                      prefs.setBool(
                                                          'Logged', true);
                                                      Flushbar(
                                                        backgroundColor:
                                                            greenColor,
                                                        title:
                                                            "Login Successful",
                                                        message:
                                                            '''You're now a member of PayUp.''',
                                                        duration: Duration(
                                                            seconds: 3),
                                                      )..show(context);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CarDetailsScreen(
                                                            route:
                                                                RoomOptions(),
                                                          ),
                                                        ),
                                                      );
                                                    } else if (response
                                                            .statusCode ==
                                                        400) {
                                                      Flushbar(
                                                        backgroundColor:
                                                            redColor,
                                                        title: "Error",
                                                        message: jsonDecode(
                                                                    response
                                                                        .body)[
                                                                'Message']
                                                            .toString()
                                                            .split('(')[0],
                                                        duration: Duration(
                                                            seconds: 3),
                                                      )..show(context);
                                                    } else if (response
                                                            .statusCode ==
                                                        409) {
                                                      Flushbar(
                                                        backgroundColor:
                                                            redColor,
                                                        title: "Error",
                                                        message: jsonDecode(
                                                                    response
                                                                        .body)[
                                                                'Message']
                                                            .toString()
                                                            .split('(')[0],
                                                        duration: Duration(
                                                            seconds: 3),
                                                      )..show(context);
                                                    } else {
                                                      Flushbar(
                                                        backgroundColor:
                                                            redColor,
                                                        title: "Error",
                                                        message: jsonDecode(
                                                                    response
                                                                        .body)[
                                                                'Message']
                                                            .toString()
                                                            .split('(')[0],
                                                        duration: Duration(
                                                            seconds: 3),
                                                      )..show(context);
                                                    }
                                                  } else {
                                                    Flushbar(
                                                      backgroundColor: redColor,
                                                      title: "Error",
                                                      message:
                                                          '''Input shouldn't be null.''',
                                                      duration:
                                                          Duration(seconds: 3),
                                                    )..show(context);
                                                  }
                                                },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(
                              200,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '''Already have an account?  ''',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.raleway(
                                  fontSize: ScreenUtil().setSp(42),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute<bool>(
                                      builder: (BuildContext context) =>
                                          LoginScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  '''Log in''',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.raleway(
                                    fontSize: ScreenUtil().setSp(42),
                                    fontWeight: FontWeight.w600,
                                    color: redColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkStatus() {
    if (_nameController.text.isEmpty && _nameController.text == "") {
      Flushbar(
        backgroundColor: redColor,
        title: "Error",
        message: 'Name should not be empty.',
        duration: Duration(seconds: 3),
      )..show(context);
      return false;
    } else if (_emailController.text.isEmpty && _emailController.text == "") {
      Flushbar(
        backgroundColor: redColor,
        title: "Error",
        message: 'Email should not be empty.',
        duration: Duration(seconds: 3),
      )..show(context);
      return false;
    } else if (_passwordController.text.isEmpty &&
        _passwordController.text == "") {
      Flushbar(
        backgroundColor: redColor,
        title: "Error",
        message: 'Password should not be empty.',
        duration: Duration(seconds: 3),
      )..show(context);
      return false;
    } else if (_userNameController.text.isEmpty &&
        _userNameController.text == "") {
      Flushbar(
        backgroundColor: redColor,
        title: "Error",
        message: 'Username should not be empty.',
        duration: Duration(seconds: 3),
      )..show(context);
      return false;
    } else if (_phoneController.text.isEmpty && _phoneController.text == "") {
      Flushbar(
        backgroundColor: redColor,
        title: "Error",
        message: 'Phone Number should not be empty.',
        duration: Duration(seconds: 3),
      )..show(context);
      return false;
    } else if (!(_emailController.text.toString().contains(
          new RegExp(r'@', caseSensitive: true),
        ))) {
      Flushbar(
        backgroundColor: redColor,
        title: "Error",
        message: 'Enter valid email id.',
        duration: Duration(seconds: 3),
      )..show(context);
      return false;
    } else if (_passwordController.text.length < 8) {
      Flushbar(
        backgroundColor: redColor,
        title: "Error",
        message: 'Password too short.',
        duration: Duration(seconds: 3),
      )..show(context);
      return false;
    } else {
      return true;
    }
  }
}
