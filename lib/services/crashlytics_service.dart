import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsService {
  void initialize() {
    Crashlytics.instance.enableInDevMode = true;

    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
  }
//  $myArray = explode('-', $request->selected_date);
//      $month=$myArray[1];
//      $monthAdd=(int)$month+1;
//      $finalDate=$myArray[0]+"-"+$monthAdd+"-"+$myArray[2];
}
