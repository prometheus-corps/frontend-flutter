import 'package:crowdgain/screens/room.dart';
import 'package:crowdgain/utilities/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
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
                          color: whiteColor,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: "btn1",
                        elevation: 8,
                        onPressed: () {
                          // _scaffoldKeyHome.currentState.openDrawer();
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
                            Icons.menu_rounded,
                            size: 32.0,
                            color: whiteColor,
                          ),
                        ),
                        backgroundColor: blueColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
