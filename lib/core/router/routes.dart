import 'package:camerasync/core/notice_board/notice_board.dart';
import 'package:camerasync/features/welcome/starter_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../core/constants/app_strings.dart';


class Routes {
  Routes._internal();

  // ========== [Public] ==========
  static const String splash = "/";
  static const String welcome = "/welcome";
  static const String cameraPreview = "/camera-preview";
  static const String uploadManager = "/upload-manager";

}

class RouteGenerator {
  RouteGenerator._internal();

  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return CupertinoPageRoute(
          builder: (_) => const StarterScreen(),
          settings: routeSettings,
        );

      case Routes.welcome:
        return CupertinoPageRoute(
          builder: (_) => const StarterScreen(),
          settings: routeSettings,
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return CupertinoPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.noPageFound.tr()),
        ),
        body: Center(
          child: Text(AppStrings.noPageFound.tr()),
        ),
      ),
    );
  }
}
