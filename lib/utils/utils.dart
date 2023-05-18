import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../res/colors.dart';

class Utils {
  static double? getRandomHeight() {
    final random = Random();
    final minHeight = 300;
    final maxHeight = 550;
    final heightDifference = 100;
    final randomHeight =
        random.nextInt(maxHeight - minHeight - heightDifference + 1) +
            minHeight;
    return randomHeight.toDouble();
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void changeFocusNode(BuildContext context,
      {required FocusNode current, required FocusNode next}) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        textColor: Colors.white,
        fontSize: 18,
        backgroundColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        message: message,
        duration: Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static snackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
          ),
        ),
        showCloseIcon: true,
        backgroundColor: AppColors.buttonkColor,
        elevation: 2,
      ),
    );
  }
}
