import 'package:crowdgain/utilities/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
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
            backgroundColor: blueColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'images/room.png',
                  height: ScreenUtil().setHeight(650),
                  width: ScreenUtil().setWidth(400),
                  fit: BoxFit.fitWidth,
                ),
                Column(
                  children: [
                    Center(
                      child: Text(
                        'Make More Money',
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
                          '''Making your money work for you''',
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(
                    75,
                  )),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(36),
                        ),
                        child: ButtonTheme(
                          minWidth: ScreenUtil().setWidth(1080),
                          height: ScreenUtil().setHeight(150),
                          child: RaisedButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => CreateRoomScreen(),
                              //   ),
                              // );
                            },
                            color: whiteColor,
                            child: Text(
                              'Lend Money',
                              style: TextStyle(
                                fontFamily: 'Bambino',
                                fontSize: ScreenUtil().setSp(48),
                                color: blackColor,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
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
                            onPressed: () async {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => QRScanner(),
                              //   ),
                              // );
                            },
                            color: whiteColor,
                            child: Text(
                              'Borrow Money',
                              style: TextStyle(
                                fontFamily: 'Bambino',
                                fontSize: ScreenUtil().setSp(48),
                                color: blackColor,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
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
    );
  }
}
