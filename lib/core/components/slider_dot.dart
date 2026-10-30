import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

Container buildDot(bool isSelected, BuildContext context) {
  return Container(
    height: 10.r,
    width: isSelected ? 20.r : 10.r,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:
            isSelected ? AppColors.kAccentColor : AppColors.kBackgroundColor2),
  );
}
