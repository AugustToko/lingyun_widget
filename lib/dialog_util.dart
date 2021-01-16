/*
 * Project: tools_pack
 * Module: toolspack
 * Last Modified: 20-12-5 下午1:51
 * Copyright (c) 2020 August https://blog.geek-cloud.top/
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingyun_widget/toast.dart';
import 'file:///C:/Users/chenlongcould/AndroidStudioProjects/lingyun_widget/lib/blur_dialog.dart';

class DialogUtil {
  static getDialogCloseButton(context,
          {Function() customTapFunc, Color color = Colors.redAccent}) =>
      FlatButton(
          onPressed: customTapFunc ??
              () {
                Navigator.pop(context);
              },
          child: Text(
            '关闭',
            style: TextStyle(color: color),
          ));

  @Deprecated('Use showDialog instead')
  static void showAlertDialog(final BuildContext context, final String title,
      final String content, final List<Widget> actions,
      [final bool cancelAble]) {
    showDialog(
      barrierDismissible: cancelAble ?? true,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions,
      ),
    );
  }

  static Future<T> showBlurDialog<T>(
      final BuildContext context, final WidgetBuilder builder,
      {final bool barrierDismissible = true}) {
    final ThemeData theme = Theme.of(context);

    return Navigator.of(context, rootNavigator: true)
        .push<T>(MyBlurDialogRoute<T>(
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 150),
    ));
  }

  static Future<bool> showQuitDialog(final BuildContext context,
      {bool blurBG = false, String appName = 'APP NAME'}) {
    var ad = AlertDialog(
      title: Text('退出警告'),
      content: Text("确定退出 $appName?"),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('还是算了吧'),
        ),
        FlatButton(
          onPressed: () async {
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: Text('退出'),
        ),
      ],
    );

    var builder = (context) {
      return ad;
    };

    return blurBG
        ? showBlurDialog(context, builder)
        : showDialog(
            context: context,
            builder: builder,
          );
  }

  static Future<bool> showExitEditorDialog(final BuildContext context,
      final bool needBackup, final Function() onTapSave) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(needBackup ? '请问是否需要保存到草稿箱？' : '是否退出编辑？'),
          content: Text(needBackup ? "我们发现您已经编辑了一些内容，请问是否保存它们？" : '您即将离开编辑页面！'),
          actions: needBackup
              ? <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('不用'),
                  ),
                  FlatButton(
                    onPressed: () {
                      onTapSave();
                    },
                    child: Text('保存'),
                  ),
                ]
              : <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('确定'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('取消'),
                  ),
                ],
        );
      },
    );
  }

  static void showLogoutDialog(
      final BuildContext context, Function afterLogout) {
    showAlertDialog(context, "登出", "即将退出登陆，请确认。", [
      FlatButton(
          onPressed: () {
            afterLogout();
            Navigator.pop(context);
            showSuccessToast(context, "您已登出!");
          },
          child: Text("登出")),
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("取消"))
    ]);
  }
}
