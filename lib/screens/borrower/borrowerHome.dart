import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    getCode();
    getRates(items[indexTopCount], items[indexBottomCount]);
    currentIndex = 2;
    super.initState();
    _controllerTop = new TextEditingController(text: topCount.toString());
    _controllerBtm = new TextEditingController(text: bottomCount.toString());
  }

  void getCode() {
    countries.forEach((element) {
      element.forEach((key, value) {
        if (key == 'Code') {
          items.add(value);
        }
        if (key == 'Name') {
          name.add(value);
        }
        if (key == 'Country') {
          country.add(value);
        }
      });
    });
  }

  void getRates(String fromCode, String toCode) async {
    try {
      final response = await http
          .get('https://api.exchangeratesapi.io/latest?base=' + fromCode);
      if (response.statusCode == 200) {
        var list = json.decode(response.body) as Map;
        list.forEach((key, value) {
          if (key == 'rates') {
            crossItem.addAll(value);
            crossItem.forEach((key, value) {
              if (key == toCode) {
                setState(() {
                  rate = value;
                  setRates();
                });
              }
            });
          }
        });
      } else {
        print(0);
      }
    } catch (e) {
      _scaffoldKeyHome.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Check Your Internet Connection.',
          style: TextStyle(color: mainBgColor),
        ),
        duration: Duration(seconds: 5),
      ));
    }
  }

  void setRates() {
    setState(
      () {
        if (_selectedLocationTop == '') _selectedLocationTop = items[0];
        if (_selectedLocationBottom == '') _selectedLocationBottom = items[1];
        bottomCount = topCount * rate;
        bottomCount = bottomCount - (bottomCount * (percentCount / 100));
        _controllerTop =
            TextEditingController(text: topCount.toStringAsFixed(2));
        _controllerBtm =
            TextEditingController(text: bottomCount.toStringAsFixed(2));
      },
    );
  }

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
            drawer: AppDrawerHome(imageKey: null),
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
                  ),
                ),
                backgroundColor: mainBgColor,
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
                        color: mainBgColor,
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
                                    color: mainBgColor,
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  Dash(
                                    direction: Axis.vertical,
                                    length: height * 0.15,
                                    dashLength: 15,
                                    dashColor: mainBgColor,
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
                                              color: mainBgColor,
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
                                                        color: mainBgColor,
                                                        decorationColor:
                                                            mainBgColor),
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
                                                                  mainBgColor),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        indexTopCount = items
                                                            .indexOf(value);
                                                        getRates(
                                                            items[
                                                                indexTopCount],
                                                            items[
                                                                indexBottomCount]);
                                                        _selectedLocationTop =
                                                            value;
                                                      });
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
                                                  setState(() {
                                                    topCount =
                                                        double.tryParse(value);
                                                    getRates(
                                                        items[indexTopCount],
                                                        items[
                                                            indexBottomCount]);
                                                    _selectedLocationBottom =
                                                        value;
                                                  });
                                                },
                                                controller: _controllerTop,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.raleway(
                                                  color: mainBgColor,
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
                                                  color: mainBgColor),
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
                                              color: mainBgColor,
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
                                                        color: mainBgColor,
                                                        decorationColor:
                                                            mainBgColor),
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
                                                                  mainBgColor),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        indexBottomCount = items
                                                            .indexOf(value);
                                                        getRates(
                                                            items[
                                                                indexTopCount],
                                                            items[
                                                                indexBottomCount]);
                                                        _selectedLocationBottom =
                                                            value;
                                                      });
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
                                                  setState(() {
                                                    bottomCount =
                                                        double.tryParse(value);
                                                    getRates(
                                                        items[indexTopCount],
                                                        items[
                                                            indexBottomCount]);
                                                  });
                                                },
                                                controller: _controllerBtm,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.raleway(
                                                  color: mainBgColor,
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
                        child: GradientButton(
                          increaseHeightBy: 20,
                          increaseWidthBy: width * 0.58,
                          gradient: gradientBtn,
                          shapeRadius: BorderRadius.circular(5),
                          callback: () {
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
                                color: mainBgColor,
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
                                  dashColor: mainBgColor,
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
                                          Navigator.of(context).push(
                                            SlideRightRoute(
                                              page: UserGuide(
                                                iconData:
                                                    Icons.app_registration,
                                                desc: desc[1],
                                                pageName: title[0],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GradientButton(
                                              shape: CircleBorder(),
                                              child: Icon(
                                                Icons.app_registration,
                                                color: mainBgColor,
                                                size: 30,
                                              ),
                                              callback: () {
                                                Navigator.of(context).push(
                                                  SlideRightRoute(
                                                    page: UserGuide(
                                                      iconData: Icons
                                                          .app_registration,
                                                      desc: desc[1],
                                                      pageName: title[0],
                                                    ),
                                                  ),
                                                );
                                              },
                                              increaseHeightBy: 25,
                                              increaseWidthBy: 25,
                                              gradient: gradientBtn,
                                            ),
                                            Text(
                                              '''Register
For Free''',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: mainBgColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            SlideRightRoute(
                                              page: UserGuide(
                                                iconData: Icons
                                                    .wallet_membership_rounded,
                                                desc: desc[1],
                                                pageName: title[1],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GradientButton(
                                              shape: CircleBorder(),
                                              child: Icon(
                                                Icons.wallet_membership_rounded,
                                                size: 30,
                                              ),
                                              callback: () {
                                                Navigator.of(context).push(
                                                  SlideRightRoute(
                                                    page: UserGuide(
                                                      iconData: Icons
                                                          .wallet_membership_rounded,
                                                      desc: desc[1],
                                                      pageName: title[1],
                                                    ),
                                                  ),
                                                );
                                              },
                                              increaseHeightBy: 25,
                                              increaseWidthBy: 25,
                                              gradient: gradientBtn,
                                            ),
                                            Text(
                                              '''Wallet
Topup''',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: mainBgColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            SlideRightRoute(
                                              page: UserGuide(
                                                iconData:
                                                    Icons.comment_bank_rounded,
                                                desc: desc[2],
                                                pageName: title[2],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GradientButton(
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.comment_bank_rounded,
                                                  size: 30,
                                                ),
                                                callback: () {
                                                  Navigator.of(context).push(
                                                    SlideRightRoute(
                                                      page: UserGuide(
                                                        iconData: Icons
                                                            .comment_bank_rounded,
                                                        desc: desc[2],
                                                        pageName: title[2],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                increaseHeightBy: 25,
                                                increaseWidthBy: 25,
                                                gradient: gradientBtn),
                                            Text(
                                              '''Transfer
Details''',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: mainBgColor),
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
                                      dashColor: mainBgColor,
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
                                            Navigator.of(context).push(
                                              SlideRightRoute(
                                                page: UserGuide(
                                                  iconData: Icons
                                                      .add_business_rounded,
                                                  desc: desc[3],
                                                  pageName: title[3],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GradientButton(
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.add_business_rounded,
                                                  color: mainBgColor,
                                                  size: 30,
                                                ),
                                                callback: () {
                                                  Navigator.of(context).push(
                                                    SlideRightRoute(
                                                      page: UserGuide(
                                                        iconData: Icons
                                                            .add_business_rounded,
                                                        desc: desc[3],
                                                        pageName: title[3],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                increaseHeightBy: 25,
                                                increaseWidthBy: 25,
                                                gradient: gradientBtn,
                                              ),
                                              Text(
                                                '''Add Recipient's
Bank Details''',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: mainBgColor),
                                              )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              SlideRightRoute(
                                                page: UserGuide(
                                                  iconData: Icons
                                                      .receipt_long_rounded,
                                                  desc: desc[4],
                                                  pageName: title[4],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GradientButton(
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.receipt_long_rounded,
                                                  size: 30,
                                                ),
                                                callback: () {
                                                  Navigator.of(context).push(
                                                    SlideRightRoute(
                                                      page: UserGuide(
                                                        iconData: Icons
                                                            .receipt_long_rounded,
                                                        desc: desc[4],
                                                        pageName: title[4],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                increaseHeightBy: 25,
                                                increaseWidthBy: 25,
                                                gradient: gradientBtn,
                                              ),
                                              Text(
                                                '''Acknowledgement''',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: mainBgColor),
                                              )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              SlideRightRoute(
                                                page: UserGuide(
                                                  iconData: Icons
                                                      .done_outline_rounded,
                                                  desc: desc[5],
                                                  pageName: title[5],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GradientButton(
                                                  shape: CircleBorder(),
                                                  child: Icon(
                                                    Icons.done_outline_rounded,
                                                    size: 30,
                                                  ),
                                                  callback: () {
                                                    Navigator.of(context).push(
                                                      SlideRightRoute(
                                                        page: UserGuide(
                                                          iconData: Icons
                                                              .done_outline_rounded,
                                                          desc: desc[5],
                                                          pageName: title[5],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  increaseHeightBy: 25,
                                                  increaseWidthBy: 25,
                                                  gradient: gradientBtn),
                                              Text(
                                                '''Done''',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: mainBgColor),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(top: height * 0.8),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      floatingActionButton: FloatingActionButton(
                        heroTag: "btn2",
                        elevation: 8,
                        onPressed: () {},
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
                            Icons.home_rounded,
                            size: 32.0,
                          ),
                        ),
                        backgroundColor: mainBgColor,
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      bottomNavigationBar: FloatingNavbar(
                        backgroundColor: mainBgColor,
                        selectedBackgroundColor: mainBgColor,
                        selectedItemColor: blueColor,
                        unselectedItemColor: Colors.grey[600],
                        items: [
                          FloatingNavbarItem(
                            icon: Icons.transfer_within_a_station_rounded,
                            title: 'Transfer',
                          ),
                          FloatingNavbarItem(
                              icon: Icons.people_outline_rounded,
                              title: 'Send'),
                          FloatingNavbarItem(icon: null, title: 'Home'),
                          FloatingNavbarItem(
                              icon: Icons.money, title: 'Rewards'),
                          FloatingNavbarItem(
                              icon: Icons.settings_rounded, title: 'Settings')
                        ],
                        currentIndex: currentIndex,
                        onTap: (value) {
                          changePage(value);
                          if (value == 0) {
                          } else if (value == 1) {
                          } else if (value == 2) {
                          } else if (value == 3) {
                          } else if (value == 4) {}
                        },
                      ),
                    ),
                  ),
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
            drawer: AppDrawerHome(imageKey: null),
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
                  ),
                ),
                backgroundColor: mainBgColor,
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
                        color: mainBgColor,
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
                          valueColor:
                              AlwaysStoppedAnimation<Color>(mainBgColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.005),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: GradientButton(
                          increaseHeightBy: 20,
                          increaseWidthBy: width * 0.58,
                          gradient: gradientBtn,
                          shapeRadius: BorderRadius.circular(5),
                          callback: () {
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
                                color: mainBgColor,
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
                                  dashColor: mainBgColor,
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
                                          Navigator.of(context).push(
                                            SlideRightRoute(
                                              page: UserGuide(
                                                iconData:
                                                    Icons.app_registration,
                                                desc: desc[1],
                                                pageName: title[0],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GradientButton(
                                              shape: CircleBorder(),
                                              child: Icon(
                                                Icons.app_registration,
                                                color: mainBgColor,
                                                size: 30,
                                              ),
                                              callback: () {
                                                Navigator.of(context).push(
                                                  SlideRightRoute(
                                                    page: UserGuide(
                                                      iconData: Icons
                                                          .app_registration,
                                                      desc: desc[1],
                                                      pageName: title[0],
                                                    ),
                                                  ),
                                                );
                                              },
                                              increaseHeightBy: 25,
                                              increaseWidthBy: 25,
                                              gradient: gradientBtn,
                                            ),
                                            Text(
                                              '''Register 
For Free''',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: mainBgColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            SlideRightRoute(
                                              page: UserGuide(
                                                iconData: Icons
                                                    .wallet_membership_rounded,
                                                desc: desc[1],
                                                pageName: title[1],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GradientButton(
                                              shape: CircleBorder(),
                                              child: Icon(
                                                Icons.wallet_membership_rounded,
                                                size: 30,
                                              ),
                                              callback: () {
                                                Navigator.of(context).push(
                                                  SlideRightRoute(
                                                    page: UserGuide(
                                                      iconData: Icons
                                                          .wallet_membership_rounded,
                                                      desc: desc[1],
                                                      pageName: title[1],
                                                    ),
                                                  ),
                                                );
                                              },
                                              increaseHeightBy: 25,
                                              increaseWidthBy: 25,
                                              gradient: gradientBtn,
                                            ),
                                            Text(
                                              '''Wallet 
Topup''',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: mainBgColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            SlideRightRoute(
                                              page: UserGuide(
                                                iconData:
                                                    Icons.comment_bank_rounded,
                                                desc: desc[2],
                                                pageName: title[2],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GradientButton(
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.comment_bank_rounded,
                                                  size: 30,
                                                ),
                                                callback: () {
                                                  Navigator.of(context).push(
                                                    SlideRightRoute(
                                                      page: UserGuide(
                                                        iconData: Icons
                                                            .comment_bank_rounded,
                                                        desc: desc[2],
                                                        pageName: title[2],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                increaseHeightBy: 25,
                                                increaseWidthBy: 25,
                                                gradient: gradientBtn),
                                            Text(
                                              '''Transfer 
Details''',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: mainBgColor),
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
                                      dashColor: mainBgColor,
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
                                            Navigator.of(context).push(
                                              SlideRightRoute(
                                                page: UserGuide(
                                                  iconData: Icons
                                                      .add_business_rounded,
                                                  desc: desc[3],
                                                  pageName: title[3],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GradientButton(
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.add_business_rounded,
                                                  color: mainBgColor,
                                                  size: 30,
                                                ),
                                                callback: () {
                                                  Navigator.of(context).push(
                                                    SlideRightRoute(
                                                      page: UserGuide(
                                                        iconData: Icons
                                                            .add_business_rounded,
                                                        desc: desc[3],
                                                        pageName: title[3],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                increaseHeightBy: 25,
                                                increaseWidthBy: 25,
                                                gradient: gradientBtn,
                                              ),
                                              Text(
                                                '''Add Recipient's
Bank Details''',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: mainBgColor),
                                              )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              SlideRightRoute(
                                                page: UserGuide(
                                                  iconData: Icons
                                                      .receipt_long_rounded,
                                                  desc: desc[4],
                                                  pageName: title[4],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GradientButton(
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.receipt_long_rounded,
                                                  size: 30,
                                                ),
                                                callback: () {
                                                  Navigator.of(context).push(
                                                    SlideRightRoute(
                                                      page: UserGuide(
                                                        iconData: Icons
                                                            .receipt_long_rounded,
                                                        desc: desc[4],
                                                        pageName: title[4],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                increaseHeightBy: 25,
                                                increaseWidthBy: 25,
                                                gradient: gradientBtn,
                                              ),
                                              Text(
                                                '''Acknowledgement''',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: mainBgColor),
                                              )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              SlideRightRoute(
                                                page: UserGuide(
                                                  iconData: Icons
                                                      .done_outline_rounded,
                                                  desc: desc[5],
                                                  pageName: title[5],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GradientButton(
                                                  shape: CircleBorder(),
                                                  child: Icon(
                                                    Icons.done_outline_rounded,
                                                    size: 30,
                                                  ),
                                                  callback: () {
                                                    Navigator.of(context).push(
                                                      SlideRightRoute(
                                                        page: UserGuide(
                                                          iconData: Icons
                                                              .done_outline_rounded,
                                                          desc: desc[5],
                                                          pageName: title[5],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  increaseHeightBy: 25,
                                                  increaseWidthBy: 25,
                                                  gradient: gradientBtn),
                                              Text(
                                                '''Done''',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: mainBgColor),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(top: height * 0.8),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      floatingActionButton: FloatingActionButton(
                        heroTag: "btn2",
                        elevation: 8,
                        onPressed: () {},
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
                            Icons.home_rounded,
                            size: 32.0,
                          ),
                        ),
                        backgroundColor: mainBgColor,
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      bottomNavigationBar: FloatingNavbar(
                        backgroundColor: mainBgColor,
                        selectedBackgroundColor: mainBgColor,
                        selectedItemColor: blueColor,
                        unselectedItemColor: Colors.grey[600],
                        items: [
                          FloatingNavbarItem(
                            icon: Icons.transfer_within_a_station_rounded,
                            title: 'Transfer',
                          ),
                          FloatingNavbarItem(
                              icon: Icons.people_outline_rounded,
                              title: 'Send'),
                          FloatingNavbarItem(icon: null, title: 'Home'),
                          FloatingNavbarItem(
                              icon: Icons.money, title: 'Rewards'),
                          FloatingNavbarItem(
                              icon: Icons.settings_rounded, title: 'Settings')
                        ],
                        currentIndex: currentIndex,
                        onTap: (value) {
                          changePage(value);
                          if (value == 0) {
                          } else if (value == 1) {
                          } else if (value == 2) {
                          } else if (value == 3) {
                          } else if (value == 4) {}
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
