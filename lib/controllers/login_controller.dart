import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kmerchant/api/repository.dart';
import 'package:kmerchant/helper/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  Repository _repo = Repository();

  Future<bool> login(String username, String pass) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final value = await _repo.login(username, pass);
      if (value != null) {
        ACCESS_TOKEN = value.details.merchantInfo.merchantToken;
        preferences.setString("ACCESS_TOKEN", ACCESS_TOKEN);
        print(ACCESS_TOKEN);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Status Code: ${e}");
      return false;
    }
  }
}
