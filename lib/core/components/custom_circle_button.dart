import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircleButton extends StatelessWidget {
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final Color? backGroundColor;
  final Color? iconColors;
  final IconData? icon;

  const CustomCircleButton({
    super.key,
    this.height,
    this.width,
    this.onTap,
    this.backGroundColor,
    this.iconColors,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
      child: Container(
        height: height ?? 36.h,
        width: width ?? 36.w,
        decoration: BoxDecoration(
          color: backGroundColor ?? Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon ?? Icons.arrow_back_ios_new,
            size: 18.r,
            color: iconColors ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
