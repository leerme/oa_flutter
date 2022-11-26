import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lib_network/dio_response.dart';
import 'package:lib_network/dio_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher/home/pages/home_page.dart';
import 'package:teacher/login/login_cover_page.dart';
import 'package:teacher/tool/encrypt/encrypt.dart';

import '../widget/ly_input_widget.dart';

class FBLoginPage extends StatefulWidget {
  static const String routeName = "/FBLoginPage";

  const FBLoginPage({Key? key}) : super(key: key);

  @override
  State<FBLoginPage> createState() => _FBLoginPageState();
}

class _FBLoginPageState extends State<FBLoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController verifiedController = TextEditingController();

  String _userPhone = "";
  String _password = "";
  String _verifiedCode = "";
  Timer? _timer;
  int _seconds = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pushNamed(LoginCoverPage.routeName);
              },
            );
          },
        ),
//        actions: <Widget>[
//          IconButton(
//            icon: const Icon(Icons.menu),
//            onPressed: () {},
//          ),
//        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    LYInputWidget(
                      iconData: const Icon(Icons.phone_iphone),
                      hintText: "手机号",
                      controller: userController,
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        setState(() {
                          _userPhone = value.trim();
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    LYInputWidget(
                      iconData: const Icon(Icons.password),
                      hintText: "密码",
                      controller: pwController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (String value) {
                        _password = value.trim();
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    Stack(
                      children: [
                        LYInputWidget(
                          iconData: const Icon(Icons.verified),
                          hintText: "验证码",
                          controller: verifiedController,
                          keyboardType: TextInputType.number,
                          onChanged: (String value) {
                            _verifiedCode = value.trim();
                          },
                        ),
                        Positioned(
                          right: 0,
                          bottom: 5,
                          top: 5,
                          child: buildSendVerifiedButton(),
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(30.0)),
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(100, 50)),
                              child: Text(
                                "登录",
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: _loginIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "忘记密码?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildSendVerifiedButton() {
    var text = "获取验证码";
    VoidCallback? onPressed =
        (_userPhone.isNotEmpty) ? _sendVerifiedCode : null;
    if (_seconds == 0) {
      text = "重新获取";
    } else if (_seconds > 0) {
      text = "等待" + _seconds.toString() + "s";
      onPressed = null;
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
      child: Text(
        text,
        style: TextStyle(fontSize: 14),
      ),
      onPressed: onPressed,
    );
  }

  _loginIn() async {
    if (_userPhone.isEmpty) {
      Fluttertoast.showToast(
        msg: "请输入手机号",
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    if (_password.isEmpty) {
      Fluttertoast.showToast(
        msg: "请输入密码",
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    if (_verifiedCode.isEmpty) {
      Fluttertoast.showToast(
        msg: "请输入验证码",
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());

    Future info = Encrypt.encryption(_password);
    info.then((value) {
      var url =
          "https://login.fenbi.com/employee/public/login?system=13.3&inhouse=1&app=oa&ua=iPhone&av=3&version=1.5.3&kav=3";
      _requestLogin(url, value);
    });
  }

  _requestLogin(url, value) async {
    Options options = Options(
        headers: {Headers.contentTypeHeader: Headers.formUrlEncodedContentType},
        method: "post");
    Map<String, dynamic> map = Map();
    map['password'] = value;
    map['phone'] = _userPhone;
    map['verifycode'] = _verifiedCode;
    DioResponse result =
        await DioUtil().request(url, data: map, options: options);
    print(result);
    if (result.code == DioResponseCode.SUCCESS) {
      _handleLoginSuccess(result.data);
      Navigator.of(context).pushNamed(MyHomePage.routeName);
    } else {
      Fluttertoast.showToast(msg: "登录失败", gravity: ToastGravity.CENTER);
    }
  }

  _sendVerifiedCode() {
    int date = DateTime.now().millisecondsSinceEpoch;
    String phone = "$_userPhone:" + "$date";
    Future info = Encrypt.encryption(phone);
    info.then((value) {
      var url =
          "http://login.fenbi.com/iphone/users/phone/verification?system=13.3&inhouse=1&app=oa&ua=iPhone&av=3&version=1.5.3&kav=3";
      _requestVerifiedCode(url, value);
    });
  }

  _requestVerifiedCode(url, value) async {
    Options options = Options(
        headers: {Headers.contentTypeHeader: Headers.formUrlEncodedContentType},
        method: "post");
    Map<String, dynamic> map = Map();
    map['info'] = value;
    map['type'] = "retrieve";
    DioResponse result =
        await DioUtil().request(url, data: map, options: options);
    if (result.code == DioResponseCode.SUCCESS) {
      var now = DateTime.now();
      var minutes = now.add(const Duration(minutes: 1)).difference(now);
      _seconds = minutes.inSeconds;
      startTimer();
    } else {
      Fluttertoast.showToast(msg: "获取验证码失败", gravity: ToastGravity.CENTER);
    }
  }

  _handleLoginSuccess(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", true);
//    String url = 'http://tiku.fenbi.com/api/xingce/users/$userId?system=15.0&inhouse=1&app=oa&ua=iPhone&av=3&version=1.5.3&kav=3';
  }

  void startTimer() {
    //设置 1 秒回调一次
    const period = Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      //更新界面
      setState(() {
        //秒数减一，因为一秒回调一次
        _seconds--;
      });
      if (_seconds == 0) {
        //倒计时秒数为0，取消定时器
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }
}
