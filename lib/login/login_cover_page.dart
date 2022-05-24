import 'dart:ui';

import 'package:flutter/material.dart';

class LoginCoverPage extends StatefulWidget{
  const LoginCoverPage({Key? key}) : super(key: key);
  @override
  State<LoginCoverPage> createState() => _LoginCoverPageState();
}

class _LoginCoverPageState extends State<LoginCoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
}