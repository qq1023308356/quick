import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../quick_config.dart';
import '../quick_style.dart';

// ignore: must_be_immutable
class QuickInheritedWidget extends InheritedWidget {
  QuickStyle quickStyle;
  final Map<String, QuickStyle> map = Map();
  final List<QuickCheck> tips = List();

  QuickInheritedWidget({
    Key key,
    @required Widget child,
    this.quickStyle,
  }) : super(key: key, child: child) {
    if (quickStyle == null) quickStyle = QuickConfig.instance.style;
  }

  static QuickInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<QuickInheritedWidget>() ??
        QuickInheritedWidget.fallback();
  }

  QuickStyle getStyle(String id) {
    return map[id];
  }

  QuickInheritedWidget.fallback({Key key})
      : quickStyle = null,
        super(key: key, child: null);

  @override
  bool updateShouldNotify(QuickInheritedWidget oldWidget) {
    return quickStyle != oldWidget.quickStyle;
  }
}
