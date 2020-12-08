
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tenant_app/config/application.dart';
import 'package:tenant_app/entity/requestData.dart';
import 'package:tenant_app/generated/l10n.dart';
import 'package:logger/logger.dart';

extension SizeExtension on num {
  num get w => ScreenUtil().getWidth(this.toDouble());

  num get h => ScreenUtil().getHeight(this.toDouble());

  num get sp => ScreenUtil().getSp(this.toDouble());
}

extension ColorExtension on Color {
  Color get auto => Get.isDarkMode ? Color.fromARGB(this.alpha, 255 - this.red, 255 - this.green, 255 - this.blue) : this;
}

extension QuickExtension on _QuickImpl{
  S get s => S.of(Get.context);
  Logger get logger => Application.logger;
}

extension DioExtension on Future<RequestData> {
  Future<R> cache<R>() async {

    //return Future.value(RequestData.generateOBJ(json));
  }

  Future<R> request<R>({bool isDialog = true}) async {
    if(isDialog) EasyLoading.show(status: 'loading...', maskType:EasyLoadingMaskType.clear, dismissOnTap: false);
    await Future.delayed(Duration(seconds: 3));
    Future<R> data;
    await this.then((value){
      if(value.code == 0){
        if(isDialog) EasyLoading.dismiss();
        data = Future.value(value.data as R);
      }else{
        EasyLoading.showError(value.error ?? "");
      }
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          EasyLoading.showError("Got error : ${res?.statusCode ?? ''} -> ${res?.statusMessage ?? ''}");
          Quick.logger.e("Got error : ${res?.statusCode ?? ''} -> ${res?.statusMessage ?? ''}");
          break;
        default:
      }
    });
    if(isDialog) EasyLoading.dismiss();
    return data ?? Future.error('');
  }
}


class _QuickImpl {}
// ignore: non_constant_identifier_names
final Quick = _QuickImpl();

