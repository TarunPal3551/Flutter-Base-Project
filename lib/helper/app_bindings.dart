import 'package:get/get.dart';

import 'package:kmerchant/helper/shared_pref_helper.dart';
import 'package:kmerchant/services/device_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    print("Initializing dependencies");
    Get.lazyPut<DeviceService>(() => DeviceService());
    Get.lazyPut<Pref>(() => Pref().init());
    // Get.lazyPut<MyHomePageController>(() => MyHomePageController());
  }
}
