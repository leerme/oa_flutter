import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: '教务系统'),
    );
  }
}

final titleModel = [
  "课时日历",
  "工资条",
  "线下业务",
  "系统排课",
  "待批作业",
  "名师点评",
  "1对1课程",
  "1对1系统课",
  "精品系统班",
  "精品模考诊断",
  "精品自习室",
  "精品专项突破",
  "精品人工批改",
  "班群聊天",
  "工作查询",
  "精品班签到",
];

final imageNameModel = [
  "calendar",
  "salary",
  "offline",
  "arrange",
  "icon_homework",
  "teacher-review",
  "one2one",
  "1v1-icon-system",
  "jp-system",
  "jp-mokaozhenduan",
  "jp-room",
  "jp-chapter",
  "jp-rengong",
  "chat-home",
  "queryWork",
  "prime-sign",
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("教务系统"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverSafeArea(
              sliver: SliverPadding(
                  padding: EdgeInsets.all(15), sliver: buildSliverGrid()))
        ],
      ),
      backgroundColor: Colors.grey[200],

    );
  }

  SliverGrid buildSliverGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 10,childAspectRatio: 2.8),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final imageName = imageNameModel[index];
          return Container(
            alignment: Alignment(0, 0),
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
                Text(titleModel[index]),
              ],
            ),
          );
        },
        childCount: titleModel.length,
      ),
    );
  }
}
