
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static RegExp regExpDateWithTime = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d[ ](0[0-9]|1[0-9]|2[0-4])[:](0[0-9]|[1-4][0-9]|5[0-9])$');
  /////   dd-MM-yyyy
  static RegExp regExpDate = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$');
  static showCustomToast(
      String message, Color color, int seconds, BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      message: message,
      backgroundColor: color,
      duration: Duration(seconds: seconds),
    ).show(context);
  }

  static showSuccessToast(String message, BuildContext context) {
    showCustomToast(message, Colors.green, 1, context);
  }

  static showErrorToast(String message, BuildContext context) {
    showCustomToast(message, Colors.red, 1, context);
  }

  static showWarningToast(String message, BuildContext context) {
    showCustomToast(message, Colors.green, 1, context);
  }

  static showInfoToast(String message, BuildContext context) {
    showCustomToast(message, Colors.green, 1, context);
  }

  static showProgressToast(String message, BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      message: message,
      backgroundColor: Colors.black,
      progressIndicatorBackgroundColor: Colors.blueGrey,
      showProgressIndicator: true,
      duration: Duration(seconds: 1),
    ).show(context);
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  static const transformScale = 162.0;

  static bool isValidPassword(String pass) {
    if (pass.isNotEmpty && pass.length > 4) {
      return true;
    }
    return false;
  }

  static DateTime stringToUtcDate(String dateString) {
    if (regExpDate.hasMatch(dateString))
      return DateFormat("dd-MM-yyyy").parse(dateString).toUtc();
    else if (regExpDateWithTime.hasMatch(dateString))
      return DateFormat("dd-MM-yyyy H:m").parse(dateString).toUtc();
    else
      print("Invalid Date");
    return null;
  }

  static String dateToLocalString(DateTime date,
      {String format = "dd-MM-yyyy"}) {
    return DateFormat(format).format(date.isUtc ? date.toLocal() : date);
  }

  static String dateToLocalTimeString(DateTime date,
      {bool is12H = false, String format}) {
    return DateFormat(format != null
        ? format
        : is12H
        ? "j:m"
        : "H:m")
        .format(date.isUtc ? date.toLocal() : date);
  }
}
