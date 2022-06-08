import 'package:flutter/material.dart';
import 'home/pages/home_page.dart';
import 'login/login_cover_page.dart';
import 'router/router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '教务系统',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginCoverPage(),
      routes: FBRouter.routers,
      onGenerateRoute: FBRouter.generateRoute,
      onUnknownRoute: FBRouter.unKnownRoute,
    );
  }
}
