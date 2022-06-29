import 'package:dio/dio.dart';

class DioTransformer extends DefaultTransformer {

  @override
  Future<String> transformRequest(RequestOptions options) {
    if (options.data is List<String>){
      throw DioError(requestOptions: options,error: "不能直接发送List数据到服务器");
    } else {
      return super.transformRequest(options);
    }
  }

  @override
  Future transformResponse(RequestOptions options, ResponseBody response) {
    // 例如我们响应选项里面没有自定义某些头部数据,那我们就可以自行添加
    options.extra['myHeader'] = 'abc';
    return super.transformResponse(options, response);
  }
}