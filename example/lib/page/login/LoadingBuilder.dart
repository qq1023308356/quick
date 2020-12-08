import 'package:flutter/cupertino.dart';
import 'package:loading_more_list/loading_more_list.dart';

Widget LoadingBuilder(BuildContext context, IndicatorStatus status) {
  //if your list is sliver list ,you should build sliver indicator for it
  //isSliver=true, when use it in sliver list
  bool isSliver = false;

  Widget widget;
  switch (status) {
    case IndicatorStatus.none:
      widget = Text("11111");
      break;
    case IndicatorStatus.loadingMoreBusying:
      widget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 5.0),
            height: 15.0,
            width: 15.0,
          ),
          Text("正在加载...不要着急")
        ],
      );
      break;
    case IndicatorStatus.fullScreenBusying:
      widget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 0.0),
            height: 30.0,
            width: 30.0,
          ),
          Text("正在加载...不要着急")
        ],
      );
      if (isSliver) {
        widget = SliverFillRemaining(
          child: widget,
        );
      } else {
        widget = CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              child: widget,
            )
          ],
        );
      }
      break;
    case IndicatorStatus.error:
      widget = Text(
        "好像出现了问题呢？",
      );
      widget = GestureDetector(
        onTap: () {

        },
        child: widget,
      );
      break;
    case IndicatorStatus.fullScreenError:
      widget = Text(
        "好像出现了问题呢？",
      );

      widget = GestureDetector(
        onTap: () {

        },
        child: widget,
      );
      if (isSliver) {
        widget = SliverFillRemaining(
          child: widget,
        );
      } else {
        widget = CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              child: widget,
            )
          ],
        );
      }
      break;
    case IndicatorStatus.noMoreLoad:
      widget = Text("没有更多的了。。不要拖了");
      break;
    case IndicatorStatus.empty:
      widget = EmptyWidget(
        "这里是空气！",
      );
      if (isSliver) {
        widget = SliverToBoxAdapter(
          child: widget,
        );
      } else {
        widget = CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              child: widget,
            )
          ],
        );
      }
      break;
  }
  return widget;
}