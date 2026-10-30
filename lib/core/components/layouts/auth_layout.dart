import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camerasync/core/components/layouts/auth_title.dart';

import '../../constants/app_colors.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.child,
    required this.pageName,
    this.subtitle,
    this.actions,
    this.leading,
    this.title,
    this.buttonTitle,
    this.isButtonTitle=true,
    this.isBackButton=false,
    this.onTap,
  });

  final String pageName;
  final List<Widget>? actions;
  final Widget child;
  final Widget? leading;
  final Widget? title;
  final String? subtitle;
  final String? buttonTitle;
  final bool isButtonTitle;
  final bool isBackButton;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.kBackgroundColor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120.h,
              pinned: true,
              floating: true,
              snap: false,
              automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: AppColors.kStatusBarColor.withValues(alpha: 0.8),
                  ),
                ),
                collapseMode: CollapseMode.pin,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: Container(
                  height: 115.h,
                  decoration: BoxDecoration(
                    color: AppColors.kBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: AuthTitle(
                    title: pageName,
                    subtitle: subtitle,
                    buttonTitle: buttonTitle,
                    onTap: onTap,
                    isButtonTitle: isButtonTitle,
                    isBackButton: isBackButton,
                  ),
                ),
              ),
              leading: leading,
              title: title,
              actions: actions,
            ),
            SliverToBoxAdapter(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: child,
            )),
          ],
        ),
      ),
    );
  }
}
