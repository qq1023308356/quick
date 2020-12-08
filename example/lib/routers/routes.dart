import 'package:get/get.dart';
import 'package:logger_flutter/logger_flutter.dart';
import 'package:tenant_app/page/home/main.dart';
import 'package:tenant_app/page/login/login.dart';

class Routes {
  static const rLoad = "/";
  static const rMain = "/main/";
  static const rLogConsole = "/logConsole/";
  static const rActorList = "/actorList/";
  static const rVideoList = "/videoList/";
  static const rVideoInfo = "/videoInfo/";
  static const rCollect = "/collect/";
  static const rSetting = "/setting/";
  static const rMagic = "/magic/";

  static List<GetPage> getPages = [
    GetPage(name: rLoad, page: () => LoginWidget(),),
    GetPage(name: rLogConsole, page: () => LogConsole(), transition: Transition.native),
    GetPage(name: rMain, page: () => MainWidget(), transition: Transition.zoom),
  ];
}