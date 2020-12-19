import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../quick.dart';
import '../quick_style.dart';

class QuickInkWell extends StatefulWidget {
  final Widget child;
  final dynamic data;
  final String Function(dynamic data) checking;
  final GestureTapCallback onTap;
  final GestureTapCallback onDoubleTap;
  final GestureLongPressCallback onLongPress;
  final GestureTapDownCallback onTapDown;

  const QuickInkWell(
    this.child, {
    Key key,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.checking,
    this.data,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuickInkWellState();
}

class _QuickInkWellState extends State<QuickInkWell> {
  QuickCheck quickCheck;
  QuickInheritedWidget inheritedWidget;

  @override
  Widget build(BuildContext context) {
    inheritedWidget = QuickInheritedWidget.of(context);
    if (widget.checking != null) {
      if (quickCheck == null) {
        quickCheck = QuickCheck(widget.checking, null,
            data: widget.data, onTap: widget.onTap);
      }
      inheritedWidget.tips.add(quickCheck);
    }
    return InkWell(
      focusNode: FocusNode(skipTraversal: true),
      child: widget.child,
      onTap: widget.onTap,
      onDoubleTap: widget.onDoubleTap,
      onLongPress: widget.onLongPress,
      onTapDown: widget.onTapDown,
    );
  }

  @override
  void didUpdateWidget(covariant QuickInkWell oldWidget) {
    super.didUpdateWidget(oldWidget);
    remove();
  }

  @override
  void dispose() {
    remove();
    super.dispose();
  }

  remove() {
    if (quickCheck != null) {
      inheritedWidget.tips.remove(quickCheck);
    }
  }
}
