import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_layout/quick.dart';
import 'package:tenant_app/config/often.dart';
import 'package:tenant_app/config/resource.dart';
import 'dart:ui';
import 'package:tenant_app/extensions/extension.dart';
import 'package:tenant_app/page/login/login_controller.dart';

class LoginWidget extends GetView<LoginController> {
  LoginWidget() {
    Get.lazyPut(() => LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return QuickInheritedWidget(
      child: QuickScaffold(
        appBar: QuickAppBarPreferredSize(
          child: Container(
            width: double.infinity,
            height: 198.h,
            child: Stack(children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                width: 164.w,
                height: 198.h,
                child: Image.asset(
                  ResIcon.loginBackground,
                ),
              ),
              Positioned(
                left: 112.w,
                bottom: 15.h,
                width: 152.w,
                height: 47.h,
                child: GestureDetector(
                  child: Image.asset(
                    ResIcon.loginLogo,
                  ),
                  onTap: () {},
                ),
              )
            ]),
          ),
          height: 198.h,
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 28.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100.h),
                  QuickTile(
                    "",
                    detail: controller.phone,
                    hint: "请输入手机号",
                    quickStyle: QuickStyle(
                      id: "1",
                      startWidget: startWidget(ResIcon.loginPhone),
                      quickInputType: QuickInputType.Int,
                      maxLength: 11,
                      textAlign: TextAlign.start,
                      quickControlType: QuickControlType.Input,
                      decoration: Often.decoration,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  QuickTile(
                    "",
                    detail: controller.code,
                    hint: "请输入验证码",
                    quickStyle: QuickStyle(
                      copyId: "1",
                      startWidget: startWidget(ResIcon.loginPassword),
                      maxLength: 6,
                    ),
                  ),
                  QuickTile("点击",
                      data: controller.select,
                      onTap: ()=> controller.click(),
                      quickStyle: QuickStyle(
                        copyId: "1",
                        quickControlType: QuickControlType.Custom,
                        detailWidget: QuickText(controller.selectString),
                      ),
                      checking: (data) {
                        print("object000 ${data.value}");
                        return data.value < 0 ? "未选择" : null;
                      }),
                  SizedBox(height: 100.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "登录/注册",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: 18.w),
                      QuickChecking(
                        Container(
                          width: 59.w,
                          height: 34.h,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.5.sp)),
                            gradient: LinearGradient(colors: [
                              Color(true ? 0xFF5CDCB8 : 0xFFCECECE),
                              Color(true ? 0xFF3BB491 : 0xFFCECECE)
                            ]),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.arrow_forward,
                            size: 25.w,
                            color: Colors.white,
                          )),
                        ),
                        ()=> controller.login(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget startWidget(String scr) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Image.asset(
        scr,
        width: 28.w,
      ),
    );
  }
}
