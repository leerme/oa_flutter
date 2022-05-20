
import 'package:flutter/services.dart';

class NativeMethodChannel{
  //平台通道––––跳转到iOS页面
  static const platform = MethodChannel('inhouse.fenbi.offline.teacher.iOS');

  //跳转到iOS页面
  Future jumpToMineMethod() async {
    final String result = await platform.invokeMethod('jumpToMinePage');
    print('result===');
  }
}