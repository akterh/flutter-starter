import 'package:camerasync/core/components/custom_button.dart';
import 'package:camerasync/core/components/custom_svg.dart';
import 'package:camerasync/core/constants/app_colors.dart';
import 'package:camerasync/core/constants/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_text_style.dart';

class CustomRefresher extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? subTitle;
  final String? buttonTitle;
  final Function()? onTap;

  const CustomRefresher({
    super.key,
    this.title,
    this.subTitle,
    this.icon,
    this.buttonTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null && icon!.isNotEmpty)
            CustomSvg(icon: icon!, size: 100,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              title ??
                  AppStrings.somethingWentWrong.tr(),
              style:
              kBodyMediumSemibold.copyWith(color: AppColors.kGreyColor600),
              textAlign: TextAlign.center,
            ),
          ),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              subTitle ??
                  AppStrings.serviceTemporarilyUnavailableApologizeForTheInconvenience.tr(),
              style:
                  kBodyMediumSemibold.copyWith(color: AppColors.kGreyColor400),
              textAlign: TextAlign.center,
            ),
          ),
          47.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.w),
            child: CustomButton(
              title: buttonTitle ?? AppStrings.tryAgain.tr(),
              onTap: onTap,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              borderRadius: 16.r,
            ),
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
