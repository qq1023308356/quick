import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui show TextHeightBehavior;

import '../quick.dart';
import '../quick_config.dart';
import '../quick_style.dart';
import '../quick_type.dart';

class QuickTextField extends StatefulWidget {
  final RxString data;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLength;
  final int maxLines;
  final double height;
  final String semanticsLabel;
  final TextWidthBasis textWidthBasis;
  final ui.TextHeightBehavior textHeightBehavior;
  final String hint;
  final QuickStyle quickStyle;
  final bool isTitleStyle;
  final BoxDecoration decoration;
  final QuickInputType quickInputType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String Function(dynamic text) checking;
  final ValueChanged<String> onChanged;
  final bool autoFocus;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;

  QuickTextField(
    this.data, {
    Key key,
    this.hint,
    this.quickStyle,
    this.quickInputType,
    this.isTitleStyle = false,
    this.decoration,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLength,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.controller,
    this.focusNode,
    this.checking,
    this.height,
    this.onChanged,
    this.autoFocus = false,
    this.alignment = Alignment.center,
    this.padding,
  });

  @override
  State<StatefulWidget> createState() => QuickTextFieldState();
}

class QuickTextFieldState extends State<QuickTextField> {
  final RxString changed = "".obs;
  TextEditingController controller;
  FocusNode focusNode;
  bool isDouble = false;
  QuickCheck quickCheck;
  QuickInheritedWidget inheritedWidget;
  QuickInputType quickInputType;
  Worker worker;
  GetStream<String> stream;
  GetStream<String> nullStream = GetStream<String>();

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    stream = widget.data.subject;
    worker = debounce(changed, (_) {
      widget.data.subject = nullStream;
      widget.data.value = controller.text;
      widget.data.subject = stream;
    }, time: Duration(milliseconds: 200));
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        if (isDouble) {
          try {
            controller.text = double.parse(controller.text).toString();
          } catch (e) {}
        }
        widget.data.value = controller.text;
      }
    });
  }

  @override
  void didUpdateWidget(covariant QuickTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    remove();
  }

  @override
  void dispose() {
    remove();
    focusNode.dispose();
    controller.dispose();
    worker.dispose();
    if (widget.data.subject.isClosed) {
      widget.data.close();
    }
    super.dispose();
  }

  remove() {
    if (quickCheck != null) {
      inheritedWidget.tips.remove(quickCheck);
    }
  }

  @override
  Widget build(BuildContext context) {
    inheritedWidget = QuickInheritedWidget.of(context);
    final quickStyle = widget.quickStyle;
    final textInputAction = quickStyle?.textInputAction ??
        inheritedWidget.getStyle(widget.quickStyle?.copyId)?.textInputAction ??
        inheritedWidget.quickStyle?.textInputAction ??
        QuickConfig.instance.style?.textInputAction ??
        TextInputAction.next;
    if (widget.checking != null) {
      if (quickCheck == null) {
        quickCheck =
            QuickCheck(widget.checking, focusNode, controller: controller);
      }
      inheritedWidget.tips.add(quickCheck);
    }
    return Obx(
      () {
        controller.text = widget.data.toString();
        controller.selection = TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: controller.text.length));
        return Container(
          padding: widget.padding,
          height: widget.height,
          alignment: widget.alignment,
          child: CupertinoTextField(
            padding: const EdgeInsets.all(0),
            autofocus: widget.autoFocus,
            showCursor: true,
            decoration: widget.decoration,
            obscureText: quickStyle?.obscureText ??
                inheritedWidget.getStyle(quickStyle?.copyId)?.obscureText ??
                inheritedWidget.quickStyle?.obscureText ??
                QuickConfig.instance.style?.obscureText ??
                null,
            enabled: quickStyle?.enabled ??
                inheritedWidget.getStyle(quickStyle?.copyId)?.enabled ??
                inheritedWidget.quickStyle?.enabled ??
                QuickConfig.instance.style?.enabled ??
                null,
            maxLength: quickStyle?.maxLength ??
                inheritedWidget.getStyle(quickStyle?.copyId)?.maxLength ??
                inheritedWidget.quickStyle?.maxLength ??
                QuickConfig.instance.style?.maxLength ??
                null,
            maxLines: quickStyle?.maxLines ??
                inheritedWidget.getStyle(quickStyle?.copyId)?.maxLines ??
                inheritedWidget.quickStyle?.maxLines ??
                QuickConfig.instance.style?.maxLines ??
                null,
            inputFormatters: getInputFormatters(
                quickStyle?.quickInputType ??
                    inheritedWidget
                        .getStyle(quickStyle?.copyId)
                        ?.quickInputType ??
                    inheritedWidget.quickStyle?.quickInputType ??
                    QuickConfig.instance.style?.quickInputType ??
                    null,
                quickStyle?.inputScale ??
                    inheritedWidget.getStyle(quickStyle?.copyId)?.inputScale ??
                    inheritedWidget.quickStyle?.inputScale ??
                    QuickConfig.instance.style?.inputScale ??
                    2),
            textAlign: widget.textAlign ??
                quickStyle?.textAlign ??
                inheritedWidget.getStyle(quickStyle?.copyId)?.textAlign ??
                inheritedWidget.quickStyle?.textAlign ??
                QuickConfig.instance.style?.textAlign ??
                TextAlign.start,
            keyboardType: getKeyboardType(),
            controller: controller,
            focusNode: focusNode,
            placeholder: widget.hint,
            style: widget.isTitleStyle
                ? quickStyle?.titleStyle ??
                    inheritedWidget.getStyle(quickStyle?.copyId)?.titleStyle ??
                    inheritedWidget.quickStyle?.titleStyle ??
                    QuickConfig.instance.style?.titleStyle ??
                    null
                : quickStyle?.detailStyle ??
                    inheritedWidget.getStyle(quickStyle?.copyId)?.detailStyle ??
                    inheritedWidget.quickStyle?.detailStyle ??
                    QuickConfig.instance.style?.detailStyle ??
                    null,
            placeholderStyle: quickStyle?.hintStyle ??
                inheritedWidget.getStyle(quickStyle?.copyId)?.hintStyle ??
                inheritedWidget.quickStyle?.hintStyle ??
                QuickConfig.instance.style?.hintStyle ??
                null,
            onEditingComplete: () {
              if (textInputAction == TextInputAction.next) {
                focusNode.nextFocus();
              } else if (textInputAction == TextInputAction.previous) {
                focusNode.previousFocus();
              }
            },
            onChanged: (str) {
              changed.value = str;
              if (widget.onChanged != null) {
                widget.onChanged(str);
              }
            },
            onSubmitted: quickStyle?.onSubmitted ??
                inheritedWidget
                    .getStyle(widget.quickStyle?.copyId)
                    ?.onSubmitted ??
                inheritedWidget.quickStyle?.onSubmitted ??
                QuickConfig.instance.style?.onSubmitted,
            textInputAction: textInputAction,
          ),
        );
      },
    );
  }

  TextInputType getKeyboardType() {
    if (quickInputType == QuickInputType.Double ||
        quickInputType == QuickInputType.Int) {
      return TextInputType.number;
    } else if (quickInputType == QuickInputType.LetterNumber) {
      return TextInputType.visiblePassword;
    } else if (quickInputType == QuickInputType.Multiline) {
      return TextInputType.multiline;
    } else {
      return TextInputType.text;
    }
  }

  List<TextInputFormatter> getInputFormatters(
      QuickInputType inputType, int scale) {
    quickInputType = inputType;
    isDouble = false;
    if (inputType == null) {
      return null;
    }
    switch (inputType) {
      case QuickInputType.Int:
        return [FilteringTextInputFormatter.digitsOnly];
        break;
      case QuickInputType.Double:
        isDouble = true;
        return [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          PrecisionLimitFormatter(scale)
        ];
        break;
      case QuickInputType.LetterNumber:
        return [FilteringTextInputFormatter.allow(RegExp(r"[0-9a-zA-Z]"))];
        break;
      case QuickInputType.String:
        return null;
        break;
      case QuickInputType.Multiline:
        return null;
        break;
    }
    return null;
  }
}

class PrecisionLimitFormatter extends TextInputFormatter {
  int _scale;

  PrecisionLimitFormatter(this._scale);

  static const String POINTER = ".";
  static const String DOUBLE_ZERO = "00";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith(POINTER) && newValue.text.length == 1) {
      //第一个不能输入小数点
      return oldValue;
    }

    ///输入完全删除
    if (newValue.text.isEmpty) {
      return TextEditingValue();
    }

    ///包含小数点的情况
    if (newValue.text.contains(POINTER)) {
      ///包含多个小数
      if (newValue.text.indexOf(POINTER) !=
          newValue.text.lastIndexOf(POINTER)) {
        return oldValue;
      }
      String input = newValue.text;
      int index = input.indexOf(POINTER);

      ///小数点后位数
      int lengthAfterPointer = input.substring(index, input.length).length - 1;

      ///小数位大于精度
      if (lengthAfterPointer > _scale) {
        return oldValue;
      }
    } else if (newValue.text.startsWith(POINTER) ||
        (newValue.text.startsWith("0") && newValue.text.length >= 2) ||
        newValue.text.startsWith(DOUBLE_ZERO)) {
      ///不包含小数点,不能以“00”开头
      return oldValue;
    }
    return newValue;
  }
}
