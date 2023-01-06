import 'package:flutter/material.dart';
import 'package:teacher/home/model/home_service.dart';
import 'package:teacher/mine/mine_page.dart';
import 'home_native_method_channel.dart';

class HomeAppBar extends AppBar {
  HomeAppBar(BuildContext context) : super(
    title: const Text("教务系统"),
    leading: IconButton(
      icon: Image.asset(
        "assets/images/bar/mine.png",
        height: 19,
        width: 19,
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(MinePage.routeName);
      },
    ),
    actions: [
      IconButton(
          icon: Image.asset(
            "assets/images/bar/icon-messgae.png",
            height: 50,
            width: 50,
          ),
          onPressed: () {
//            HomeService().getHttp();
            NativeMethodChannel().jumpToMineMethod();
          })
    ],
  );
}
