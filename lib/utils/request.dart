import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../config.dart';
import 'dart:developer' as developer;

// level 参考
// https://github.com/dart-lang/logging/blob/master/lib/logging.dart

class Request {
  /// 直接返回body里的data对象
  static Future get (
      String api,
      {
        Map<String, dynamic> qs
      }
  ) async {
    try {
      Dio dio = new Dio();
      dio.options.baseUrl = appConfig['apiHost'];
      dio.options.connectTimeout = appConfig['request']['connectTimeout'];
      Response response = await dio.get(api, queryParameters: qs);
      Request.log(api, qs, response);

      if(response.data == null || response.data['code'] != 200 ){
        return null;
      }

      return response.data['data'];
    } catch (e) {
      // 网络错误，超时等会到这来
      Request.log(api, qs, null, e);
      return null;
    }
  }

  // 这个方法弃用了
  static hGet (String url) async {
    try {
      HttpClient httpClient = new HttpClient();

      Uri uri = new Uri.http("192.168.137.1:7001", "/comic/page");

      HttpClientRequest request = await httpClient.getUrl(uri);
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();
      httpClient.close();
      print({
        'msg': '获得数据',
        'response': response,
        'responseBody': responseBody
      });
    } catch (e) {
      print({
        'msg': '失败啦',
        'response': e
      });
    }
  }

  static void log (String api, Map<String, dynamic> param, [Response response, error]) {
//    developer.log('[GET ${api} ${error == null ? 'success' : 'fail'}] [param ${param}] ${response}',
//      level: error == null ? 500 : 900,
//      error: error
//    );

    print('[GET ${api} ${error == null ? 'success' : 'fail'}] [param ${param}] response:${response} error:${error}');
  }
}