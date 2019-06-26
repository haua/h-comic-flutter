import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../config.dart';

class Request {
  static get (
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
      print({
        'msg': '获得数据',
        'type': response.data.runtimeType,
        'response': response
      });
      return response;
    } catch (e) {
      // 网络错误，超时等会到这来
      print({
        'api': api,
        'msg': '失败',
        'response': e
      });
      return null;
    }
  }

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
}