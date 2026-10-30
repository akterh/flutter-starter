import 'package:camerasync/core/constants/app_colors.dart';
import 'package:camerasync/core/constants/app_text_style.dart';
import '../custom_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarLayout extends StatelessWidget {
  final Widget child;
  final Widget? actionWidget;
  final bool isBackButton;

  final String? title;
  final String subTitle;
  final Function()? onTap;
  final Function()? onTapAction;
  final EdgeInsetsGeometry? padding;
  final double? bottomOfPosition;

  const AppBarLayout(
      {super.key,
      required this.child,
      this.actionWidget,
      this.isBackButton = true,
      required this.title,
      this.subTitle = "",
      this.onTap,
      this.onTapAction,
      this.padding,
      this.bottomOfPosition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: .135.sh,
                width: 1.sw,
                padding: padding ?? EdgeInsets.only(bottom: 25.h),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.r),
                    bottomLeft: Radius.circular(30.r),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.kPrimaryGradientColor,
                      AppColors.kSecondaryGradientColor
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // stops: const [0.6, 1.8],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: .6.sw,
                      child: Text(
                        title ?? "",
                        style: kBodyLarge.copyWith(
                          color: AppColors.kWhiteColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Visibility(
                      visible: subTitle.isNotEmpty,
                      child: Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Text(
                          subTitle,
                          style: kBodyMedium.copyWith(
                              color: AppColors.kGreyColor100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isBackButton,
                child: Positioned(
                  left: 20.r,
                  bottom: 20.r,
                  child: CustomCircleButton(
                    height: 40.h,
                    width: 40.w,
                    onTap: onTap,
                    backGroundColor:
                        AppColors.kSecondaryColor.withValues(alpha: 0.6),
                    iconColors: AppColors.kWhiteColor,
                  ),
                ),
              ),
              Visibility(
                visible: actionWidget != null,
                child: Positioned(
                    right: 20.r,
                    bottom: bottomOfPosition ?? 20.r,
                    child: actionWidget ?? SizedBox.shrink()),
              ),
            ],
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
