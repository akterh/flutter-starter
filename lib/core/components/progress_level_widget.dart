import 'package:camerasync/core/constants/app_colors.dart';
import 'package:camerasync/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressLevelWidget extends StatelessWidget {
  final String title;
  final int completedSteps;
  final int totalSteps;
  final Color progressColor;
  final Color backgroundColor;
  final double height;
  final double borderRadius;
  final Function(double)? onChange;

  const ProgressLevelWidget(
      {super.key,
      required this.title,
      required this.completedSteps,
      required this.totalSteps,
      this.progressColor = const Color(0xFF10B981),
      this.backgroundColor = const Color(0xFFE5E7EB),
      this.height = 12.0,
      this.borderRadius = 10.0,
      this.onChange});

  double get _progress {
    if (totalSteps <= 0) return 0.0;
    return (completedSteps / totalSteps).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and Score Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                title,
                style: kBodyRegularRegular.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kFontBaseColor1,
                ),
              ),
            ),
            Text(
              '$completedSteps/$totalSteps',
              style: kBodyRegularRegular.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: progressColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // Progress Bar with accurate thumb positioning

        SliderTheme(
          data: SliderThemeData(
            trackHeight: 8,
          ),
          child: Slider(
            padding: EdgeInsets.zero,
            inactiveColor: AppColors.kGreyColor200,
            activeColor: AppColors.kPrimaryColor,
            min: 0.0,
            max: totalSteps.toDouble(),
            value: completedSteps.toDouble(),
            onChanged: onChange,
          ),
        ),
      ],
    );
  }
}
