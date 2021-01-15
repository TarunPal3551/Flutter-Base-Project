import 'dart:io';
import 'dart:math';

import 'package:kmerchant/api/request_helper.dart';
import 'package:kmerchant/helper/api_keys.dart';
import 'package:kmerchant/helper/app_utils.dart';
import 'package:kmerchant/helper/constants.dart';
import 'package:kmerchant/helper/shared_pref_helper.dart';

import 'package:dio/dio.dart';
import 'package:kmerchant/models/apiresponse.dart';
import 'package:kmerchant/models/baseresponse.dart';
import 'package:kmerchant/models/itemcategory.dart';
import 'package:kmerchant/models/loginresponse.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Repository {
  Pref pref;
  RequestHelper req = RequestHelper();

  String get _bearerToken {
    return "Bearer $ACCESS_TOKEN";
  }

  Dio get _dio {
    Dio dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 100000,
      receiveTimeout: 100000,
      headers: {
        "Authorization": _bearerToken,
        "X-Requested-With": "XMLHttpRequest",
      },
      contentType: Headers.formUrlEncodedContentType,
    ));
    //Instance level
    dio.interceptors.add(PrettyDioLogger(requestBody: true));
    return dio;
  }

  Future<LoginResponse> login(String username, String password) async {
    try {
      String deviceId = await AppUtils.getId();
      DEVICE_ID = deviceId;
      String platformType = "unknown";
      if (Platform.isAndroid) {
        platformType = "android";
      } else if (Platform.isIOS) {
        platformType = "ios";
      } else {
        platformType = "flutter-other";
      }
      var data = {
        "username": username,
        "password": password,
        "device_id": FCM_TOKEN,
        "device_platform": platformType,
        "device_uiid": deviceId,
        "code_version": 1,
        "merchant_token": "",
        "api_key": API_KEY,
        "lang": lang,
      };
      //final res = await req.post("api/provider/oauth/token", data, false);
      final res = await _dio.post("api/appLogin", data: data);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final response = ApiResponse.fromJsonString(res.data);
        print('Login Response:$response');

        return LoginResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }

  Future<ItemCategory> getItemCategory() async {
    try {
      String deviceId = await AppUtils.getId();
      DEVICE_ID = deviceId;
      String platformType = "unknown";
      if (Platform.isAndroid) {
        platformType = "android";
      } else if (Platform.isIOS) {
        platformType = "ios";
      } else {
        platformType = "flutter-other";
      }
      var data = {
        "device_id": FCM_TOKEN,
        "device_platform": platformType,
        "device_uiid": deviceId,
        "code_version": 1,
        "merchant_token": ACCESS_TOKEN,
        "api_key": API_KEY,
        "lang": lang,
      };

      final res = await _dio.post("api/getCategoryList", data: data);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final response = ApiResponse.fromJsonString(res.data);
        print('Item Category Response:$response');

        return ItemCategory.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }

  Future<BaseResponse> editItemCategory(Data categoryData, File categoryImage,
      String tittle, String description) async {
    try {
      String deviceId = await AppUtils.getId();
      DEVICE_ID = deviceId;
      String platformType = "unknown";
      if (Platform.isAndroid) {
        platformType = "android";
      } else if (Platform.isIOS) {
        platformType = "ios";
      } else {
        platformType = "flutter-other";
      }
      var dataImage;
      if (categoryImage != null) {
        String imagePath = categoryImage.path.split("/").last;
        dataImage = await MultipartFile.fromFile(categoryImage.path,
            filename: imagePath);
      } else {
        dataImage = null;
      }

      var data = {
        "device_id": FCM_TOKEN,
        "device_platform": platformType,
        "device_uiid": deviceId,
        "code_version": 1,
        "merchant_token": ACCESS_TOKEN,
        "api_key": API_KEY,
        "lang": lang,
        "category_name": tittle,
        "category_description": description,
        "upload_option_name": "photo",
        "upload_next_action": "display_image",
        "upload_type": "1",
        "photo": dataImage,
        "status": categoryData.status,
        "id": categoryData.id
      };

      final res = await _dio.post("api/AddCategory", data: data);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final response = ApiResponse.fromJsonString(res.data);
        print('Item Category Response:$response');
        return BaseResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }
}
