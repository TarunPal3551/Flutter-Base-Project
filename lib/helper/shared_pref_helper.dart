import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static SharedPreferences prefs;
  Pref() {
    //empty constructor
  }

  init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  clear() async {
    if (prefs != null) {
      prefs.clear();
    }
  }

  String getString(String key, String defaultValue) {
    final s = prefs.getString(key);
    if (s == null) {
      return defaultValue;
    } else {
      return s;
    }
  }

  Future<bool> setString(String key, String value) async {
    final res = await prefs.setString(key, value);
    return res;
  }

  int getInt(String key) {
    try {
      return prefs.getInt(key);
    } on Exception catch (e) {
      return 0;
    }
  }

  Future<bool> setInt(String key, int value) async {
    final res = await prefs.setInt(key, value);
    return res;
  }

  bool getBool(String key) {
    try {
      return prefs.getBool(key);
    } on Exception catch (e) {
      return false;
    }
  }

  Future<bool> setBool(String key, bool value) async {
    final res = await prefs.setBool(key, value);
    return res;
  }

  double getDouble(String key) {
    try {
      return prefs.getDouble(key);
    } on Exception catch (e) {
      return 0.0;
    }
  }

  Future<bool> setDouble(String key, double value) async {
    final res = await prefs.setDouble(key, value);
    return res;
  }
}
