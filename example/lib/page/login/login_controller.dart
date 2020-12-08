import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenant_app/config/repository.dart';
import 'package:tenant_app/routers/routes.dart';

class LoginController extends GetxController{
  final RxString phone = "".obs;
  final RxString code = "".obs;

  final RxString selectString = "0".obs;
  final RxInt select = (-1).obs;

  void login (){
    print("object ${phone.value} -  ${code.value}");
    //Get.toNamed(Routes.rMain);
    //Get.offAllNamed(Routes.rLoad);
    /*Repository().login(phone.value, "", code.value).then((value){

    });*/
  }

  void click(){
    select.value++;
    selectString.value = select.value.toString();
  }
}