import 'package:flutter/material.dart';
import 'package:teacher/demo/demo1.dart';
import 'package:teacher/demo/demo2.dart';
import 'package:teacher/demo/demo3.dart';


class DemoPage extends StatefulWidget {

  static const String routeName = "/DemoPage";

  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  List data = [
    "介绍声明式布局介绍",
    "添加或移除组件",
    "理解Flutter布局约束",
    "widget 做动画",];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        },
      ),
    );
  }

  Widget getRow(int i) {
    return GestureDetector(
      child: ListTile(
          leading: ExcludeSemantics(
            child: CircleAvatar(child: Text('$i')),
          ),
          title: Text(data[i])
      ),
      onTap: () {
        if (i == 0){
//          Navigator.push(context,MaterialPageRoute(builder: (context)=> const Demo0Page()));
        }else if (i == 1){
          Navigator.push(context,MaterialPageRoute(builder: (context)=> const Demo1Page()));
        }else if (i == 2){
          Navigator.push(context,MaterialPageRoute(builder: (context)=> const Demo2Page()));
        }else if (i == 3){
          Navigator.push(context,MaterialPageRoute(builder: (context)=> const Demo3Page(title:"动画")));
        }
      },
    );
  }
}
