import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService._();
  static final ConnectivityService instance = ConnectivityService._();

  final _controller = StreamController<bool>.broadcast();
  Stream<bool> get stream => _controller.stream;

  bool _initialized = false;

  /// Initialize once
  void initialize() {
    if (_initialized) return;
    _initialized = true;

    Connectivity().onConnectivityChanged.listen((results) {
      final connected = results.any(
            (e) =>
        e == ConnectivityResult.mobile ||
            e == ConnectivityResult.wifi ||
            e == ConnectivityResult.ethernet,
      );

      _controller.add(connected);
    });
  }

  /// API check
  Future<bool> isConnected() async {
    final results = await Connectivity().checkConnectivity();

    return results.any(
          (e) =>
      e == ConnectivityResult.mobile ||
          e == ConnectivityResult.wifi ||
          e == ConnectivityResult.ethernet,
    );
  }

  void dispose() => _controller.close();
}