import 'package:crowdgain/utilities/constants.dart';
import 'package:crowdgain/widgets/textfield.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';

class BorrowerRegistrationScreen extends StatefulWidget {
  @override
  _BorrowerRegistrationScreenState createState() =>
      _BorrowerRegistrationScreenState();
}

bool isWaiting = false;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _userNameController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
GlobalKey<ScaffoldState> _registerSaffoldKey = GlobalKey();

class _BorrowerRegistrationScreenState
    extends State<BorrowerRegistrationScreen> {
  @override
  void initState() {
    super.initState();
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
                                  'Register',
                                  style: GoogleFonts.raleway(
                                    fontSize: ScreenUtil().setSp(65),
                                    fontWeight: FontWeight.w700,
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
                                                            Color>(blackColor),
                                                  ),
                                                )
                                              : Text(
                                                  'Sign In',
                                                  style: GoogleFonts.openSans(
                                                    fontSize:
                                                        ScreenUtil().setSp(48),
                                                    color: blackColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                          onPressed:
                                              isWaiting ? null : () async {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
}
