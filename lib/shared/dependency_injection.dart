import 'package:get/get.dart';

import 'package:radio_adblocker/shared/network_controller.dart';
/// This class is responsible for initializing the dependency injection.
class DependencyInjection {

  static void init() {
    /// Initialize the NetworkController
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }
}