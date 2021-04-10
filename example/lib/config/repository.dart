import 'dart:convert';
import 'dart:typed_data';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_app/config/repository_api.dart';
import 'package:tenant_app/entity/UserEntity.dart';
import 'package:tenant_app/extensions/extension.dart';
import 'application.dart';

class Repository {
  Repository._();

  static final _instance = Repository._();

  factory Repository() => _instance;
  static const String DefaultLine = "https://tenant.zxiaowo.com"; //线上
  static const String DefaultTest = "https://test-tenant.zxiaowo.com"; //测试
  static const String DefaultResearch = "https://yf-tenant.zxiaowo.com"; //研发
  static const String Default = "https://yf-rent.zxiaowo.com"; //研发

  static final Dio _dio =
      Dio(); //..interceptors.add(LogInterceptor(requestBody: true));

  static void updateBaseUrl(String baseUrl) {
    BaseOptions b = _dio.options;
    b.baseUrl = baseUrl;
    b.receiveTimeout = 25000;
    _dio.options = b;
    //_dio.interceptors.add(LogInterceptor(responseBody: true)); //开启请求日志
    _dio.interceptors.add(MyLogInterceptor());
  }

  static void setRequestToken(String token) {
    BaseOptions b = _dio.options;
    b.headers["token"] = token;
    _dio.options = b;
  }

  final _resourceApi = ResourceApi(_dio);

  Future<String> sendVerifyCode(String phone) async {
    return _resourceApi
        .sendVerifyCode(map: {"mobile": phone, "userType": 2}).request();
  }

  Future<UserEntity> login(String phone, String password, String code) async {
    return _resourceApi.login(map: {
      "userName": phone,
      "userType": 1,
      "clientId": "621758a09842b2cb70b3b649a5d83fce",
      "deviceId": "621758a09842b2cb70b3b649a5d83fce",
      "password": EncryptUtil.encodeMd5(password),
      "code": code,
    }).request();
  }
}

class MyLogInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    Application.logger.d(
        "\n================================= 请求数据 =================================");
    Application.logger.d(
        "method = ${options.method.toString()}  url = ${options.uri.toString()}");
    Application.logger.d("headers = ${options.headers}");
    Application.logger.d("params = ${options.queryParameters}");
    Application.logger.d("data = ${options.data}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    Application.logger.d(
        "\n================================= 响应数据开始 =================================");
    Application.logger.d("code = ${response.statusCode}");
    Application.logger.d("data = ${response.data}");
    Application.logger.d(
        "================================= 响应数据结束 =================================\n");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    Application.logger.e(
        "\n=================================错误响应数据 =================================");
    Application.logger.e("type = ${err.type}");
    Application.logger.e("message = ${err.message}");
    Application.logger.e("\n");
    return super.onError(err);
  }
}
