import 'package:camerasync/core/app/app_context.dart';
import 'package:camerasync/core/components/custom_button.dart';
import 'package:camerasync/core/constants/app_colors.dart';
import 'package:camerasync/core/constants/app_text_style.dart';
import 'package:camerasync/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Hero Icon / Brand Card
              Center(
                child: Container(
                  width: 130.r,
                  height: 130.r,
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: AppColors.kWhiteColor,
                    borderRadius: BorderRadius.circular(32.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kSecondaryColor500.withValues(alpha: 0.12),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: FlutterLogo(size: 80),
                  ),
                ),
              ),

              36.verticalSpace,

              // Welcome Title
              Text(
                'Welcome to CameraSync',
                style: kHeading4.copyWith(
                  color: AppColors.kFontBaseColor1,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              12.verticalSpace,

              // Subtitle
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Capture, synchronize and manage your workflow seamlessly in real time.',
                  style: kBodyRegularMedium.copyWith(
                    color: AppColors.kFontColor2.withValues(alpha: 0.75),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const Spacer(flex: 3),

              // Start Now Button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  title: 'Start Now',
                  borderRadius: 16.r,
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  onTap: () {
                    AppContext.toNamed(route: Routes.cameraPreview);
                  },
                ),
              ),

              32.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
