// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:camerasync/core/app/app_dependency.dart' as _i573;
import 'package:camerasync/core/app/app_preference.dart' as _i956;
import 'package:camerasync/core/local_database/db_service/hive_database_service.dart'
    as _i763;
import 'package:camerasync/core/services/background_sync_service.dart' as _i865;
import 'package:camerasync/core/services/network_stability_service.dart'
    as _i829;
import 'package:camerasync/data/network/api_client.dart' as _i266;
import 'package:camerasync/data/network/api_request.dart' as _i340;
import 'package:camerasync/features/theme/cubit/theme_cubit.dart' as _i181;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.factory<_i956.AppPreferences>(() => _i956.AppPreferences());
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => appModule.prefs,
    preResolve: true,
  );
  gh.factory<_i361.Dio>(() => appModule.dio);
  gh.factory<_i763.HiveDatabaseService>(() => _i763.HiveDatabaseService());
  gh.factory<_i181.ThemeCubit>(() => _i181.ThemeCubit());
  gh.factory<_i340.ApiRequest>(() => _i340.ApiRequest());
  gh.lazySingleton<_i829.NetworkStabilityService>(
      () => _i829.NetworkStabilityService());
  gh.lazySingleton<_i865.BackgroundSyncService>(
      () => _i865.BackgroundSyncService());
  gh.factory<_i266.ApiClient>(() => _i266.ApiClient(gh<_i361.Dio>()));
  return getIt;
}

class _$AppModule extends _i573.AppModule {}
