import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_layout/quick.dart';
import 'package:tenant_app/config/repository.dart';
import 'package:tenant_app/routers/routes.dart';
import 'dart:ui';
import 'package:tenant_app/extensions/extension.dart';


class MainWidget extends StatelessWidget {
  final count = "123".obs;
  final click = "123".obs;
  int clickCount = 1;
 
  @override
  Widget build(BuildContext context) {
    return QuickInheritedWidget(
      child: QuickScaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: GestureDetector(
            child: Container(alignment: Alignment.center, child: Text("2222"),),
            onTap: () {
              //enabled.toggle();
              Get.toNamed(Routes.rMain);
              //print("111 ${Get.focusScope.nextFocus()}");
              /*Repository().login('17679010359', "123456", "").then((value){
                print("6666666 ${value.toJson()}");
              });*/
              /* Repository().sendVerifyCode('17679010359').then((value){
                print("6666666 $value");
              });*/
              //Get.toNamed(Routes.rMain);
              ///防DDos - 每当用户停止输入1秒时调用，例如。
              //Get.updateLocale(Locale('en', 'US'));
              //Routes.navigateLogConsole(Application.context);
              //Get.find<LocaleModel>().switchLocale(0);
            },
          ),
        ),
        body: ListView(
          children: [
            QuickTile("手机号", detail: "".obs, quickStyle: QuickStyle(
                id: "1",
                quickControlType: QuickControlType.Input,
                quickInputType: QuickInputType.String,
            ),),
            QuickTile("验证码", detail: "".obs, quickStyle: QuickStyle(
                copyId: "1",
                quickInputType: QuickInputType.LetterNumber,
            ),),
            QuickTile("验证码", detail: "".obs, quickStyle: QuickStyle(
                copyId: "1",
                quickInputType: QuickInputType.String,
            ),),
            QuickTile("点击",
                detail: click,
                onTap: () {
                  Repository().login("phone.value", "", "code.value").then((value){

                  });
                  //clickCount++;
                  print("object1111  ${clickCount}");
                },
                quickStyle: QuickStyle(
                  copyId: "1",
                  quickControlType: QuickControlType.Custom,
                ),
                checking: (data) {
                  return clickCount < 3 ? "未选择${clickCount}" : null;
                }),
          ],
        ),
        bottomNavigationBar: QuickChecking(Container(height: 60.h, child: Text("111111")), (){
          Repository().login("phone.value", "", "code.value").then((value){

          });
        }),
      ),
    );
  }
}