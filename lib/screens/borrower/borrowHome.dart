import 'package:crowdgain/screens/room.dart';
import 'package:crowdgain/utilities/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BorrowHomeScreen extends StatefulWidget {
  @override
  _BorrowHomeScreenState createState() => _BorrowHomeScreenState();
}

class _BorrowHomeScreenState extends State<BorrowHomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    ScreenUtil.init(context,
        designSize: Size(1080, 2400), allowFontScaling: false);
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomScreen(),
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
            extendBodyBehindAppBar: true,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(60),
                    horizontal: ScreenUtil().setWidth(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Borrow Money',
                        style: GoogleFonts.roboto(
                          fontSize: ScreenUtil().setSp(80),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: "btn1",
                        elevation: 8,
                        onPressed: () {
                          // _scaffoldKeyHome.currentState.openDrawer();
                        },
                        child: Icon(
                          Icons.menu_rounded,
                          size: 32.0,
                          color: whiteColor,
                        ),
                        backgroundColor: blueColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(800),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(45),
                    horizontal: ScreenUtil().setWidth(50),
                  ),
                  child: FlatButton(
                    color: blue,
                    onPressed: () {
                      // Navigator.pushNamed(context, 'loginuser');
                    },
                    minWidth: ScreenUtil().screenWidth,
                    height: ScreenUtil().setHeight(150),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.raleway(
                        fontSize: ScreenUtil().setSp(50),
                        fontWeight: FontWeight.w700,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(50),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(50),
                        ),
                        child: Text(
                          'Simple Steps',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Dash(
                            length: ScreenUtil().setWidth(800),
                            dashLength: 12,
                            dashColor: isDarkMode ? whiteColor : blackColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildGestureDetector(
                                '''Register
For Free''',
                              ),
                              buildGestureDetector(
                                """Draft 
a Request""",
                              ),
                              buildGestureDetector(
                                """Verification By
State Agency""",
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector buildGestureDetector(String name) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(90),
          ),
          RaisedButton(
            shape: CircleBorder(
              side: BorderSide(
                color: blue,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                ScreenUtil().setHeight(50),
              ),
              child: Icon(
                Icons.add_business_rounded,
                color: whiteColor,
                size: 30,
              ),
            ),
            onPressed: () {},
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
