import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeUtil {
  factory ThemeUtil() =>  _getInstance();
  static ThemeUtil _instance;
  static ThemeUtil get instance => _getInstance();
  BuildContext baseContext;

  ThemeUtil._();

  static ThemeUtil _getInstance() {
    if (_instance == null) {
      _instance = ThemeUtil();
    }
    return _instance;
  }

  void init(BuildContext context){
    baseContext = context;
  }

  TextTheme getTextTheme(){
    return Theme.of(baseContext).textTheme;
  }
}