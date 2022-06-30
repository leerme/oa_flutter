import 'package:flutter/material.dart';
import 'package:teacher/mine/mine_page.dart';
import '../model/home_model.dart';
import '../model/home_service.dart';
import 'home_app_bar.dart';

class MyHomePage extends StatefulWidget {

  static const String routeName = "/MyHomePage";

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    HomeService().getHttp();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(context),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverSafeArea(
              sliver: SliverPadding(
                  padding: const EdgeInsets.all(15), sliver: buildSliverGrid()))
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  SliverGrid buildSliverGrid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
          childAspectRatio: 2.8),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return buildItemWidget(index);
        },
        childCount: homeModel.length,
      ),
    );
  }

  GestureDetector buildItemWidget(int index) {
    final imageName = homeModel[index][1];
    return GestureDetector(
      child: Container(
        alignment: const Alignment(0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
              child: Image.asset(
                "assets/images/home_page/$imageName.png",
                height: 25,
                width: 25,
              ),
            ),
            Text(homeModel[index][0]),
          ],
        ),
      ),
      onTap: () {
        _handleTap(index);
      },
    );
  }

  _handleTap(index) {
    if (index == 0) {
      Navigator.of(context).pushNamed(MinePage.routeName);
    }
  }
}
