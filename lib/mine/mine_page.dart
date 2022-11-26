import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login_page.dart';

class MinePage extends StatefulWidget {
  static const String routeName = "/MinePage";

  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  var leftPadding = 15;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text("我")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 10, color: Colors.grey[200]),
            Container(
              color: Colors.white,
              height: 44,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("账号信息"),
                  Expanded(child: SizedBox()),
                  Text("18500180121"),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Container(height: 0.5, color: Colors.grey[100]),
            GestureDetector(
              onTap: _changePassword,
              child: Container(
                color: Colors.white,
                height: 44,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text("修改密码"),
                    Expanded(child: SizedBox()),
                    Icon(Icons.keyboard_arrow_right),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 20, color: Colors.grey[200]),
            GestureDetector(
              onTap: _setvacation,
              child: Container(
                color: Colors.white,
                height: 44,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text("状态设置"),
                    Expanded(child: SizedBox()),
                    Text("请选择"),
                    Icon(Icons.keyboard_arrow_right),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 20, color: Colors.grey[200]),
            GestureDetector(
              onTap: _about,
              child: Container(
                color: Colors.white,
                height: 44,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text("关于"),
                    Expanded(child: SizedBox()),
                    Icon(Icons.keyboard_arrow_right),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 20, color: Colors.grey[200]),
            Container(
              color: Colors.white,
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _logout,
                    child: Text("退出登录", style: TextStyle(
                          color: Colors.blueAccent, fontSize: 17),)
                  )
                ],
              )
            ),
          ],
        )
    );
  }

  _changePassword(){
    Fluttertoast.showToast(msg: "修改密码");
  }

  _setvacation(){
    Fluttertoast.showToast(msg: "状态设置");
  }

  _about(){
    Fluttertoast.showToast(msg: "关于");
  }

  _logout() async{
    Fluttertoast.showToast(msg: "退出登录");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", false);
    Navigator.of(context).pushNamed(FBLoginPage.routeName);
  }
}
