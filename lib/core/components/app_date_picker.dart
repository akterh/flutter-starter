import 'package:camerasync/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppDatePicker {
  static Future<DateTime?> showAppDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime lastDate,
    DateTime? firstDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate?? DateTime(2000),
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.kPrimaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.kSecondaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    return picked;
  }
}
