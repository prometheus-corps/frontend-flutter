import 'package:crowdgain/screens/borrower/borrowHome.dart';
import 'package:crowdgain/utilities/constants.dart';
import 'package:crowdgain/widgets/textfield.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

bool isWaiting = false;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _userNameController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _accountController = TextEditingController();
GlobalKey<ScaffoldState> _verificationrSaffoldKey = GlobalKey();

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    int currentIndex = 2;
    ScreenUtil.init(context,
        designSize: Size(1080, 2400), allowFontScaling: false);
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BorrowHomeScreen(),
          ),
        );
        return Future.value(false);
      },
      child: MaterialApp(
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: blueColor,
          primarySwatch: blue,
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
                              top: ScreenUtil().setHeight(150),
                              bottom: ScreenUtil().setHeight(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(90),
                                    ),
                                    child: Text(
                                      'Register',
                                      style: GoogleFonts.roboto(
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold,
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
                                              'MEMBERSHIP VERIFICATION',
                                              style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    ScreenUtil().setSp(35),
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
                                                type:
                                                    TextInputType.emailAddress,
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
                                                hint: 'Bank Account Number',
                                                firstNameController:
                                                    _accountController,
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
                                                type: TextInputType
                                                    .visiblePassword,
                                                obscure: true,
                                              ),
                                            ),
                                          ],
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
                                                              blackColor),
                                                    ),
                                                  )
                                                : Text(
                                                    'Upload Id Proof',
                                                    style: GoogleFonts.openSans(
                                                      fontSize: ScreenUtil()
                                                          .setSp(48),
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                            onPressed:
                                                isWaiting ? null : () async {},
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(0),
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
                                                              blackColor),
                                                    ),
                                                  )
                                                : Text(
                                                    'Register',
                                                    style: GoogleFonts.openSans(
                                                      fontSize: ScreenUtil()
                                                          .setSp(48),
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w600,
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
      ),
    );
  }
}
