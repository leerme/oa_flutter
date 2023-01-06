import 'package:flutter/material.dart';

const white = Colors.white;
const red = Colors.red;
const green = Colors.green;
const blue = Colors.blue;
const big = TextStyle(fontSize: 30);

//////////////////////////////////////////////////
class Demo2Page extends StatelessWidget {
  const Demo2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("常见的布局Widget"),
      ),
      body: FlutterLayoutArticle([
        Example1(),
        Example2(),
        Example3(),
        Example4(),
        Example5(),
        Example6(),
      ]),
    );
  }
}

//////////////////////////////////////////////////

abstract class Example extends StatelessWidget {
  const Example({super.key});

  String get code;

  String get explanation;
}

//////////////////////////////////////////////////

class FlutterLayoutArticle extends StatefulWidget {
  const FlutterLayoutArticle(
  this.examples, {
  super.key,
  });

  final List<Example> examples;

  @override
  State<FlutterLayoutArticle> createState() => _FlutterLayoutArticleState();
}

//////////////////////////////////////////////////

class _FlutterLayoutArticleState extends State<FlutterLayoutArticle> {
  late int count;
  late Widget example;
  late String code;
  late String explanation;

  @override
  void initState() {
    count = 1;
    code = const Example1().code;
    explanation = const Example1().explanation;

    super.initState();
  }

  @override
  void didUpdateWidget(FlutterLayoutArticle oldWidget) {
    super.didUpdateWidget(oldWidget);
    var example = widget.examples[count - 1];
    code = example.code;
    explanation = example.explanation;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Layout Article',
      home: SafeArea(
        child: Material(
          color: Colors.black,
          child: FittedBox(
            child: Container(
              width: 400,
              height: 670,
              color: const Color(0xFFCCCCCC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                              width: double.infinity, height: double.infinity),
                          child: widget.examples[count - 1])),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.black,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < widget.examples.length; i++)
                            Container(
                              width: 58,
                              padding:
                              const EdgeInsets.only(left: 4.0, right: 4.0),
                              child: button(i + 1),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 273,
                    color: Colors.grey[50],
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        key: ValueKey(count),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Center(child: Text(code,style: TextStyle(fontSize: 20,color: blue),),),
                              const SizedBox(height: 15),
                              Text(
                                explanation,
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget button(int exampleNumber) {
    return Button(
      key: ValueKey('button$exampleNumber'),
      isSelected: count == exampleNumber,
      exampleNumber: exampleNumber,
      onPressed: () {
        showExample(
          exampleNumber,
          widget.examples[exampleNumber - 1].code,
          widget.examples[exampleNumber - 1].explanation,
        );
      },
    );
  }

  void showExample(int exampleNumber, String code, String explanation) {
    setState(() {
      count = exampleNumber;
      this.code = code;
      this.explanation = explanation;
    });
  }
}

//////////////////////////////////////////////////

class Button extends StatelessWidget {
  final bool isSelected;
  final int exampleNumber;
  final VoidCallback onPressed;

  const Button({
  super.key,
  required this.isSelected,
  required this.exampleNumber,
  required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: isSelected ? Colors.grey : Colors.grey[800],
      ),
      child: Text(exampleNumber.toString()),
      onPressed: () {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          alignment: 0.5,
        );
        onPressed();
      },
    );
  }
}
//////////////////////////////////////////////////

class Example1 extends Example {
  const Example1({super.key});
  @override
  final code = 'Text("Hello World")';
  @override
  final explanation = '';
  @override
  Widget build(BuildContext context) {
    return Container(color: white,child: Text('Hello World'),alignment:Alignment.center);
  }
}

//////////////////////////////////////////////////

class Example2 extends Example {
  const Example2({super.key});
  @override
  final code = 'Image.asset(images/lake.jpg, fit: BoxFit.contain,)';
  @override
  final String explanation = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Image.asset(
        'assets/images/home_page/calendar.png',
        fit: BoxFit.contain,
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example3 extends Example {
  const Example3({super.key});

  @override
  final code = '横向布局多个 widgets';
  @override
  final String explanation =
      'Column('
  'mainAxisAlignment: MainAxisAlignment.spaceEvenly,'
  'children: ['
  'Image.asset("),'
  'Image.asset("),'
  'Image.asset("),'
  '],'
  ')';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/home_page/calendar.png'),
            Image.asset('assets/images/home_page/salary.png'),
            Image.asset('assets/images/home_page/offline.png'),
            Image.asset('assets/images/home_page/arrange.png'),
            Image.asset('assets/images/home_page/one2one.png'),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example4 extends Example {
  const Example4({super.key});
  @override
  final code = '纵向布局多个 widgets';
  @override
  final String explanation =
      '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/home_page/calendar.png'),
            Image.asset('assets/images/home_page/salary.png'),
            Image.asset('assets/images/home_page/offline.png'),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example5 extends Example {
  const Example5({super.key});

  @override
  final code = '';
  @override
  final String explanation = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Image.asset('assets/images/home_page/calendar.png'),
            Image.asset('assets/images/home_page/salary.png'),
            Image.asset('assets/images/home_page/offline.png'),
            Image.asset('assets/images/home_page/arrange.png'),
            Image.asset('assets/images/home_page/one2one.png'),

//            Expanded(child:Image.asset('assets/images/home_page/calendar.png'),flex: 1),
//            Expanded(child: Image.asset('assets/images/home_page/salary.png'),flex: 2),
//            Expanded(child: Image.asset('assets/images/home_page/offline.png'), flex: 3),
//            Expanded(child: Image.asset('assets/images/home_page/arrange.png'),flex: 4),
//            Expanded(child: Image.asset('assets/images/home_page/one2one.png'),flex: 5),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example6 extends Example {
  const Example6({super.key});

  @override
  final code = '手势';
  @override
  final String explanation = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          print('onTap');
        },
        onLongPress: (){
          print('onLongPress');
        },
        child: Container(
          height: 50.0,
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.red,
          ),
          child: const Center(
            child: Text('手势'),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////