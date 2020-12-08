import 'package:flutter/material.dart';

import 'package:flustars/flustars.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:tenant_app/generated/l10n.dart';



class LocaleModel extends GetxController {

  //
  static const kLocaleIndex = 'kLocaleIndex';

  int _localeIndex = 1;

  int get localeIndex => _localeIndex;

  Locale get locale {
    //初始化放在全局， 放在下面会导致每次刷新index 并且导致国际化切换失败
    //_localeIndex = 1;
    if (_localeIndex >= 0) {
      //var value = localeValueList[_localeIndex].split("-");
      return S.delegate.supportedLocales[_localeIndex];
    }
    // 跟随系统
    return  null;
  }

  LocaleModel() {
    _localeIndex = SpUtil.getInt(kLocaleIndex) == 0 ? -1 : SpUtil.getInt(kLocaleIndex);
  }

  switchLocale(int index) {
    _localeIndex = index;
    SpUtil.putInt(kLocaleIndex, index);
    update();
  }

  static String localeName(index, context) {
    switch (index) {
      case 0:
        return 'auto';
      case 1:
        return '简体中文';
      case 2:
        return 'English';
      default:
        return '';
    }
  }
}
