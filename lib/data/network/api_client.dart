import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:camerasync/core/app/app_context.dart';
import 'package:camerasync/core/components/custom_progress_loader.dart';
import 'package:camerasync/core/constants/app_strings.dart';
import 'package:camerasync/core/utils/snackbar_helper.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/app/app_dependency.dart';
import '../../core/app/app_preference.dart';
import '../../core/router/routes.dart';
import 'api_urls.dart';
import 'http_method.dart';

const String applicationJson = "application/json";
const String contentType = "Content-Type";
const String accept = "Accept";
const String authorization = "Authorization";
const String platform = "App-Platform";
const String appVersion = "App-Version";
const String language = "language";
const String active = "active";
String platformStatus = Platform.isAndroid ? "android" : 'ios';

@Injectable()
class ApiClient {
  final AppPreferences _appPreferences;
  final Dio _dio;
  final InternetConnectionChecker _internetConnectionChecker =
      InternetConnectionChecker();

  ApiClient(this._dio) : _appPreferences = instance.get<AppPreferences>() {
    initInterceptors();
  }

  void initInterceptors() {
    _dio.options.baseUrl = ApiUrls.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 120);
    _dio.options.receiveTimeout = const Duration(seconds: 120);
    _dio.options.sendTimeout = const Duration(seconds: 120);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final hasInternet =
              await _internetConnectionChecker.hasInternetConnection();

          if (!hasInternet) {
            error(
              title: AppStrings.error.tr(),
              subtitle: AppStrings.noInternetConnection.tr(),
            );
            dismissProgressDialog();
            return handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.connectionError,
                error: AppStrings.noInternetConnection.tr(),
              ),
            );
          }

          final headers = await _buildHeaders();
          options.headers.addAll(headers);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (err, handler) async {
          if (err.response?.statusCode == 401) {
            log('❌ Unauthorized — redirecting to Login');
            await _appPreferences.logout();
            dismissProgressDialog();
            Future.delayed(Duration(milliseconds: 500), () {
              AppContext.offAll(Routes.welcome);
            });

            return;
          }

          handler.next(err);
        },
      ),
    );
    _dio.interceptors
        .add(PrettyDioLogger(requestBody: true, requestHeader: true));
  }

  Future<Map<String, String>> _buildHeaders() async {
    final headers = {
      contentType: applicationJson,
      accept: applicationJson,
      active: 'true',
      language: AppContext.context.locale.languageCode,
    };
    // const accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC44OC4yMjo4MDAwL2FwaS9tb2JpbGUvbG9naW4iLCJpYXQiOjE3NjA5Njc2MjgsImV4cCI6MTc2MTA1NDAyOCwibmJmIjoxNzYwOTY3NjI4LCJqdGkiOiI5MmxDdDhBb2xxa0xyZ0JUIiwic3ViIjoiMTIiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3IiwiaWQiOjEyfQ.H0li8La-egNymL16GO_TIXf7ZLgWsyHgDL0Fm3Y9sC8";
    var accessToken = await _appPreferences.getUserToken();
    log("token=>$accessToken");
    if (accessToken.isNotEmpty) {
      headers[authorization] = "Bearer $accessToken";
    }

    return headers;
  }

  Future<dynamic> request({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? params,
    FormData? formData,
    bool isMultipart = false,
    bool isEnableLoader = true,
    ProgressCallback? onSendProgress, // Added callback for upload progress
    ProgressCallback? onReceiveProgress, // Added callback for download progress
  }) async {
    log('[${method.name.toUpperCase()}${isMultipart ? '-MULTIPART' : ''}] Request url ======> ${_dio.options.baseUrl}$url');
    log('Request params ======> ${isMultipart ? (formData!.fields.toString() + formData.files.toString()) : params}');
    if (isEnableLoader) showProgressDialog();
    try {
      Response response;
      switch (method) {
        case HttpMethod.post:
          response = isMultipart && formData != null
              ? await _dio.post(url,
                  data: formData,
                  onSendProgress: onSendProgress,
                  onReceiveProgress: onReceiveProgress)
              : await _dio.post(url,
                  data: params,
                  onSendProgress: onSendProgress,
                  onReceiveProgress: onReceiveProgress);
          break;
        case HttpMethod.delete:
          response = await _dio.delete(url);
          break;
        case HttpMethod.put:
          response = isMultipart && formData != null
              ? await _dio.put(url,
                  data: formData,
                  onSendProgress: onSendProgress,
                  onReceiveProgress: onReceiveProgress)
              : await _dio.put(url,
                  data: params,
                  onSendProgress: onSendProgress,
                  onReceiveProgress: onReceiveProgress);
          break;
        case HttpMethod.get:
          response = await _dio.get(url,
              queryParameters: params, onReceiveProgress: onReceiveProgress);
          break;
        default:
          throw UnsupportedError("Unsupported HTTP method");
      }
      dismissProgressDialog();

      log("response==========> ${_dio.options.baseUrl}$url ${response.data}");
      return response.data;
    } on DioException catch (error) {
      dismissProgressDialog();
      log('DioError: $error');
      rethrow;
    } catch (error) {
      dismissProgressDialog();
      log('Error: $error');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> downloadFile(
      {required String url,
      Map<String, dynamic>? queryParameters,
      required ProgressCallback onReceiveProgress}) async {
    Map<String, dynamic> result = {};
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath =
          '${dir.path}/${DateTime.now().millisecondsSinceEpoch}audio.mp3'; // change name if needed
      Response response = await _dio.download(url, filePath,
          queryParameters: queryParameters,
          onReceiveProgress: onReceiveProgress);

      if (response.statusCode == 200) {
        result.addAll({"status": true, "path": filePath});
      } else {
        result.addAll({"status": false, "path": ""});
      }
    } catch (e) {
      result.addAll({"status": false, "path": ""});
    }
    return result;
  }
}

class InternetConnectionChecker {
  final String testUrl = 'https://www.google.com';

  Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      // If there’s no active connection at all
      if (connectivityResult.contains(ConnectivityResult.none)) return false;

      // Check actual internet access
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _checkInternetAccess() async {
    try {
      final response =
          await http.get(Uri.parse(testUrl)).timeout(Duration(seconds: 10));
      return response.statusCode == 200;
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    }
  }
}
