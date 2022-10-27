import 'dart:developer';

import 'package:dio/dio.dart';

class ShopDetails {

  Dio dio = Dio(BaseOptions(
    baseUrl: "https://tolscafetest-api.birdcloud.qa/restaurant/Category/",
    receiveDataWhenStatusError: true,
    followRedirects: false,

    connectTimeout: 60*1000, // 60 seconds
    receiveTimeout: 60*1000,
    validateStatus: (status) {

      return status! < 500;
    },

  ));


  Future<Response> getData(
      {required String url,
        Map<String, dynamic>? query,
        String lang = 'en',
        String? token}) async {
    print('mostafa');
    dio.options.contentType='application/json';
    dio.options.headers = {
      'AccessToken': 'Bearer LQdRkbrtC4S41IecFaF7w3COCZGn9gW3k3vApKlUIHACTgMLZHjjKjy67iIsDOCyUnhCQYDcFQC3X9XB3svVhMz7R4d4LJIAxAWlzQum/2HAVJJyVWdPgzJObQk/nhSe',
      'Content-Type': 'application/json',
      'Cookie': 'ASP.NET_SessionId=yvzkd3hr1efbh5pzrkjdxocy'
    };

    return await dio.get(url, queryParameters: query);
  }

  Future<dynamic> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,


  }) async {


    dio.options.headers = {
      'Content-Type': 'application/json',
    };


    return dio.post(url, data:data,);




  }

}