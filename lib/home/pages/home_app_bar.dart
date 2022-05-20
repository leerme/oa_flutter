import 'package:flutter/material.dart';

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
        NativeMethodChannel().jumpToMineMethod();
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

          })
    ],
  );
}
