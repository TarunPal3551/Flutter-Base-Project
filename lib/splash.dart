import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kmerchant/mainhome.dart';
import 'package:kmerchant/splashcontroller.dart';
import 'package:kmerchant/theme.dart';

import 'helper/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return mainWidget();
  }

  Widget mainWidget() {
    Future.delayed(const Duration(milliseconds: 2000), () {});
    return GetBuilder<SplashController>(
        init: SplashController(),
        initState: (_) {
          Get.put(SplashController()).handleStartUpLogic().then((value) {
            //checkForUpdate(_);
            // if (ACCESS_TOKEN == null) {
            //   Get.offAll(MainHome());
            // } else {
            //   Get.offAll(MainHome());
            // }
            Get.offAll(MainHome());
          });
        },
        builder: (_) => Scaffold(
              body: Container(
                  color: kAppTheme.accentColor,
                  width: double.infinity,
                  height: double.infinity,
                  child: Icon(
                    Icons.shopping_bag_rounded,
                    size: 100,
                    color: Colors.white,
                  )),
            ));
  }
}
