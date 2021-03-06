import 'package:crowdgain/screens/borrower/borrowHome.dart';
import 'package:crowdgain/screens/borrower/waitingScreen.dart';
import 'package:crowdgain/utilities/constants.dart';
import 'package:crowdgain/utilities/data.dart';
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
final TextEditingController _nameController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
GlobalKey<ScaffoldState> _verificationrSaffoldKey = GlobalKey();
String productDropDownValue = stateAgency[0];

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
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
            key: _verificationrSaffoldKey,
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
                                      '''Verify
Membership''',
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
                                            DropdownButton(
                                              underline: SizedBox(),
                                              value: productDropDownValue,
                                              icon: Icon(Icons.arrow_drop_down),
                                              items: stateAgency.map((value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value.toString().substring(
                                                        0,
                                                        value.length > 35
                                                            ? 35
                                                            : value.length),
                                                    overflow: TextOverflow.fade,
                                                    style: GoogleFonts.openSans(
                                                      fontSize: ScreenUtil()
                                                          .setSp(38),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) async {
                                                setState(() {
                                                  productDropDownValue =
                                                      newValue;
                                                });
                                              },
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    ScreenUtil().setHeight(24),
                                              ),
                                              child: TextFormWidget(
                                                hint: 'Membership Id',
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
                                                hint: 'Reference Name',
                                                firstNameController:
                                                    _emailController,
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
                                                hint: 'Reference Number',
                                                firstNameController:
                                                    _phoneController,
                                                type: TextInputType.phone,
                                                obscure: false,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(160),
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
                                                    'Verify Membership',
                                                    style: GoogleFonts.openSans(
                                                      fontSize: ScreenUtil()
                                                          .setSp(48),
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                            onPressed: isWaiting
                                                ? null
                                                : () async {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            WaitingRoomScreen(),
                                                      ),
                                                    );
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

  _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              padding: EdgeInsets.all(5),
              color: whiteColor,
              child: DropdownButton(
                underline: SizedBox(),
                value: productDropDownValue,
                icon: Icon(Icons.arrow_drop_down),
                items: stateAgency.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) async {
                  setState(() {
                    productDropDownValue = newValue;
                  });
                },
              ),
            ),
          );
        });
  }
}
