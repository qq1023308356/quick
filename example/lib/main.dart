import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger_flutter/logger_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quick_layout/quick.dart';
import 'package:tenant_app/routers/routes.dart';
import 'package:tenant_app/view_model/locale_model.dart';
import 'config/repository.dart';
import 'generated/l10n.dart';
import 'package:tenant_app/extensions/extension.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (Platform.isAndroid) {
    //设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  LogConsole.init();
  Repository.updateBaseUrl(Repository.Default);
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Quick.logger.e("exception: ${details.exception}  stack: ${details.stack}");
    }
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp() {
    setDesignWHD(375, 667,density: 1.0);
    QuickConfig.instance.errorTip = (tip){
      EasyLoading.showError(tip);
    };
    QuickConfig.instance.quickStyle = ()=> QuickStyle.dad(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      titleStyle: TextStyle(
        color: Colors.red.auto,
        fontSize: 15.sp,
      ),
      axis: Axis.horizontal,
      detailStyle: TextStyle(
        color: Colors.amber.auto,
        fontSize: 15.sp,
      ),
      hintStyle: TextStyle(
        color: Colors.black26,
        fontSize: 15.sp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetBuilder<LocaleModel>(
          init: LocaleModel(),
          builder: (_){
            return GetMaterialApp(
              initialRoute: Routes.rLoad,
              unknownRoute: GetPage(name: '/notfound', page: () => Center(child: Text("no"))),
              getPages: Routes.getPages,
              debugShowCheckedModeBanner: false,
              locale: _.locale,
              //国际化工厂代理
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                S.delegate
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: ThemeData(primaryColor: Colors.white,
                scaffoldBackgroundColor: Colors.white,
                bottomAppBarColor: Colors.white,
                cardColor: Colors.white,
              ),
              darkTheme: ThemeData(brightness: Brightness.dark,
                primaryColor: Color(0xFF0C0C0C),
                scaffoldBackgroundColor: Color(0xFF0C0C0C),
                bottomAppBarColor: Color(0xFF1C1C1C),
                cardColor: Color(0xFF1C1C1C),
                dividerColor: Color(0xFF383838),
                dialogBackgroundColor: Color(0xFF1C1C1C),
              ),
              builder: (context, child){
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onLongPress: () {
                    Get.toNamed(Routes.rLogConsole);
                  },
                  child: FlutterEasyLoading(child: child),
                );
              },
            );
          }),
    );
  }
}
