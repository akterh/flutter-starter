import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    super.key,
    required this.title,
    this.textStyle,
    this.isRequired = true,
  });

  final String title;
  final TextStyle? textStyle;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle ??
                  kBodyRegularMedium.copyWith(),
            ),
          ),
          if (isRequired)
            Transform.translate(
              offset: const Offset(2, 0),
              child: Text(
                "*",
                style:
                kBodyRegularMedium.copyWith(color: AppColors.kPrimaryColor400),
              ),
            )
        ],
      ),
    );
  }
}
