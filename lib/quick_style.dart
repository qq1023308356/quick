import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quick.dart';

class QuickStyle {
  final String id;
  final String copyId;
  final TextStyle titleStyle;
  final TextStyle detailStyle;
  final TextAlign textAlign;
  final TextStyle hintStyle;
  final int maxLength;
  final int maxLines;
  final bool enabled;
  final Widget startWidget;
  final Widget endWidget;
  final Widget titleWidget;
  final Widget detailWidget;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double width;
  final double height;
  final bool isCard;
  final bool isDivider;
  final double dividerPadding;
  final Color dividerColor;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color background;
  final Decoration decoration;
  final int titleFlex;
  final int detailFlex;
  final Axis axis;
  final double titleToDetailSpacing;
  final QuickControlType quickControlType;
  final QuickInputType quickInputType;
  final bool obscureText;
  final bool isOpen;
  final bool isEdit;
  final bool isHide;
  final bool isSlide;
  final List<Widget> slideList;
  final Function(int) onSlideTap;
  final int inputScale;
  final ValueChanged<String> onSubmitted;
  final TextInputAction textInputAction;

  const QuickStyle.dad({
    this.id,
    this.copyId,
    this.titleStyle,
    this.detailStyle,
    this.textAlign = TextAlign.end,
    this.hintStyle,
    this.maxLength,
    this.enabled,
    this.maxLines = 1,
    this.startWidget,
    this.endWidget,
    this.titleWidget,
    this.detailWidget,
    this.axis,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.width,
    this.height = 50,
    this.isCard = false,
    this.isDivider = false,
    this.constraints,
    this.margin,
    this.padding,
    this.background,
    this.decoration,
    this.titleFlex,
    this.detailFlex,
    this.titleToDetailSpacing = 5,
    this.quickControlType = QuickControlType.Text,
    this.quickInputType = QuickInputType.String,
    this.obscureText = false,
    this.isOpen = false,
    this.isEdit = true,
    this.isSlide = false,
    this.slideList,
    this.onSlideTap,
    this.isHide = false,
    this.dividerPadding = 0,
    this.dividerColor,
    this.inputScale = 2,
    this.onSubmitted,
    this.textInputAction = TextInputAction.next,
  });

  const QuickStyle({
    this.id,
    this.copyId,
    this.titleStyle,
    this.detailStyle,
    this.textAlign,
    this.hintStyle,
    this.maxLength,
    this.maxLines,
    this.enabled,
    this.startWidget,
    this.endWidget,
    this.titleWidget,
    this.detailWidget,
    this.axis,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.width,
    this.height,
    this.isCard,
    this.isDivider,
    this.constraints,
    this.margin,
    this.padding,
    this.background,
    this.decoration,
    this.titleFlex,
    this.detailFlex,
    this.titleToDetailSpacing,
    this.quickControlType,
    this.quickInputType,
    this.obscureText,
    this.isOpen,
    this.isEdit,
    this.isSlide,
    this.onSlideTap,
    this.slideList,
    this.isHide,
    this.dividerPadding,
    this.dividerColor,
    this.inputScale,
    this.onSubmitted,
    this.textInputAction = TextInputAction.next,
  });
}

class QuickCheck {
  final String Function(dynamic text) checking;
  final FocusNode focusNode;
  final TextEditingController controller;
  final dynamic data;
  final GestureTapCallback onTap;

  QuickCheck(
    this.checking,
    this.focusNode, {
    this.controller,
    this.data,
    this.onTap,
  });
}
