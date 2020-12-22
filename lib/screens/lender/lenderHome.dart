import 'package:crowdgain/screens/bigText.dart';
import 'package:crowdgain/screens/room.dart';
import 'package:crowdgain/utilities/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LendHomeScreen extends StatefulWidget {
  @override
  _LendHomeScreenState createState() => _LendHomeScreenState();
}

class _LendHomeScreenState extends State<LendHomeScreen> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 2;
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
            bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: ScreenUtil().setSp(18),
              unselectedFontSize: ScreenUtil().setSp(12),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: blueColor,
              unselectedItemColor: fadeColor,
              currentIndex: currentIndex,
              onTap: (value) {
                setState(() {
                  currentIndex = value;
                });
                if (currentIndex == 1) {
                  Navigator.pushNamed(context, 'search');
                } else if (currentIndex == 2) {
                  Navigator.pushNamed(context, 'user');
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.sortAmountUpAlt,
                    size: ScreenUtil().setSp(65),
                  ),
                  label: 'Transactions',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.wallet,
                    size: ScreenUtil().setSp(45),
                  ),
                  label: 'Due',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: ScreenUtil().setSp(80),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.search,
                    size: ScreenUtil().setSp(45),
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.cog,
                    size: ScreenUtil().setSp(45),
                  ),
                  label: 'Settings',
                ),
              ],
            ),
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
                        'Lend Money',
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
                          top: ScreenUtil().setHeight(20),
                        ),
                        child: Text(
                          'Simple Steps',
                          style: GoogleFonts.raleway(
                            fontSize: ScreenUtil().setSp(50),
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
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                Icons.add_business_rounded,
                              ),
                              buildGestureDetector(
                                """Add
Nominee""",
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                FontAwesomeIcons.userCheck,
                              ),
                              buildGestureDetector(
                                '''Find Loan
Tickets''',
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                FontAwesomeIcons.searchDollar,
                              ),
                            ],
                          )
                        ],
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
                                """Check Interest
Rates""",
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                FontAwesomeIcons.university,
                              ),
                              buildGestureDetector(
                                """Transfer
Amount""",
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                FontAwesomeIcons.rupeeSign,
                              ),
                              buildGestureDetector(
                                """Done""",
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                Icons.done_outline_rounded,
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

  GestureDetector buildGestureDetector(
    String name,
    String desc,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => UserGuide(
              desc: desc,
              pageName: name,
              iconData: icon,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(90),
          ),
          RaisedButton(
            color: blue,
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
                icon,
                color: whiteColor,
                size: 30,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => UserGuide(
                    desc: desc,
                    pageName: name,
                    iconData: icon,
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(35),
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
