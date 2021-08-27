/*
 * Project: tools_pack
 * Module: toolspack
 * Last Modified: 20-9-13 上午10:11
 * Copyright (c) 2020 August https://blog.geek-cloud.top/
 */

import 'dart:ui';

import 'package:flutter/material.dart';

/// 模糊背景 Dialog
class MyBlurDialogRoute<T> extends PopupRoute<T> {
  MyBlurDialogRoute({
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = true,
    required String barrierLabel,
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    RouteSettings? settings,
  })  : _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _transitionDuration = transitionDuration,
        _transitionBuilder = transitionBuilder,
//        super(settings: settings, filter: BlurSettings.blurFilter);
        super(
            settings: settings,
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60));

  final RoutePageBuilder _pageBuilder;

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String get barrierLabel => _barrierLabel;
  final String _barrierLabel;

  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor = Colors.white.withOpacity(0.05);

  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;

  final RouteTransitionsBuilder? _transitionBuilder;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Semantics(
      child: _pageBuilder(context, animation, secondaryAnimation),
      scopesRoute: true,
      explicitChildNodes: true,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (_transitionBuilder == null) {
      return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
          ),
          child: child);
    } // Some default transition
    return _transitionBuilder!(context, animation, secondaryAnimation, child);
  }
}
