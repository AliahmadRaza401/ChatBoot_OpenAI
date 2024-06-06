import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Themes/AppColors.dart';

customSnackBar({required String title}) {
  return Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.PRIMARY_COLOR,
      textColor: AppColors.WHITE_COLOR,
      fontSize: 16.0);
}

customLoading({Color? color}) {
  return Center(
      child: CircularProgressIndicator(
    color: color ?? AppColors.PRIMARY_COLOR,
  ));
}
