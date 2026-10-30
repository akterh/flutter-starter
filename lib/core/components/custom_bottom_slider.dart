import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomSlider extends StatelessWidget {
  const CustomBottomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 54.w,
      height: 6.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
