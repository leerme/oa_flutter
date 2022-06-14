import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teacher/tool/encrypt/encrypt.dart';
import 'package:teacher/tool/network/http_manager.dart';
import '../widget/ly_input_widget.dart';

class FBLoginPage extends StatefulWidget{
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录"),
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
                          _userPhone = value;
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
                        _password = value;
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
                            _verifiedCode = value;
                          },
                        ),
                        Positioned(
                          right: 0,
                          bottom: 5,
                          top: 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 50)),
                            child: Text(
                              "获取验证码", style: TextStyle(fontSize: 14),),
                            onPressed: (_userPhone.isNotEmpty)
                                ? _sendVerifiedCode
                                : null,
                          ),
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
                                "登录", style: TextStyle(fontSize: 18),),
                              onPressed: _loginIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "忘记密码?", style: TextStyle(color: Colors.blue),),
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

  _sendVerifiedCode() {

  }

  _loginIn() async {
//    if (_userPhone.isEmpty){
//      Fluttertoast.showToast(
//          msg: "请输入手机号",
//          gravity: ToastGravity.CENTER,
//      );
//      return;
//    }
//    if (_password.isEmpty){
//      Fluttertoast.showToast(
//        msg: "请输入密码",
//        gravity: ToastGravity.CENTER,
//      );
//      return;
//    }
//    if (_verifiedCode.isEmpty){
//      Fluttertoast.showToast(
//        msg: "请输入验证码",
//        gravity: ToastGravity.CENTER,
//      );
//      return;
//    }
    int date = DateTime.now().millisecondsSinceEpoch;
    String phone = "$_userPhone:"+"$date";
    Future info = Encrypt.encryption(phone);
    info.then((value) {
      var url = "http://tiku.fenbi.com/iphone/users/phone/verification?system=13.3&inhouse=1&app=oa&ua=iPhone&av=3&version=1.5.3&kav=3";
//      HttpManager().netFetch(url, {"info":value,"type":"retrieve"}, null, null).then((value) {
//
//      });
    test(url,value);
    });


//    Dio dio = Dio();
//    Response response=await dio.post(path)
//    print("__$response.data");

//
//    info:""
//    type:retrieve
  }

  test (url,value) async {
//      HttpManager().netFetch(url, {"info":value,"type":"retrieve"}, null, null).then((value) {
//
//      });
//    Map p = {"info":value,"type":"retrieve"};

    Options options = Options(headers: {
      Headers.contentTypeHeader:
      Headers.formUrlEncodedContentType
    });
    Map<String,dynamic> map = Map();
    map['info']=value;
    map['type']="retrieve";
    FormData formData = FormData.fromMap(map);
    Dio dio = Dio();
    Response response = await dio.post(url,data:map,options: options);
    print(response.data);
  }
}