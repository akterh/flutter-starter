import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BackgroundSyncService {
  bool _isInitialized = false;
  bool _hasPermissions = false;

  bool get isInitialized => _isInitialized;
  bool get isRunning => FlutterBackground.isBackgroundExecutionEnabled;

  Future<bool> initialize() async {
    if (!Platform.isAndroid) {
      _isInitialized = true;
      return true;
    }

    if (_isInitialized) return _hasPermissions;

    const androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "CameraSync Engine",
      notificationText: "Background upload sync in progress...",
      notificationImportance: AndroidNotificationImportance.normal,
      notificationIcon: AndroidResource(name: 'ic_launcher', defType: 'mipmap'),
      enableWifiLock: true,
    );

    try {
      _hasPermissions = await FlutterBackground.initialize(androidConfig: androidConfig);
      _isInitialized = true;
      return _hasPermissions;
    } catch (e) {
      debugPrint('FlutterBackground init error: $e');
      _isInitialized = true;
      _hasPermissions = false;
      return false;
    }
  }

  Future<bool> startBackgroundExecution() async {
    if (!Platform.isAndroid) return true;
    try {
      if (!_isInitialized) {
        await initialize();
      }
      if (_hasPermissions && !FlutterBackground.isBackgroundExecutionEnabled) {
        return await FlutterBackground.enableBackgroundExecution();
      }
      return FlutterBackground.isBackgroundExecutionEnabled;
    } catch (e) {
      debugPrint('FlutterBackground enable error: $e');
      return false;
    }
  }

  Future<bool> stopBackgroundExecution() async {
    if (!Platform.isAndroid) return true;
    try {
      if (FlutterBackground.isBackgroundExecutionEnabled) {
        return await FlutterBackground.disableBackgroundExecution();
      }
      return true;
    } catch (e) {
      debugPrint('FlutterBackground disable error: $e');
      return false;
    }
  }
}
