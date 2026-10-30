import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../constants/app_colors.dart';

void showProgressDialog() {
  if (!EasyLoading.isShow) EasyLoading.show(dismissOnTap: false);
}

void dismissProgressDialog() {
  if (EasyLoading.isShow) EasyLoading.dismiss();
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor =
        AppColors.kPrimaryColor
    ..indicatorColor =
        AppColors.kWhiteColor
    ..textColor = AppColors.kWhiteColor
    ..maskColor = Colors.blue.withValues(alpha: 0.5)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..userInteractions = false;
}
