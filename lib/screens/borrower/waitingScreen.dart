import 'package:crowdgain/screens/borrower/borrowHome.dart';
import 'package:crowdgain/utilities/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitingRoomScreen extends StatefulWidget {
  @override
  _WaitingRoomScreenState createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
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
            backgroundColor: blueColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'images/verify.png',
                  height: ScreenUtil().setHeight(1200),
                  width: ScreenUtil().setWidth(800),
                  fit: BoxFit.fitWidth,
                ),
                Column(
                  children: [
                    Center(
                      child: Text(
                        'Please Wait',
                        style: TextStyle(
                          fontFamily: 'Bambino',
                          fontSize: ScreenUtil().setSp(90),
                          fontWeight: FontWeight.w700,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Center(
                        child: Text(
                          '''You'll be notified after verification''',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(
                            fontSize: ScreenUtil().setSp(50),
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
