import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class CustomGradientBg extends StatelessWidget {
  const CustomGradientBg({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            AppColors.kPrimaryColor,
            AppColors.kPrimaryGradientColor,
            AppColors.kPrimaryGradientColor,
            AppColors.kPrimaryGradientColor
          ])),
      padding: REdgeInsets.symmetric(horizontal: 20.w),
      child: child,
    );
  }
}
