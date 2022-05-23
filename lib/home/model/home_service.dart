import 'package:dio/dio.dart';

class HomeService{
  void getHttp() async {
    try {
      var response = await Dio().get('http://keapi.fenbi.com/apps-server/iphone/oa/notices/un_read_count?system=15.0&inhouse=1&app=oa&ua=iPhone&av=3&version=1.5.3&kav=3&location=1');
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
