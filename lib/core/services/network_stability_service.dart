import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum NetworkQuality {
  stable,
  unstable, // high latency or low bandwidth
  offline,
}

@lazySingleton
class NetworkStabilityService {
  final Connectivity _connectivity = Connectivity();
  final InternetConnection _internetChecker = InternetConnection.createInstance(
    checkInterval: const Duration(seconds: 3),
    customCheckOptions: [
      InternetCheckOption(uri: Uri.parse('https://1.1.1.1')),
      InternetCheckOption(uri: Uri.parse('https://8.8.8.8')),
      InternetCheckOption(uri: Uri.parse('https://www.google.com')),
    ],
  );

  final _qualityController = StreamController<NetworkQuality>.broadcast();
  Stream<NetworkQuality> get onQualityChange => _qualityController.stream;

  NetworkQuality _currentQuality = NetworkQuality.offline;
  NetworkQuality get currentQuality => _currentQuality;

  StreamSubscription? _connectivitySub;
  StreamSubscription? _statusSub;
  Timer? _stabilityTimer;

  NetworkStabilityService() {
    _initMonitoring();
  }

  void _initMonitoring() {
    // Initial check
    checkConnectionQuality();

    // Listen to network interface changes
    _connectivitySub = _connectivity.onConnectivityChanged.listen((results) {
      checkConnectionQuality();
    });

    // Listen to real reachability changes
    _statusSub = _internetChecker.onStatusChange.listen((status) {
      if (status == InternetStatus.connected) {
        _verifyStability();
      } else {
        _updateQuality(NetworkQuality.offline);
      }
    });

    // Periodic ping verification every 10 seconds
    _stabilityTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      checkConnectionQuality();
    });
  }

  Future<NetworkQuality> checkConnectionQuality() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        _updateQuality(NetworkQuality.offline);
        return NetworkQuality.offline;
      }

      final hasInternet = await _internetChecker.hasInternetAccess;
      if (!hasInternet) {
        _updateQuality(NetworkQuality.offline);
        return NetworkQuality.offline;
      }

      return await _verifyStability();
    } catch (_) {
      _updateQuality(NetworkQuality.offline);
      return NetworkQuality.offline;
    }
  }

  Future<NetworkQuality> _verifyStability() async {
    final stopwatch = Stopwatch()..start();
    try {
      // Fast DNS lookup test to test real responsiveness
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      stopwatch.stop();

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final latencyMs = stopwatch.elapsedMilliseconds;
        // If latency is high, mark unstable/low bandwidth
        if (latencyMs > 1500) {
          _updateQuality(NetworkQuality.unstable);
          return NetworkQuality.unstable;
        } else {
          _updateQuality(NetworkQuality.stable);
          return NetworkQuality.stable;
        }
      } else {
        _updateQuality(NetworkQuality.offline);
        return NetworkQuality.offline;
      }
    } catch (_) {
      _updateQuality(NetworkQuality.offline);
      return NetworkQuality.offline;
    }
  }

  void _updateQuality(NetworkQuality quality) {
    if (_currentQuality != quality) {
      _currentQuality = quality;
      if (!_qualityController.isClosed) {
        _qualityController.add(quality);
      }
    }
  }

  bool get isConnectedAndStable => _currentQuality == NetworkQuality.stable;

  void dispose() {
    _connectivitySub?.cancel();
    _statusSub?.cancel();
    _stabilityTimer?.cancel();
    _qualityController.close();
  }
}
