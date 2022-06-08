import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录"),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                LYInputWidget(
                  iconData: const Icon(Icons.phone_iphone),
                  hintText: "手机号",
                  controller: userController,
                ),
                const Padding(padding: EdgeInsets.all(10.0)),
                LYInputWidget(
                  iconData: const Icon(Icons.password),
                  hintText: "密码",
                  controller: pwController,
                ),
                const Padding(padding: EdgeInsets.all(10.0)),
                LYInputWidget(
                  iconData: const Icon(Icons.verified),
                  hintText: "验证码",
                  controller: pwController,
                ),
                const Padding(padding: EdgeInsets.all(30.0)),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
                          child: Text("登录",style: TextStyle(fontSize: 18),),
                          onPressed: loginIn,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap:(){

                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("忘记密码?",style: TextStyle(color: Colors.blue),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  loginIn() async {
    print("________");
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}