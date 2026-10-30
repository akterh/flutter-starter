import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camerasync/core/constants/app_colors.dart';
import 'package:camerasync/core/constants/app_text_style.dart';


class InnerLayout extends StatelessWidget {
  const InnerLayout({
    super.key,
    this.leading,
    this.title,
    required this.body,
    this.isShowCoverImage = true,
    this.isShowBodyGradientColor = true,
  });

  final Widget? leading;
  final String? title;
  final Widget body;
  final bool isShowCoverImage;
  final bool isShowBodyGradientColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor700,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildCoverImage(),
          _buildActionBar(),
          _buildGradientContainer(context),
        ],
      ),
    );
  }

  Widget _buildCoverImage() {
    return const SizedBox.shrink();
  }

  Positioned _buildActionBar() {
    return Positioned(
      top: 50,
      left: 20,
      child: Row(
        children: [
          if (leading != null) leading!,
          if (title != null) 16.horizontalSpace,
          if (title != null)
            Text(
              title!,
              style: kBodyLarge.copyWith(color: AppColors.kWhiteColor),
            ),
        ],
      ),
    );
  }

  Align _buildGradientContainer(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.86,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
          gradient: isShowBodyGradientColor
              ? LinearGradient(
                  colors: [AppColors.kPrimaryColor100, AppColors.kSecondaryColor300],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
        ),
        padding: REdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: body,
      ),
    );
  }
}
