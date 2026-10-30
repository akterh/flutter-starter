import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camerasync/core/components/custom_svg.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.gradient,
    this.isGradientColor = true,
    this.isBorder = false,
    this.border,
    this.borderColor = AppColors.kGreyColor300,
    this.borderRadius,
    this.onTap,
    this.textStyle,
    this.textColor,
    this.backgroundColor,
    this.padding,
    this.isPrefixEnable = false,
    this.icon,
    this.iconSize,
    this.iconColor,
  });

  final String title;
  final Gradient? gradient;
  final bool isGradientColor;
  final bool isBorder;
  final Border? border;
  final Color borderColor;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool isPrefixEnable;
  final String? icon;
  final double? iconSize;
  final double? borderRadius;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final textStyle = this.textStyle ??
        kBodyMedium.copyWith(
          color: textColor ?? AppColors.kWhiteColor,
        );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child:  Opacity(
        opacity: onTap != null ? 1:0.5,
        child: Container(
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.h),
          alignment: Alignment.center,
          decoration: onTap != null? BoxDecoration(
              color: backgroundColor,
              gradient: isGradientColor
                  ? gradient ??
                      (onTap != null
                          ? AppColors.kButtonGradient
                          : AppColors.kButtonGradient)
                  : null,
              borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
              border: isBorder
                   ? border ?? Border.all(color: AppColors.kSecondaryColor500, width: 1)
                   : null,
              ):BoxDecoration(
            color: backgroundColor ??
                (onTap != null ? AppColors.kPrimaryColor700 : AppColors.kGreyColor100),
            gradient: isGradientColor
                ? gradient ??
                (onTap != null
                    ? AppColors.kButtonGradient
                    : AppColors.kButtonGradient)
                : null,
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
            border: isBorder
                ? border ?? Border.all(color: AppColors.kSecondaryColor500, width: 1)
                : null,
          ),
          child: isPrefixEnable
              ? _buildIconAndText(textStyle)
              : Text(title, style: textStyle,overflow: TextOverflow.ellipsis,maxLines: 1,),
        ),
      ),
    );
  }

  Row _buildIconAndText(TextStyle textStyle) {
    final isIconSvg = icon!.toLowerCase().endsWith('.svg');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isIconSvg)
          CustomSvg(
            icon: icon!,
            size: iconSize ?? 24.r,
            color: iconColor,
          ),
        if (!isIconSvg)
          Image.asset(
            icon!,
            height: 24.r,
            width: 24.r,
            errorBuilder: (context, error, stackTrace) => Text(
              title[0],
              style: const TextStyle(fontSize: 20),
            ),
          ),
        10.horizontalSpace,
        Text(title, style: textStyle,overflow: TextOverflow.ellipsis,maxLines: 1,)
      ],
    );
  }
}
