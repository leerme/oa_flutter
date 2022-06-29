

import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:lib_network/dio_cache_interceptors.dart';
import 'package:lib_network/dio_interceptors.dart';
import 'package:lib_network/dio_method.dart';
import 'package:lib_network/dio_transformer.dart';
import 'package:path_provider/path_provider.dart';

class DioUtil {
  static const int CONNECT_TIMEOUT = 6*1000;
  static const int RECEIVE_TIMEOUT = 6*1000;
  static String BASE_URL = "http://localhost:8080";
  /// 是否开启网络缓存,默认false
  static bool CACHE_ENABLE = false;
  /// 最大缓存时间(按秒), 默认缓存七天,可自行调节
  static int MAX_CACHE_AGE = 7 * 24 * 60 * 60;
  /// 最大缓存条数(默认一百条)
  static int MAX_CACHE_COUNT = 100;

  static DioUtil? _instance;
  static Dio _dio = Dio();
  Dio get dio => _dio;

  DioUtil._internal() {
    _instance = this;
    _instance!._init();
  }

  factory DioUtil() => _instance ?? DioUtil._internal();

  static DioUtil? getInstance() {
    _instance ?? DioUtil._internal();
    return _instance;
  }

  /// 取消请求token
  CancelToken _cancelToken = CancelToken();

  _init() async {
    /// 初始化基本选项
    BaseOptions options = BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT
    );

    _dio = Dio(options);

    _dio.interceptors.add(DioInterceptors());
    _dio.transformer = DioTransformer();
    _addCookieInterceptors();
    _dio.interceptors.add(DioCacheInterceptors());
  }

  static void _addCookieInterceptors() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dir = '${appDocDir.path}/.cookies/';
    var cookieJar = PersistCookieJar(storage: FileStorage(dir));
    _dio.interceptors.add(CookieManager(cookieJar));
  }

  setProxy({
    String? proxyAddress,
    bool enable = false
  }) {
    if (enable) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.findProxy = (uri) {
          return proxyAddress ?? "";
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  /// 设置https证书校验
  void setHttpsCertificateVerification({
    String? pem,
    bool enable = false
  }) {
    f (enable) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
        client.badCertificateCallback=(X509Certificate cert, String host, int port){
          if(cert.pem==pem){ // 验证证书
            return true;
          }
          return false;
        };
      };
    }
  }

  /// 开启日志打印
  void openLog() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  /// 请求类
  Future<T> request<T>(String path, {
    DioMethod method = DioMethod.get,
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    const _methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head'
    };
    options ??= Options(method: _methodValues[method]);
    try {
      Response response;
      response = await _dio.request(path,
          data: data,
          queryParameters: params,
          cancelToken: cancelToken ?? _cancelToken,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress
      );
      return response.data;
    } on DioError catch (e) {
      throw e;
    }
  }

  /// 取消网络请求
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }
}