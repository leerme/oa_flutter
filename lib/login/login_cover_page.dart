import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teacher/login/login_page.dart';

class LoginCoverPage extends StatefulWidget{
  static const String routeName = "/LoginCoverPage";

  const LoginCoverPage({Key? key}) : super(key: key);
  @override
  State<LoginCoverPage> createState() => _LoginCoverPageState();
}

class _LoginCoverPageState extends State<LoginCoverPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Image.asset(
                  "assets/images/login_cover/fb_logo.png",
                  width: 165,
                  height: 50,
                )
            ),
            GestureDetector(
              onTap: () => _jumpToLoginPage(context),
              child: Image.asset(
                "assets/images/login_cover/login_cloud.png",
                width: 121,
                height: 90,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 50,),
                Image.asset(
                  "assets/images/login_cover/bottom_right_cloud.png",
                  width: 75,
                  height: 56,
                ),
              ],
            ),
            SizedBox(height: 30,),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  alignment: AlignmentDirectional.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/login_cover/small_cloud.png",
                        width: 48,
                        height: 35,
                      ),
                      SizedBox(width: 30,)
                    ],
                  ),
                  height: 105,
                ),
                Image.asset(
                  "assets/images/login_cover/bottom_cloud.png",
                  width: window.physicalSize.width,
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue,
    );
  }

  void _jumpToLoginPage(BuildContext context) {
    Navigator.of(context).pushNamed(FBLoginPage.routeName);
  }
}