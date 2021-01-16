/*
 * Project: tools_pack
 * Module: toolspack
 * Last Modified: 20-6-23 下午8:03
 * Copyright (c) 2020 August https://blog.geek-cloud.top/
 */

import 'package:flutter/material.dart';
import 'package:lingyun_widget/drink_card/rounded_shadow.dart';

class DrinkListCard extends StatefulWidget {
  /// 关闭状态下的高度
  static double nominalHeightClosed = 70;

  final Widget leading;
  final Widget title;
  final Widget trailing;
  final String contentTitle;
  final String contentBody;
  final Color bgColor;
  final double height;

  const DrinkListCard({
    Key key,
    this.leading,
    this.title,
    this.trailing,
    this.contentTitle,
    this.contentBody,
    this.bgColor = Colors.black, this.height,
  })  : assert(title != null),
        super(key: key);

  @override
  _DrinkListCardState createState() {
    return _DrinkListCardState();
  }
}

class _DrinkListCardState extends State<DrinkListCard>
    with TickerProviderStateMixin {
  // 标记是否已经打开
  bool _wasOpen = true;

  AnimationController _liquidSimController;

  @override
  void initState() {
    _liquidSimController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _liquidSimController.addListener(_rebuildIfOpen);
    });
    super.initState();
  }

  @override
  void dispose() {
    _liquidSimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_wasOpen) {
      _liquidSimController.forward(from: 0);
    }

    double cardHeight = _wasOpen
        ? (widget.height == null
            ? (widget.contentBody.split('\n').length * 50).toDouble() : widget.height)
        : DrinkListCard.nominalHeightClosed;

    return GestureDetector(
      onTap: () {
        setState(() {
          _wasOpen = !_wasOpen;
        });
      },
      // 使用动画容器，以便我们可以轻松地为小部件高度设置动画
      child: AnimatedContainer(
        curve: !_wasOpen ? ElasticOutCurve(.9) : Curves.elasticOut,
        duration: Duration(milliseconds: !_wasOpen ? 1200 : 1500),
        // 高度设置
        height: cardHeight,
        // 将内容包装在圆角阴影小部件中，因此将其圆角化但也具有阴影
        child: RoundedShadow.fromRadius(
          12,
          child: Container(
            color: widget.bgColor,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                //Background liquid layer
                AnimatedOpacity(
                  opacity: _wasOpen ? 1 : 0,
                  duration: Duration(milliseconds: 500),
                  child: _buildLiquidBackground(),
                ),

                //Card Content
                Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  //Wrap content in a ScrollView, so there's no errors on over scroll.
                  child: SingleChildScrollView(
                    //We don't actually want the scrollview to scroll, disable it.
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        //Top Header Row
                        _buildTopContent(),
                        //Spacer
                        SizedBox(height: 12),
                        //Bottom Content, use AnimatedOpacity to fade
                        AnimatedOpacity(
                          duration:
                              Duration(milliseconds: _wasOpen ? 1000 : 500),
                          curve: Curves.easeOut,
                          opacity: _wasOpen ? 1 : 0,
                          //Bottom Content
                          child: _buildBottomContent(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLiquidBackground() {
    return Container();
  }

  Row _buildTopContent() {
    return Row(
      children: <Widget>[
        //Icon
        widget.leading ?? const SizedBox(),
        SizedBox(width: 24),
        //Label
        Expanded(
          child: widget.title ?? const SizedBox(),
        ),
        //Star Icon
        widget.trailing ?? const SizedBox()
      ],
    );
  }

  _buildBottomContent() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text('${widget.contentTitle}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: Styles.text(12, false)),
        ),
        SizedBox(height: 16),
        Text(
          '${widget.contentBody}',
          textAlign: TextAlign.center,
          style: Styles.text(14, false, height: 1.5),
        ),
//        SizedBox(height: 16),
//        //Main Button
//        ButtonTheme(
//          minWidth: 200,
//          height: 40,
//          child: Opacity(
//            opacity: 1,
//            child: FlatButton(
//              //Enable the button if we have enough points. Can do this by assigning a onPressed listener, or not.
//              onPressed: () {},
//              color: AppColors.orangeAccent,
//              disabledColor: AppColors.orangeAccent,
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(24)),
//              child: Text("REDEEM", style: Styles.text(16, Colors.white, true)),
//            ),
//          ),
//        )
      ],
    );
  }

  void _rebuildIfOpen() {
    if (_wasOpen) {
      setState(() {});
    }
  }
}

class AppColors {
  static Color orangeAccent = Color(0xfff1a35d);
  static Color orangeAccentLight = Color(0xffff7f33);
  static Color redAccent = Color(0xfff1a35d);
  static Color grey = Color(0xff4d4d4d);
}

class Styles {
  static TextStyle text(double size,
      bool bold, {
        double height,
        Color color,
      }) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      height: height,
//      fontFamily: "Poppins",
    );
  }
}
