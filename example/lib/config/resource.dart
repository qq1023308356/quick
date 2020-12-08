import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';

class ResColor {
  static const colorPrimaryLight = const Color(0xFF7CBE51);
  static const colorPrimary = const Color(0xFF67B75D);
  static const fontBlack = const Color(0xFF333333);
  static const fontHintGrey = const Color(0xFFC7C7C7);
  static const fontGreen = const Color(0xFF29A11B);
  static const bgLoginInputText = const Color(0xFFF7F7F7);
  static const bgGrey = const Color(0xFFF7F7F7);
  static const BottomNavSelectedItemColor = colorPrimary;
  static const BottomNavUnselectedItemColor = const Color(0xFFBCBCBC);
  static const greyDividerLine = const Color(0xFFE8E8E8);
  static const appBarTitleColor = const Color(0xFF030303);
}

class ResFontWeight {
  static const FontWeightThin = FontWeight.w100;
  static const FontWeightExtraLight = FontWeight.w200;
  static const FontWeightLight = FontWeight.w300;
  static const FontWeightRegular = FontWeight.w400;
  static const FontWeightMedium = FontWeight.w500;
  static const FontWeightSemiBold = FontWeight.w600;
  static const FontWeightBold = FontWeight.w700;
  static const FontWeightExtraBold = FontWeight.w800;
  static const FontWeightBlack = FontWeight.w900;
  static const FontWeightHeavy = FontWeight.w900;
}

class ResSize {
  static final double toolbarHeight = ScreenUtil().getHeight(204);
  static final double fontBaseUserWorkValue = ScreenUtil().getSp(46);
  static final double fontBaseUserWorkKey = ScreenUtil().getSp(40);
  static final double bottomNavIconSize = ScreenUtil().getWidth(72);
  static final double iconNextLevelSize = ScreenUtil().getWidth(48);
  static final double radius20 = ScreenUtil().getWidth(20);
  static final double radius40 = ScreenUtil().getWidth(40);
  static final Radius radiusCursor = const Radius.circular(2.0);
  static final double appBarTitleSize = ScreenUtil().getSp(17);
}

class ResStyle {
  static final TextStyle baseStyle = TextStyle();
  static final TextStyle appBarTitleStyle = baseStyle.copyWith(fontSize: ResSize.appBarTitleSize, fontWeight: ResFontWeight.FontWeightMedium);
}

class ResIcon {
  static const _basePath= "images/";
  static const _LoginPath= "login/";

  //login
  static const loginBackground = "$_basePath${_LoginPath}background.png";
  static const loginLogo = "$_basePath${_LoginPath}logo.png";
  static const loginPhone = "$_basePath${_LoginPath}phone.png";
  static const loginPassword = "$_basePath${_LoginPath}password.png";
}
