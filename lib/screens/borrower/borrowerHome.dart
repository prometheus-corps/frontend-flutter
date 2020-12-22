import 'dart:ui';
import 'package:crowdgain/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:google_fonts/google_fonts.dart';

double _sigmaX = 0.0;
double _sigmaY = 0.0;
double _opacity = 0.1;
bool isLogged = false;

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  GlobalKey<ScaffoldState> _scaffoldKeyHome = GlobalKey<ScaffoldState>();
  Map crossItem = {};
  bool dropColor = true;
  TextEditingController _controllerTop;
  TextEditingController _controllerBtm;
  String _selectedLocationTop = '';
  String _selectedLocationBottom = '';
  List<String> items = [];
  List<String> name = [];
  List<String> country = [];
  int indexTopCount = 0;
  int indexBottomCount = 1;
  double percentCount = 2;
  double topCount = 1.0;
  double rate = 0;
  double bottomCount = 1.0;
  int currentIndex;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    if (_selectedLocationBottom != '' && _selectedLocationTop != '') {
      return SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return Future.value(false);
          },
          child: Scaffold(
            key: _scaffoldKeyHome,
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 25, right: 25.0),
              child: FloatingActionButton(
                heroTag: "btn1",
                elevation: 8,
                onPressed: () {
                  _scaffoldKeyHome.currentState.openDrawer();
                },
                child: ShaderMask(
                  shaderonPressed: (Rect bounds) {
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
                  ),
                ),
                backgroundColor: blackColor,
              ),
            ),
            backgroundColor: splashBgColor,
            body: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                  child: Container(
                    color: Colors.black.withOpacity(_opacity * 10),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 35,
                      top: 30,
                    ),
                    child: Text(
                      'Home',
                      style: GoogleFonts.roboto(
                        color: whiteColor,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 10, bottom: 15),
                                child: Text(
                                  '''Exchange Price Rate''',
                                  style: GoogleFonts.raleway(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  Dash(
                                    direction: Axis.vertical,
                                    length: height * 0.15,
                                    dashLength: 15,
                                    dashColor: whiteColor,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: height * 0.06,
                                        padding: EdgeInsets.all(0),
                                        margin: EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: whiteColor,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: width * 0.3,
                                              height: height * 0.06,
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              color: Color(0xFFffffff)
                                                  .withOpacity(0.5),
                                              child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  canvasColor: blueColor,
                                                ),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    style: TextStyle(
                                                        color: whiteColor,
                                                        decorationColor:
                                                            whiteColor),
                                                    value: _selectedLocationTop,
                                                    items: items
                                                        .map((String value) {
                                                      return new DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: new Text(
                                                          value,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  whiteColor),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.35,
                                              padding: EdgeInsets.all(10),
                                              child: TextFormField(
                                                maxLength: 9,
                                                onSaved: (value) {
                                                  _controllerTop =
                                                      TextEditingController(
                                                          text: value);
                                                  setState(() {});
                                                },
                                                controller: _controllerTop,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.raleway(
                                                  color: whiteColor,
                                                  fontSize: height * 0.03,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                decoration: InputDecoration(
                                                  counterText: "",
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.2,
                                            ),
                                            Text(
                                              '2 USD Total Fees',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: whiteColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.06,
                                        padding: EdgeInsets.all(0),
                                        margin: EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: whiteColor,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: width * 0.3,
                                              height: height * 0.06,
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              color: Color(0xFFffffff)
                                                  .withOpacity(0.5),
                                              child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  canvasColor: blueColor,
                                                ),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    style: TextStyle(
                                                        color: whiteColor,
                                                        decorationColor:
                                                            whiteColor),
                                                    value:
                                                        _selectedLocationBottom,
                                                    items: items
                                                        .map((String value) {
                                                      return new DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: new Text(
                                                          value,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  whiteColor),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.35,
                                              padding: EdgeInsets.all(10),
                                              child: TextFormField(
                                                enabled: false,
                                                maxLength: 9,
                                                onChanged: (value) {
                                                  _controllerBtm =
                                                      TextEditingController(
                                                          text: value);
                                                  setState(() {});
                                                },
                                                controller: _controllerBtm,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.raleway(
                                                  color: whiteColor,
                                                  fontSize: height * 0.03,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                decoration: InputDecoration(
                                                  counterText: "",
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: RaisedButton(
                         
                          onPressed: () {
                            Navigator.pushNamed(context, 'loginuser');
                          },
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.raleway(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.06,
                        vertical: height * 0.04,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Use The Steps',
                              style: GoogleFonts.raleway(
                                color: whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, top: 50),
                                child: Dash(
                                  direction: Axis.horizontal,
                                  length: width * 0.7,
                                  dashLength: 12,
                                  dashColor: whiteColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //   SlideRightRoute(
                                          //     page: UserGuide(
                                          //       iconData:
                                          //           Icons.app_registration,
                                          //       desc: desc[1],
                                          //       pageName: title[0],
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            RaisedButton(
                                              shape: CircleBorder(),
                                              child: Icon(
                                                Icons.app_registration,
                                                color: whiteColor,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                // Navigator.of(context).push(
                                                //   SlideRightRoute(
                                                //     page: UserGuide(
                                                //       iconData: Icons
                                                //           .app_registration,
                                                //       desc: desc[1],
                                                //       pageName: title[0],
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                            ),
                                            Text(
                                              '''Register
For Free''',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: whiteColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //   SlideRightRoute(
                                          //     page: UserGuide(
                                          //       iconData: Icons
                                          //           .wallet_membership_rounded,
                                          //       desc: desc[1],
                                          //       pageName: title[1],
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            RaisedButton(
                                              shape: CircleBorder(),
                                              child: Icon(
                                                Icons.wallet_membership_rounded,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                // Navigator.of(context).push(
                                                //   SlideRightRoute(
                                                //     page: UserGuide(
                                                //       iconData: Icons
                                                //           .wallet_membership_rounded,
                                                //       desc: desc[1],
                                                //       pageName: title[1],
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                            ),
                                            Text(
                                              '''Wallet
Topup''',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: whiteColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //   SlideRightRoute(
                                          //     page: UserGuide(
                                          //       iconData:
                                          //           Icons.comment_bank_rounded,
                                          //       desc: desc[2],
                                          //       pageName: title[2],
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            RaisedButton(
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.comment_bank_rounded,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  // Navigator.of(context).push(
                                                  //   SlideRightRoute(
                                                  //     page: UserGuide(
                                                  //       iconData: Icons
                                                  //           .comment_bank_rounded,
                                                  //       desc: desc[2],
                                                  //       pageName: title[2],
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                                ),
                                            Text(
                                              '''Transfer
Details''',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: whiteColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, top: 50),
                                    child: Dash(
                                      direction: Axis.horizontal,
                                      length: width * 0.7,
                                      dashLength: 12,
                                      dashColor: whiteColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.of(context).push(
                                            //   SlideRightRoute(
                                            //     page: UserGuide(
                                            //       iconData: Icons
                                            //           .add_business_rounded,
                                            //       desc: desc[3],
                                            //       pageName: title[3],
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              RaisedButton(
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.add_business_rounded,
                                                  color: whiteColor,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  // Navigator.of(context).push(
                                                  //   SlideRightRoute(
                                                  //     page: UserGuide(
                                                  //       iconData: Icons
                                                  //           .add_business_rounded,
                                                  //       desc: desc[3],
                                                  //       pageName: title[3],
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                                ,
                                              ),
                                              Text(
                                                '''Add Recipient's
Bank Details''',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: whiteColor),
                                              )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.of(context).push(
                                            //   SlideRightRoute(
                                            //     page: UserGuide(
                                            //       iconData: Icons
                                            //           .receipt_long_rounded,
                                            //       desc: desc[4],
                                            //       pageName: title[4],
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              RaisedButton(
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.receipt_long_rounded,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  // Navigator.of(context).push(
                                                  //   SlideRightRoute(
                                                  //     page: UserGuide(
                                                  //       iconData: Icons
                                                  //           .receipt_long_rounded,
                                                  //       desc: desc[4],
                                                  //       pageName: title[4],
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                                ,
                                              ),
                                              Text(
                                                '''Acknowledgement''',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: whiteColor),
                                              )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.of(context).push(
                                            //   SlideRightRoute(
                                            //     page: UserGuide(
                                            //       iconData: Icons
                                            //           .done_outline_rounded,
                                            //       desc: desc[5],
                                            //       pageName: title[5],
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              RaisedButton(
                                                  shape: CircleBorder(),
                                                  child: Icon(
                                                    Icons.done_outline_rounded,
                                                    size: 30,
                                                  ),
                                                  onPressed: () {
                                                    // Navigator.of(context).push(
                                                    //   SlideRightRoute(
                                                    //     page: UserGuide(
                                                    //       iconData: Icons
                                                    //           .done_outline_rounded,
                                                    //       desc: desc[5],
                                                    //       pageName: title[5],
                                                    //     ),
                                                    //   ),
                                                    // );
                                                  },
                                                  ),
                                              Text(
                                                '''Done''',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: whiteColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                
              ],
            ),
          ),
        ),
      );
    } else {
      return SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return Future.value(false);
          },
          child: Scaffold(
            key: _scaffoldKeyHome,
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 25, right: 25.0),
              child: FloatingActionButton(
                heroTag: "btn1",
                elevation: 8,
                onPressed: () {
                  _scaffoldKeyHome.currentState.openDrawer();
                },
                child: ShaderMask(
                  shaderonPressed: (Rect bounds) {
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
                  ),
                ),
                backgroundColor: whiteColor,
              ),
            ),
            backgroundColor: splashBgColor,
            body: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                  child: Container(
                    color: Colors.black.withOpacity(_opacity * 10),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 35,
                      top: 30,
                    ),
                    child: Text(
                      'Home',
                      style: GoogleFonts.roboto(
                        color: whiteColor,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.18),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(whiteColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.005),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: RaisedButton(
                          
                          onPressed: () {
                            Navigator.pushNamed(context, 'loginuser');
                          },
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.raleway(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.06,
                        vertical: height * 0.04,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Use The Steps',
                              style: GoogleFonts.raleway(
                                color: whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, top: 50),
                                child: Dash(
                                  direction: Axis.horizontal,
                                  length: width * 0.7,
                                  dashLength: 12,
                                  dashColor: whiteColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //   SlideRightRoute(
                                          //     page: UserGuide(
                                          //       iconData:
                                          //           Icons.app_registration,
                                          //       desc: desc[1],
                                          //       pageName: title[0],
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            RaisedButton(
                                              shape: CircleBorder(),
                                              child: Icon(
                                                Icons.app_registration,
                                                color: whiteColor,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                // Navigator.of(context).push(
                                                //   SlideRightRoute(
                                                //     page: UserGuide(
                                                //       iconData: Icons
                                                //           .app_registration,
                                                //       desc: desc[1],
                                                //       pageName: title[0],
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                            ),
                                            Text(
                                              '''Register 
For Free''',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: whiteColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //   SlideRightRoute(
                                          //     page: UserGuide(
                                          //       iconData: Icons
                                          //           .wallet_membership_rounded,
                                          //       desc: desc[1],
                                          //       pageName: title[1],
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            RaisedButton(
                                              shape: CircleBorder(),
                                              child: Icon(
                                                Icons.wallet_membership_rounded,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                // Navigator.of(context).push(
                                                //   SlideRightRoute(
                                                //     page: UserGuide(
                                                //       iconData: Icons
                                                //           .wallet_membership_rounded,
                                                //       desc: desc[1],
                                                //       pageName: title[1],
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                            ),
                                            Text(
                                              '''Wallet 
Topup''',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: whiteColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //   SlideRightRoute(
                                          //     page: UserGuide(
                                          //       iconData:
                                          //           Icons.comment_bank_rounded,
                                          //       desc: desc[2],
                                          //       pageName: title[2],
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            RaisedButton(
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.comment_bank_rounded,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  // Navigator.of(context).push(
                                                  //   SlideRightRoute(
                                                  //     page: UserGuide(
                                                  //       iconData: Icons
                                                  //           .comment_bank_rounded,
                                                  //       desc: desc[2],
                                                  //       pageName: title[2],
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                                ),
                                            Text(
                                              '''Transfer 
Details''',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: whiteColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, top: 50),
                                    child: Dash(
                                      direction: Axis.horizontal,
                                      length: width * 0.7,
                                      dashLength: 12,
                                      dashColor: whiteColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.of(context).push(
                                            //   SlideRightRoute(
                                            //     page: UserGuide(
                                            //       iconData: Icons
                                            //           .add_business_rounded,
                                            //       desc: desc[3],
                                            //       pageName: title[3],
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              RaisedButton(
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.add_business_rounded,
                                                  color: whiteColor,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  // Navigator.of(context).push(
                                                  //   SlideRightRoute(
                                                  //     page: UserGuide(
                                                  //       iconData: Icons
                                                  //           .add_business_rounded,
                                                  //       desc: desc[3],
                                                  //       pageName: title[3],
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                              ),
                                              Text(
                                                '''Add Recipient's
Bank Details''',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: whiteColor),
                                              )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.of(context).push(
                                            //   SlideRightRoute(
                                            //     page: UserGuide(
                                            //       iconData: Icons
                                            //           .receipt_long_rounded,
                                            //       desc: desc[4],
                                            //       pageName: title[4],
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              RaisedButton(
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.receipt_long_rounded,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  // Navigator.of(context).push(
                                                  //   SlideRightRoute(
                                                  //     page: UserGuide(
                                                  //       iconData: Icons
                                                  //           .receipt_long_rounded,
                                                  //       desc: desc[4],
                                                  //       pageName: title[4],
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                              ),
                                              Text(
                                                '''Acknowledgement''',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: whiteColor),
                                              )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.of(context).push(
                                            //   SlideRightRoute(
                                            //     page: UserGuide(
                                            //       iconData: Icons
                                            //           .done_outline_rounded,
                                            //       desc: desc[5],
                                            //       pageName: title[5],
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              RaisedButton(
                                                  shape: CircleBorder(),
                                                  child: Icon(
                                                    Icons.done_outline_rounded,
                                                    size: 30,
                                                  ),
                                                  onPressed: () {
                                                    // Navigator.of(context).push(
                                                    //   SlideRightRoute(
                                                    //     page: UserGuide(
                                                    //       iconData: Icons
                                                    //           .done_outline_rounded,
                                                    //       desc: desc[5],
                                                    //       pageName: title[5],
                                                    //     ),
                                                    //   ),
                                                    // );
                                                  },
                                                  ),
                                              Text(
                                                '''Done''',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: whiteColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     padding: EdgeInsets.only(top: height * 0.8),
                //     child: Scaffold(
                //       backgroundColor: Colors.transparent,
                //       floatingActionButton: FloatingActionButton(
                //         heroTag: "btn2",
                //         elevation: 8,
                //         onPressed: () {},
                //         child: ShaderMask(
                //           shaderonPressed: (Rect bounds) {
                //             return RadialGradient(
                //               center: Alignment.center,
                //               radius: 0.5,
                //               colors: <Color>[
                //                 blueColor,
                //                 blueColor,
                //               ],
                //               tileMode: TileMode.repeated,
                //             ).createShader(bounds);
                //           },
                //           child: Icon(
                //             Icons.home_rounded,
                //             size: 32.0,
                //           ),
                //         ),
                //         backgroundColor: whiteColor,
                //       ),
                //       floatingActionButtonLocation:
                //           FloatingActionButtonLocation.centerDocked,
                //       bottomNavigationBar: FloatingNavbar(
                //         backgroundColor: whiteColor,
                //         selectedBackgroundColor: whiteColor,
                //         selectedItemColor: blueColor,
                //         unselectedItemColor: Colors.grey[600],
                //         items: [
                //           FloatingNavbarItem(
                //             icon: Icons.transfer_within_a_station_rounded,
                //             title: 'Transfer',
                //           ),
                //           FloatingNavbarItem(
                //               icon: Icons.people_outline_rounded,
                //               title: 'Send'),
                //           FloatingNavbarItem(icon: null, title: 'Home'),
                //           FloatingNavbarItem(
                //               icon: Icons.money, title: 'Rewards'),
                //           FloatingNavbarItem(
                //               icon: Icons.settings_rounded, title: 'Settings')
                //         ],
                //         currentIndex: currentIndex,
                //         onTap: (value) {
                //           changePage(value);
                //           if (value == 0) {
                //           } else if (value == 1) {
                //           } else if (value == 2) {
                //           } else if (value == 3) {
                //           } else if (value == 4) {}
                //         },
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
