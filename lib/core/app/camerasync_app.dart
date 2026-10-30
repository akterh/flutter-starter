import 'package:camerasync/core/local_database/db_tables/db_tables.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camerasync/features/theme/app_theme.dart';
import 'package:camerasync/features/theme/cubit/theme_cubit.dart';
import '../router/routes.dart';
import 'app_context.dart';
import 'app_providers.dart';

class CameraSyncApp extends StatefulWidget {
  const CameraSyncApp({super.key});

  @override
  State<CameraSyncApp> createState() => _CameraSyncAppState();
}

class _CameraSyncAppState extends State<CameraSyncApp> {
  @override
  void initState() {
    super.initState();
    AppContext.hiveService.init();
    DBTables.registerAdapter();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppProviders.providers,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return ScreenUtilInit(
            designSize: const Size(430, 932),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (BuildContext context, Widget? child) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: MaterialApp(
                  title: 'CameraSync',
                  scrollBehavior: ScrollConfiguration.of(context)
                      .copyWith(physics: const BouncingScrollPhysics()),
                  debugShowCheckedModeBanner: false,
                  navigatorKey: AppContext.navigatorKey,
                  theme: AppTheme.lightTheme,
                  builder: (context, child) {
                    // Chain the builders
                    child = EasyLoading.init()(context, child);
                    // Add overlay support
                    return Overlay(
                      initialEntries: [
                        OverlayEntry(
                            builder: (context) =>
                                child ?? const SizedBox()),
                      ],
                    );
                  },
                  onGenerateRoute: RouteGenerator.getRoute,
                  initialRoute: Routes.splash,
                  localizationsDelegates: [
                    ...context.localizationDelegates,
                  ],
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
