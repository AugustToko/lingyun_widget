import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

// ----------------------------------------------------------------
//                          DEPRECATED
// ----------------------------------------------------------------

@Deprecated('Use FlushbarHelper')
void showErrorToast(BuildContext context, String message) {
  FlushbarHelper.createError(message: message).show(context);
}

@Deprecated('Use FlushbarHelper')
void showSuccessToast(BuildContext context, String message) {
  FlushbarHelper.createSuccess(message: message).show(context);
}