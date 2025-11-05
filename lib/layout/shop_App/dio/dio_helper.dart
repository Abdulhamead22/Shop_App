import 'package:dio/dio.dart';

class DioHelperShop {
  static late Dio dio;

  static init() {
    //عملتها عشان اول ما يفتح يعرفلي الديو
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ));
  }

  static Future<Response<dynamic>?> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
    'Authorization':token??'',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response<dynamic>?> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization':token??'',
      };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

    static Future<Response<dynamic>?> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization':token??'',
      };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
