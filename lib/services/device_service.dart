import 'dart:io';

import 'package:kmerchant/helper/app_utils.dart';
import 'package:kmerchant/helper/constants.dart';






class DeviceService {
  Future initialise() async {
    DEVICE_ID = await AppUtils.getId();
    String platformType = "";
    if (Platform.isAndroid) {
      platformType = "android";
    } else if (Platform.isIOS) {
      platformType = "ios";
    } else {
      platformType = "flutter-other";
    }
    PLATFORM = platformType;
    print("Platform: $PLATFORM");
  }
}
