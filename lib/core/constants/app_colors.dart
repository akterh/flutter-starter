import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  // Primary Colors
  static const kPrimaryColor = Color(0xFF3AB57C);
  static const kPrimaryColor700 = Color(0xFF041E11);
  static const kPrimaryColor600 = Color(0xFF0F3F29);
  static const kPrimaryColor500 = Color(0xFF1C6443);
  static const kPrimaryColor400 = Color(0xFF2B8C5F);
  static const kPrimaryColor300 = Color(0xFF3AB57C);
  static const kPrimaryColor200 = Color(0xFF4AE09B);
  static const kPrimaryColor100 = Color(0xFFC1FDDA);

  // Secondary Colors
  static const kSecondaryColor = Color(0xFF005766);
  static const kSecondaryColor700 = Color(0xFF001419);
  static const kSecondaryColor600 = Color(0xFF00343E);
  static const kSecondaryColor500 = Color(0xFF005766);
  static const kSecondaryColor400 = Color(0xFF007D91);
  static const kSecondaryColor300 = Color(0xFF00A5BF);
  static const kSecondaryColor200 = Color(0xFF00CEEF);
  static const kSecondaryColor100 = Color(0xFFB5EDFF);

  // Accent
  static const kAccentColor = Color(0xFF8BEE82);

  // Grey
  static const kGreyColor = Color(0xFF585B5A);
  static const kGreyColor700 = Color(0xFF1A1B1B);
  static const kGreyColor600 = Color(0xFF383A39);
  static const kGreyColor500 = Color(0xFF585B5A);
  static const kGreyColor400 = Color(0xFF7B7E7D);
  static const kGreyColor300 = Color(0xFF9FA4A2);
  static const kGreyColor200 = Color(0xFFC5CBC9);
  static const kGreyColor100 = Color(0xFFEEF1F0);
  static const kGreyLight = Color(0xFFF3F6FA);


  // State Colors
  static const kFontBaseColor1 = Color(0xFF002D45);
  static const kFontColor2 = Color(0xFF074465);
  static const kFontColor3 = Color(0xFF0C6EA2);
  static const kFontColor4 = Color(0xFFFFFFFF);

  static const kErrorColor1 = Color(0xFFE53535);
  static const kErrorColor2 = Color(0xFFFF5C5C);
  static const kErrorColor3 = Color(0xFFFF8080);
  static const kRedColor200 = Color(0xFFFF8080);

  static const kSuccessColor = Color(0xFF06C270);
  static const kSuccessColor1 = Color(0xFF05A660);
  static const kSuccessColor2 = Color(0xFF05A660);
  static const kSuccessColor3 = Color(0xFF39D98A);

  static const kWhiteColor = Color(0xFFFFFFFF);
  static const kBlackColor = Color(0xFF000000);
  static const kTransparent = Colors.transparent;

  static const kPrimaryGradientColor = Color(0xFF005766);
  static const kSecondaryGradientColor = Color(0xFF3AB57C);
  static const kSecondaryGreenColor = Color(0xFF06592F);
  static const kSecondaryGreen1Color = Color(0xFF178A6B);

  static const kStatusBarColor = Color(0xFF002D45);
  static const kBackgroundColor = Color(0xFFF3F6FA);
  static const kBackgroundColor2 = Color(0xFF2C978D);

  static const primaryBackground1 = Color(0xFF81CCED);
  static const primaryBackground2 = Color(0xFF4A94D1);
  static const primaryBackground3 = Color(0xFF00323B);

  static const shadowColor = Color(0xFF262740);
  static const borderColor = Color(0xFFDADADA);

  static const dark1 = Color(0xFF3A3A3C);

  static const successColor = Color(0xFFECFDF6);
  static const successBorderColor = Color(0xFFC5E6CE);

  static const errorColor = Color(0xFFFFE6E6);
  static const errorBorderColor = Color(0xFFFFC2C2);

  static const warningColor = Color(0xFFFFFBEE);
  static const warningBorderColor = Color(0xFFEBE2C2);

  static const snackBarShadowColor = Color(0xFF757575);
  static const editEmailFillColor = Color(0xFFEBEBEB);

  static const kButtonGradient = LinearGradient(
    colors: [kPrimaryGradientColor, kSecondaryGradientColor],
    // Blue and purple gradient
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const kLoaderGradient = LinearGradient(
    colors: [kPrimaryGradientColor, kSecondaryGradientColor],
    // Blue and purple gradient
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const kButtonGradientDisable = LinearGradient(
    colors: [kPrimaryGradientColor, kSecondaryGradientColor],
    // Blue and purple gradient
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const kHeaderGradient = LinearGradient(
    colors: [Color(0xFF391995), Color(0xFF11A9EA)], // Blue and purple gradient
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0],
  );

  static const kGenderButtonGradient = LinearGradient(
    colors: [Color(0xFF5632BD), Color(0xFF33B1E7)], // Blue and purple gradient
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const kToggleButtonGradient = LinearGradient(
    colors: [Color(0xFF4E54C8), Color(0xFF17A0B2)], // Blue and purple gradient
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  LinearGradient kDisableButtonGradient = LinearGradient(
    colors: [
      const Color(0xFF4E54CB).withValues(alpha: 0.2),
      const Color(0xFF17A0B2).withValues(alpha: 0.186)
    ], // Blue and purple gradient
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const kImageGradient = LinearGradient(
    colors: [Color(0xFF070B34), Color(0xFF5E7BD3)], // Blue and purple gradient
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [1.0, 0.0],
  );

  static final kTextFieldShadow = BoxShadow(
    color: shadowColor.withValues(alpha: 0.07),
    offset: const Offset(0, 2), // Horizontal and Vertical offset
    blurRadius: 32, // Blur radius
    spreadRadius: 0,
  );

  static final kCircularButtonShadow = BoxShadow(
    color: AppColors.kBlackColor.withValues(alpha: 0.05),
    spreadRadius: 0,
    blurRadius: 6,
    offset: const Offset(0, 2),
  );

  static final kCircularNotificationButtonShadow = BoxShadow(
    color: AppColors.kBlackColor.withValues(alpha: .28),
    blurRadius: 107,
    offset: const Offset(3, 10),
  );

  static final kCircularNotificationCardShadow = BoxShadow(
    color: const Color(0xFF282828).withValues(alpha: .05),
    blurRadius: 52,
    offset: const Offset(0, 8),
  );

  static final kOrdinaryShadow = BoxShadow(
    color: kGreyColor700.withValues(alpha: .12),
    spreadRadius: 1,
    blurRadius: 1,
    offset: const Offset(0, 1),
  );

  static final kBackGroundShadow = BoxShadow(
    color: const Color(0xFFABB0AC).withValues(alpha: 0.25),
    blurRadius: 70,
    offset: const Offset(0, 4),
    spreadRadius: 0,
  );

  static final kBackGroundShadowProfile = BoxShadow(
    color: const Color(0xFFE0E1E0).withValues(alpha: 0.4),
    offset: const Offset(0, 4),
    blurRadius: 50.r,
    spreadRadius: 0,
  );

  static final backgroundShadow = BoxShadow(
    color: const Color(0xFFE0E1E0).withValues(alpha: 0.8),
    blurRadius: 52,
    offset: const Offset(0, 4),
    spreadRadius: 0,
  );

  static final cardShadow = BoxShadow(
    color: kGreyColor200.withValues(alpha: 0.9),
    blurRadius: 30,
    offset: const Offset(0, 4),
    spreadRadius: 0,
  );

  static final cardShadowProduct = BoxShadow(
    color: kBlackColor.withValues(alpha: 0.05),
    blurRadius: 27,
    offset: const Offset(2, 4),
    spreadRadius: 0,
  );

  static final cardShadow2 = BoxShadow(
    color: const Color(0xFF000000).withValues(alpha: 0.05),
    blurRadius: 30,
    offset: const Offset(2, 4),
    spreadRadius: 0,
  );


  static final kLanguageShadow = BoxShadow(
    color: const Color(0xFFD6D6D6).withValues(alpha: 0.2),
    blurRadius: 6,
    offset: const Offset(0, 2),
    spreadRadius: 0,
  );

  static final BoxDecoration backgroundGreyShadow100 = BoxDecoration(
    color: kGreyColor100,
    borderRadius: BorderRadius.circular(8).r,
    boxShadow: [
      BoxShadow(
        color: const Color(0xFFE0E1E0).withValues(alpha: 0.4),
        blurRadius: 52,
        offset: const Offset(0, 4),
        spreadRadius: 0,
      )
    ],
  );

  static final BoxDecoration backgroundGreyShadow50 = BoxDecoration(
    color: kGreyColor100,
    borderRadius: BorderRadius.circular(8).r,
    boxShadow: [
      BoxShadow(
        color: const Color(0xFFE0E1E0).withValues(alpha: 1),
        blurRadius: 52,
        offset: const Offset(0, 4),
        spreadRadius: 0,
      )
    ],
  );

  static const selectLinearGradient = LinearGradient(
    colors: [Color(0xFF5632BD), Color(0xFF33b1E7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final kBackGroundShadow2 = BoxShadow(
    color: kGreyColor400.withValues(alpha: 0.4),
    blurRadius: 52,
    offset: const Offset(0, 4),
  );
}
