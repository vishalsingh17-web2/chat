import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class InternetProvider extends ChangeNotifier {
  bool isConnected = false;
  InternetProvider() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
      } else {
        isConnected = true;
      }
    });
    notifyListeners();
  }

  void checkConnection() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
      } else {
        isConnected = true;
      }
    });
    notifyListeners();
  }
}
