import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app/camerasync_app.dart';
import 'core/app/app_dependency.dart';
import 'core/app/app_flavor.dart';
import 'core/app_bloc_observer.dart';
import 'core/components/custom_progress_loader.dart';
import 'core/constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set preferred orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // System UI overlay
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.kTransparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ));

  await EasyLocalization.ensureInitialized();

  // Dependency injection & flavor setup
  configureInjection();
  configLoading();
  AppFlavor.appFlavor = FlavorStatus.development;

  // Bloc observer
  Bloc.observer = AppBlocObserver();

  // Run the app
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('de')],
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('de'),
      saveLocale: true,
      path: 'assets/translations',
      child: const CameraSyncApp(),
    )
  );
}
