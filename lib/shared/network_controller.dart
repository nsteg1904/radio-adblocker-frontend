import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_adblocker/shared/colors.dart';
class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
/// The method listens to the changes in the connectivity status and shows a snackbar if the internet connection is lost.
  @override
  void onInit() {
    super.onInit();
    /// Check the initial connectivity status.
    _connectivity.checkConnectivity().then((result) {
      _updateConnectionStatus(result);
    });
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
/// The method shows a snackbar if the internet connection is lost.
  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    /// Show a snackbar if the internet connection is lost.
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: const Text(
              'Keine Internetverbindung. Bitte verbinden Sie sich mit dem Internet.
              style: TextStyle(
                  color: defaultFontColor,
                  fontSize: 14
              )
          ),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: selectedElementColor!,
          icon : const Icon(Icons.wifi_off, color: defaultFontColor, size: 35,),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED
      );
    } else {
      /// Close the snackbar if the internet connection is restored.
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}