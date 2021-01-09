import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'package:kmerchant/helper/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    print("FCM Initalizing");
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.getToken().then((value) async {
      setFcmToken(value);
    });

    _fcm.configure(
      //Called when app is in foreground and we recieve a message
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        await myBackgroundMessageHandler(message);
      },
      //Called when the app has been closed completely and is opened from the notification panel
      //using the push notification
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        await myBackgroundMessageHandler(message);
      },
      //Called when the app is in background and is opened from the notification panel
      //using the push notification
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        await myBackgroundMessageHandler(message);
      },
    );
  }

  void setFcmToken(String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("fcm_token", value);
    FCM_TOKEN = value;
    print("FCM Token: $value");
  }

  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];

    if (view != null) {
      // Navigate to the create post view
      if (view == 'create_post') {
        //_navigationService.navigateTo(CreatePostViewRoute);
        //Get.to(); Go to some page
      }
      // If there's no view it'll just open the app on the first view
    }
  }
}
