import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_network/dio_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher/tool/router/router.dart';
import 'home/pages/home_page.dart';
import 'login/login_cover_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loginState = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DioUtil();
    _validateLogin();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '教务系统',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginState?const MyHomePage():const LoginCoverPage(),
//      home:const LoginCoverPage(),
      routes: FBRouter.routers,
      onGenerateRoute: FBRouter.generateRoute,
      onUnknownRoute: FBRouter.unKnownRoute,
    );
  }

  Future _validateLogin() async{
    Future<dynamic> future = Future(()async{
      SharedPreferences prefs =await SharedPreferences.getInstance();
      return prefs.getBool("login");
    });
    future.then((val){
      setState(() {
        loginState = val;
      });
    }).catchError((_){
      print("catchError");
    });
  }
}
