import 'package:crowdgain/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserGuide extends StatefulWidget {
  UserGuide(
      {@required this.desc, @required this.pageName, @required this.iconData});
  final String pageName;
  final String desc;
  final IconData iconData;

  @override
  _UserGuideState createState() => _UserGuideState();
}

class _UserGuideState extends State<UserGuide> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    ScreenUtil.init(context,
        designSize: Size(1080, 2400), allowFontScaling: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: blueColor,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(110),
                  top: ScreenUtil().setHeight(100),
                ),
                child: Dash(
                  direction: Axis.vertical,
                  length: ScreenUtil().setHeight(1600),
                  dashLength: 12,
                  dashColor: whiteColor,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startTop,
              floatingActionButton: Padding(
                padding: EdgeInsets.only(top: 25, right: 25.0),
                child: FloatingActionButton(
                  heroTag: "btn1",
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
                      widget.iconData,
                      size: 32.0,
                    ),
                  ),
                  backgroundColor: whiteColor,
                ),
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 65,
                      top: ScreenUtil().setHeight(300),
                    ),
                    child: Text(
                      widget.pageName,
                      style: GoogleFonts.roboto(
                        color: whiteColor,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 65,
                      top: 25,
                    ),
                    child: Text(
                      widget.desc,
                      style: GoogleFonts.raleway(
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
