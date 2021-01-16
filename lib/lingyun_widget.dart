library lingyun_widget;

import 'package:flutter/material.dart';

const _logoColor = Color.fromARGB(255, 0, 188, 255);

Widget lingYunLogo(
  final BuildContext context, {
  Color color,
  bool hideText = false,
  String appName,
  double height,
  EdgeInsets padding,
}) {
  return Column(
    children: <Widget>[
      Padding(
        padding: padding ??
            const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
        child: Image.asset('assets/images/logo-alpha.png',
            color: color ?? _logoColor, height: height ?? 100),
      ),
      if (!hideText)
        Text(
          ' - Ling Yun ${appName ?? ''} - ',
          style: Theme.of(context).textTheme.subtitle2.copyWith(color: color),
        ),
    ],
  );
}

Widget lingYunLogoIcon(
  final BuildContext context, {
  double height = 100,
  Color color,
}) {
  return Image.asset(
    'assets/images/lingyun-logo.png',
    color: color ?? _logoColor,
    height: height,
  );
}
