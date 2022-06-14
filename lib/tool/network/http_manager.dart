
import 'dart:collection';

import 'package:dio/dio.dart';

class HttpManager {

  Dio _dio = Dio();

  HttpManager(){

  }

  Future netFetch(url, params ,Map<String, dynamic>? header, Options? option) async {
    Map<String, dynamic> headers = HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "get");
      option.headers = headers;
    }

    resultError(DioError e) {
      Response? errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = Response(statusCode: 666, requestOptions: RequestOptions(path: url));
      }
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        errorResponse!.statusCode = 1;
      }
      return "";
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return response.data;
  }

}

