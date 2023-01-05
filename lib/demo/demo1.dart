import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Demo1Page extends StatefulWidget {
  const Demo1Page({super.key});

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<Demo1Page> {
  bool toggle = true;
  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  _getToggleChild() {
    if (toggle) {
      return Text('小',style: TextStyle(color: Colors.red,fontSize: 40),);
    } else {
      return Text('大',style: TextStyle(color: Colors.green,fontSize: 80));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("控件UI改变"),
      ),
      body: Center(
        child: _getToggleChild(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Update Text',
        child: Icon(Icons.refresh),
      ),
    );
  }
}