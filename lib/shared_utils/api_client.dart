import 'dart:developer';

import 'package:bluegeneration/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient with DioMixin implements Dio {

  ApiClient._internal() {
    _init();
  }

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  ApiClient _init() {
    httpClientAdapter = HttpClientAdapter();

    options = BaseOptions(
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      baseUrl: BASEURL,
      headers: {},
      validateStatus: (status) => true,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );

    interceptors.addAll([
      LogInterceptor(
        responseBody: true,
        requestHeader: true,
        requestBody: true,
        logPrint: (object) {
          if (kDebugMode) {
            log(object.toString());
          }
        },
      ),
    ]);

    return this;
  }
}
