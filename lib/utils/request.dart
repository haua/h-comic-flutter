import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

class Request {
  static get (
      String url,{
        Map<String, dynamic> qs
      }
  ) async {
    try {
      Dio dio = new Dio();
      dio.options.baseUrl = "http://10.0.0.4:7001";
      dio.options.connectTimeout = 5000;
      Response response = await dio.get('/comic/page', queryParameters: qs);
      print({
        'msg': '获得数据',
        'response': response
      });
    } catch (e) {
      print({
        'msg': '失败',
        'response': e
      });
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