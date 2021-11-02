/*
 * Project: tools_pack
 * Module: toolspack
 * Last Modified: 20-5-6 下午4:06
 * Copyright (c) 2020 August https://blog.geek-cloud.top/
 */

import 'package:flutter/material.dart';

@Deprecated('废弃 使用 overlay 包装 LoadingDialog')
Future<void> loadingWait(final BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (_) => LoadingDialog(text: text),
  );
}

@Deprecated('废弃 使用 overlay 包装 LoadingDialog')
class LoadingDialog extends Dialog {
  final String text;

  final bool cancelable;

  LoadingDialog({
    Key? key,
    required this.text,
    this.cancelable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: SizedBox(
              height: 120.0,
              child: Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                      child: Text(text),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () {
          return Future.value(cancelable);
        });
  }
}
