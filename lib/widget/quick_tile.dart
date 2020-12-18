import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../quick.dart';
import '../quick_config.dart';
import '../widget/quick_Inherited.dart';
import '../widget/slidable.dart';
import '../widget/slide_action.dart';
import '../quick_style.dart';
import '../quick_type.dart';
import 'quick_InkWell.dart';

class QuickTile extends StatefulWidget {
  final title;
  final detail;
  final String hint;
  final QuickStyle quickStyle;
  final dynamic data;
  final String Function(dynamic text) checking;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  @override
  State<StatefulWidget> createState() => QuickTileState();

  QuickTile(this.title,
      {this.quickStyle,
      this.detail,
      this.hint,
      this.onTap,
      this.onLongPress,
      this.data,
      this.checking});
}

class QuickTileState extends State<QuickTile> {
  bool isDelete = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = QuickInheritedWidget.of(context);
    if (widget.quickStyle?.id != null) {
      inheritedWidget.map[widget.quickStyle?.id] = widget.quickStyle;
    }
    List<Widget> list = List();
    if (_isAddStartWidget(inheritedWidget)) {
      list.add(_getStartWidget(inheritedWidget));
    }
    list.add(_getContentWidget(inheritedWidget));
    if (_isEndStartWidget(inheritedWidget)) {
      list.add(_getEndWidget(inheritedWidget));
    }
    return (widget.quickStyle?.isHide ??
                inheritedWidget.getStyle(widget.quickStyle?.copyId)?.isHide ??
                inheritedWidget.quickStyle?.isHide ??
                false) ||
            isDelete
        ? SizedBox()
        : InkWell(
            focusNode: FocusNode(skipTraversal: true),
            child: _getBuild(list, inheritedWidget),
            onTap: widget.onTap,
            onLongPress: widget.onLongPress);
  }

  Widget _getBuild(List<Widget> list, QuickInheritedWidget inheritedWidget) {
    Widget build = Container(
      padding: widget.quickStyle?.padding ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.padding ??
          inheritedWidget.quickStyle?.padding ??
          QuickConfig.instance.style?.padding ??
          null,
      margin: widget.quickStyle?.margin ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.margin ??
          inheritedWidget.quickStyle?.margin ??
          QuickConfig.instance.style?.margin ??
          null,
      constraints: widget.quickStyle?.constraints ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.constraints ??
          inheritedWidget.quickStyle?.constraints ??
          QuickConfig.instance.style?.constraints ??
          null,
      width: widget.quickStyle?.width ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.width ??
          inheritedWidget.quickStyle?.width ??
          QuickConfig.instance.style?.width ??
          null,
      height: widget.quickStyle?.height ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.height ??
          inheritedWidget.quickStyle?.height ??
          QuickConfig.instance.style?.height ??
          null,
      color: widget.quickStyle?.background ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.background ??
          inheritedWidget.quickStyle?.background ??
          QuickConfig.instance.style?.background ??
          null,
      decoration: widget.quickStyle?.decoration ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.decoration ??
          inheritedWidget.quickStyle?.decoration ??
          QuickConfig.instance.style?.decoration ??
          null,
      /*alignment: widget.quickStyle?.alignment ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.alignment ??
          inheritedWidget.quickStyle?.alignment ?? Alignment.centerRight,*/
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: list,
      ),
    );
    Widget slide;
    Widget divider;
    if (widget.quickStyle?.isSlide ??
        inheritedWidget.getStyle(widget.quickStyle?.copyId)?.isSlide ??
        inheritedWidget.quickStyle?.isSlide ??
        QuickConfig.instance.style?.isSlide ??
        false) {
      List<Widget> secondaryActions = widget.quickStyle?.slideList ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.slideList ??
          inheritedWidget.quickStyle?.slideList ??
          QuickConfig.instance.style?.slideList;
      List<Widget> actions;
      if (secondaryActions != null) {
        actions = List();
        for (int i = 0; i < secondaryActions.length; i++) {
          actions.add(GestureDetector(
            child: secondaryActions[i],
            onTap: () {
              widget.quickStyle?.onSlideTap(i);
            },
          ));
        }
        secondaryActions = null;
      }
      slide = Slidable(
        delegate: SlidableScrollDelegate(),
        actionExtentRatio: 0.2,
        movementDuration: const Duration(seconds: 2),
        secondaryActions: actions ??
            <Widget>[
              SlideAction(
                child: Icon(
                  Icons.delete,
                  size: 30,
                ),
                color: Colors.red,
                onTap: () {
                  setState(() {
                    isDelete = true;
                  });
                },
              ),
            ],
        child: build,
      );
    }
    if (widget.quickStyle?.isDivider ??
        inheritedWidget.getStyle(widget.quickStyle?.copyId)?.isDivider ??
        inheritedWidget.quickStyle?.isDivider ??
        QuickConfig.instance.style?.isDivider ??
        false) {
      divider = Column(
        children: <Widget>[
          slide ?? build,
          Divider(
            height: 1,
            indent: widget.quickStyle?.dividerPadding ??
                inheritedWidget
                    .getStyle(widget.quickStyle?.copyId)
                    ?.dividerPadding ??
                inheritedWidget.quickStyle?.dividerPadding ??
                QuickConfig.instance.style?.dividerPadding ??
                0,
            endIndent: widget.quickStyle?.dividerPadding ??
                inheritedWidget
                    .getStyle(widget.quickStyle?.copyId)
                    ?.dividerPadding ??
                inheritedWidget.quickStyle?.dividerPadding ??
                QuickConfig.instance.style?.dividerPadding ??
                0,
            color: widget.quickStyle?.dividerColor ??
                inheritedWidget
                    .getStyle(widget.quickStyle?.copyId)
                    ?.dividerColor ??
                inheritedWidget.quickStyle?.dividerColor ??
                QuickConfig.instance.style?.dividerColor ??
                null,
          ),
        ],
      );
    }
    return divider ?? slide ?? build;
  }

  bool _isAddStartWidget(QuickInheritedWidget inheritedWidget) {
    return widget.quickStyle?.startWidget != null ||
        inheritedWidget.getStyle(widget.quickStyle?.copyId)?.startWidget !=
            null ||
        inheritedWidget.quickStyle?.startWidget != null;
  }

  Widget _getStartWidget(QuickInheritedWidget inheritedWidget) {
    return widget.quickStyle?.startWidget ??
        inheritedWidget.getStyle(widget.quickStyle?.copyId)?.startWidget ??
        inheritedWidget.quickStyle?.startWidget;
  }

  Widget _getContentWidget(QuickInheritedWidget inheritedWidget) {
    List<Widget> columnList = List();
    if (widget.quickStyle?.titleWidget != null ||
        inheritedWidget.getStyle(widget.quickStyle?.copyId)?.titleWidget !=
            null ||
        inheritedWidget.quickStyle?.titleWidget != null) {
      columnList.add(widget.quickStyle?.titleWidget ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.titleWidget ??
          inheritedWidget.quickStyle?.titleWidget);
    } else {
      columnList.add(Expanded(
        flex: widget.quickStyle?.titleFlex ??
            inheritedWidget.getStyle(widget.quickStyle?.copyId)?.titleFlex ??
            inheritedWidget.quickStyle?.titleFlex ??
            QuickConfig.instance.style?.titleFlex ??
            0,
        child: QuickText(widget.title, quickStyle: widget.quickStyle),
      ));
    }
    bool isCustom = (widget.quickStyle?.quickControlType ??
            inheritedWidget
                .getStyle(widget.quickStyle?.copyId)
                ?.quickControlType ??
            inheritedWidget.quickStyle?.quickControlType ??
            QuickControlType.Text) ==
        QuickControlType.Custom;
    if (!isCustom &&
        (widget.quickStyle?.detailWidget != null ||
            inheritedWidget.getStyle(widget.quickStyle?.copyId)?.detailWidget !=
                null ||
            inheritedWidget.quickStyle?.detailWidget != null)) {
      columnList.add(widget.quickStyle?.detailWidget ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.detailWidget ??
          inheritedWidget.quickStyle?.detailWidget);
    } else if (widget.detail != null || isCustom) {
      columnList.add(Expanded(
        flex: widget.quickStyle?.detailFlex ??
                inheritedWidget
                    .getStyle(widget.quickStyle?.copyId)
                    ?.detailFlex ??
                inheritedWidget.quickStyle?.detailFlex ??
                (widget.quickStyle?.axis ??
                        inheritedWidget
                            .getStyle(widget.quickStyle?.copyId)
                            ?.axis ??
                        inheritedWidget.quickStyle?.axis ??
                        QuickConfig.instance.style?.axis ??
                        Axis.horizontal) ==
                    Axis.horizontal
            ? 1
            : 0,
        child: Container(
          alignment: widget.quickStyle?.alignment ??
              inheritedWidget.getStyle(widget.quickStyle?.copyId)?.alignment ??
              inheritedWidget.quickStyle?.alignment ??
              QuickConfig.instance.style?.alignment ??
              Alignment.centerRight,
          padding: EdgeInsets.only(
              left: _isHorizontal(inheritedWidget)
                  ? widget.quickStyle?.titleToDetailSpacing ??
                      inheritedWidget
                          .getStyle(widget.quickStyle?.copyId)
                          ?.titleToDetailSpacing ??
                      inheritedWidget.quickStyle?.titleToDetailSpacing ??
                      QuickConfig.instance.style?.titleToDetailSpacing ??
                      0
                  : 0,
              top: !_isHorizontal(inheritedWidget)
                  ? widget.quickStyle?.titleToDetailSpacing ??
                      inheritedWidget
                          .getStyle(widget.quickStyle?.copyId)
                          ?.titleToDetailSpacing ??
                      inheritedWidget.quickStyle?.titleToDetailSpacing ??
                      QuickConfig.instance.style?.titleToDetailSpacing ??
                      0
                  : 0),
          child: _getContentWidgetState(inheritedWidget),
        ),
      ));
    }
    return Expanded(
      child: Flex(
        mainAxisAlignment: widget.quickStyle?.mainAxisAlignment ??
            inheritedWidget
                .getStyle(widget.quickStyle?.copyId)
                ?.mainAxisAlignment ??
            inheritedWidget.quickStyle?.mainAxisAlignment ??
            (_isHorizontal(inheritedWidget)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center),
        crossAxisAlignment: widget.quickStyle?.crossAxisAlignment ??
            inheritedWidget
                .getStyle(widget.quickStyle?.copyId)
                ?.crossAxisAlignment ??
            inheritedWidget.quickStyle?.crossAxisAlignment ??
            (_isHorizontal(inheritedWidget)
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start),
        mainAxisSize: MainAxisSize.max,
        verticalDirection: VerticalDirection.down,
        direction: widget.quickStyle?.axis ??
            inheritedWidget.getStyle(widget.quickStyle?.copyId)?.axis ??
            inheritedWidget.quickStyle?.axis ??
            QuickConfig.instance.style?.axis ??
            Axis.horizontal,
        children: columnList,
      ),
    );
  }

  bool _isHorizontal(QuickInheritedWidget inheritedWidget) {
    return ((widget.quickStyle?.axis ??
            inheritedWidget.getStyle(widget.quickStyle?.copyId)?.axis ??
            inheritedWidget.quickStyle?.axis ??
            QuickConfig.instance.style?.axis ??
            Axis.horizontal) ==
        Axis.horizontal);
  }

  bool _isEndStartWidget(QuickInheritedWidget inheritedWidget) {
    return widget.quickStyle?.endWidget != null ||
        inheritedWidget.getStyle(widget.quickStyle?.copyId)?.endWidget !=
            null ||
        inheritedWidget.quickStyle?.endWidget != null;
  }

  Widget _getEndWidget(QuickInheritedWidget inheritedWidget) {
    return widget.quickStyle?.endWidget ??
        inheritedWidget.getStyle(widget.quickStyle?.copyId)?.endWidget ??
        inheritedWidget.quickStyle?.endWidget;
  }

  Widget _getContentWidgetState(QuickInheritedWidget inheritedWidget) {
    Widget contentWidget;
    switch (widget.quickStyle?.quickControlType ??
        inheritedWidget.getStyle(widget.quickStyle?.copyId)?.quickControlType ??
        inheritedWidget.quickStyle?.quickControlType ??
        QuickConfig.instance.style?.quickControlType ??
        QuickControlType.Text) {
      case QuickControlType.Text:
        contentWidget = QuickText(widget.detail, quickStyle: widget.quickStyle);
        if (widget.checking != null) {
          contentWidget = QuickInkWell(
            contentWidget,
            checking: widget.checking,
            data: widget.data,
            onTap: widget.onTap,
            onLongPress: widget.onLongPress,
          );
        }
        break;
      case QuickControlType.Input:
        contentWidget = QuickTextField(
          widget.detail,
          checking: widget.checking,
          quickStyle: widget.quickStyle,
          hint: widget.hint ?? "请输入" + widget.title,
          isTitleStyle: false,
          decoration: BoxDecoration(),
        );
        break;
      case QuickControlType.Custom:
        contentWidget = QuickInkWell(
          widget.quickStyle.detailWidget,
          checking: widget.checking,
          data: widget.data,
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
        );
        break;
    }
    return contentWidget;
  }
}
