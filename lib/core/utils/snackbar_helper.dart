import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/alert_style.dart';
import '../app/app_context.dart';
import '../components/custom_snackbar.dart';

void success({required String title, required String subtitle}) {
  CustomSnackBar.show(
    context: AppContext.context,
    position: SnackBarPosition.top,
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    animation: SnackBarAnimation.scale,
    customBuilder: NotificationCard(
      type: NotificationType.success,
      title: title,
      subtitle: subtitle,
      onDismiss: () => CustomSnackBar.close(),
    ),
  );
}

void error({required String title, required String subtitle}) {
  CustomSnackBar.show(
    context: AppContext.context,
    position: SnackBarPosition.top,
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    animation: SnackBarAnimation.scale,
    customBuilder: NotificationCard(
      type: NotificationType.error,
      title: title,
      subtitle: subtitle,
      onDismiss: () => CustomSnackBar.close(),
    ),
  );
}


void warning({required String title, required String subtitle}) {
  CustomSnackBar.show(
    context: AppContext.context,
    position: SnackBarPosition.top,
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    animation: SnackBarAnimation.scale,
    customBuilder: NotificationCard(
      type: NotificationType.warning,
      title: title,
      subtitle: subtitle,
      onDismiss: () => CustomSnackBar.close(),
    ),
  );
}
