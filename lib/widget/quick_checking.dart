import 'package:flutter/cupertino.dart';
import '../quick.dart';

class QuickChecking extends StatelessWidget {
  final Widget child;
  final GestureTapCallback complete;

  const QuickChecking(
    this.child,
    this.complete, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = QuickInheritedWidget.of(context);
    return GestureDetector(
      child: child,
      onTap: () {
        bool isComplete = true;
        for (QuickCheck quickCheck in inheritedWidget.tips) {
          String tip = quickCheck
                  .checking(quickCheck.controller?.text ?? quickCheck.data) ??
              "";
          if (tip.isNotEmpty) {
            QuickConfig.instance?.errorTip(tip);
            if (quickCheck.focusNode != null)
              FocusScope.of(context).requestFocus(quickCheck.focusNode);
            if (quickCheck.onTap != null) quickCheck.onTap();
            isComplete = false;
            return;
          }
        }
        if (isComplete) {
          complete();
        }
      },
    );
  }
}
