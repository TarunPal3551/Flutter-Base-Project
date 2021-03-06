import 'dart:io';
import 'dart:math';

import 'package:kmerchant/api/request_helper.dart';
import 'package:kmerchant/helper/api_keys.dart';
import 'package:kmerchant/helper/app_utils.dart';
import 'package:kmerchant/helper/constants.dart';
import 'package:kmerchant/helper/shared_pref_helper.dart';

import 'package:dio/dio.dart';
import 'package:kmerchant/models/addoncategory.dart' as addoncategory;
import 'package:kmerchant/models/addoncategory.dart';
import 'package:kmerchant/models/addonitem.dart';
import 'package:kmerchant/models/addonitem.dart' as addonitem;
import 'package:kmerchant/models/addonitemdetails.dart';
import 'package:kmerchant/models/addonitemdetails.dart' as itemdetails;
import 'package:kmerchant/models/apiresponse.dart';
import 'package:kmerchant/models/baseresponse.dart';
import 'package:kmerchant/models/fooditems.dart';
import 'package:kmerchant/models/itemcategory.dart' as itemcategory;
import 'package:kmerchant/models/itemcategory.dart';
import 'package:kmerchant/models/loginresponse.dart';
import 'package:kmerchant/models/uploadresponse.dart';
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

  Future<BaseResponse> editItemCategory(
      itemcategory.Data categoryData,
      String categoryImage,
      String url,
      String tittle,
      String description,
      String isChecked) async {
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
        "category_name": tittle,
        "category_description": description,
        "upload_option_name": "photo",
        "upload_next_action": "display_image",
        "upload_type": "1",
        "photo": categoryImage,
        "thumbnail": url,
        "status": isChecked,
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

  Future<BaseResponse> deleteCategory(String id) async {
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
        "id": id
      };

      final res = await _dio.post("api/CategoryDelete", data: data);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final response = ApiResponse.fromJsonString(res.data);
        print('Category Delete Response:$response');
        return BaseResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }

  Future<AddonCategory> getAddonItemCategory() async {
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

      final res = await _dio.post("api/getAddonList", data: data);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final response = ApiResponse.fromJsonString(res.data);
        print('Addon Item Category Response:$response');

        return AddonCategory.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }

  Future<BaseResponse> editAddonItemCategory(addoncategory.Data categoryData,
      String tittle, String description, String isChecked) async {
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
        "subcategory_name": tittle,
        "subcategory_description": description,
        "status": isChecked,
        "id": categoryData.id
      };

      final res = await _dio.post("api/AddAddon", data: data);
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

  Future<BaseResponse> deleteAddonCategory(String id) async {
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
        "id": id
      };

      final res = await _dio.post("api/AddonDelete", data: data);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final response = ApiResponse.fromJsonString(res.data);
        print('Category Delete Response:$response');
        return BaseResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }

  Future<AddonItem> getAddonItem() async {
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

      final res = await _dio.post("api/getAddonItemList", data: data);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final response = ApiResponse.fromJsonString(res.data);
        print('Addon Item Category Response:$response');

        return AddonItem.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }

  Future<AddonItemDetails> getAddonItemInfo(String id) async {
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
        "id": id
      };

      final res = await _dio.post("api/AddonItemGetByID", data: data);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final response = ApiResponse.fromJsonString(res.data);
        print('Addon Item Category Response:$response');

        return AddonItemDetails.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }

  Future<BaseResponse> editAddonItem(
      itemdetails.Data categoryData,
      String categoryImage,
      String url,
      String tittle,
      String description,
      String price,
      List<String> selectedCategory,
      String isChecked) async {
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
      final _formData = FormData.fromMap({});
      _formData.fields.add(MapEntry('device_id', FCM_TOKEN));
      _formData.fields.add(MapEntry('device_platform', platformType));
      _formData.fields.add(MapEntry('device_uiid', deviceId));
      _formData.fields.add(MapEntry('code_version', codeVersion));
      _formData.fields.add(MapEntry('merchant_token', ACCESS_TOKEN));
      _formData.fields.add(MapEntry('api_key', API_KEY));
      _formData.fields.add(MapEntry('lang', lang));
      _formData.fields.add(MapEntry('sub_item_name', tittle));
      _formData.fields.add(MapEntry('item_description', description));
      _formData.fields.add(MapEntry('price', price));
      _formData.fields.add(MapEntry(
          'addoncat_list', selectedCategory.length.toString() + " selected"));
      _formData.fields.add(MapEntry('upload_next_action', "display_image"));
      _formData.fields.add(MapEntry('upload_option_name', "photo"));
      _formData.fields.add(MapEntry('upload_type', "1"));
      _formData.fields.add(MapEntry('photo', categoryImage));
      _formData.fields.add(MapEntry('thumbnail', url));
      _formData.fields.add(MapEntry('status', isChecked));
      if (categoryData.subItemId != null) {
        _formData.fields.add(MapEntry('id', categoryData.subItemId));
      }

      for (int i = 0; i < selectedCategory.length; i++) {
        _formData.fields
            .add(MapEntry('category[]', selectedCategory.elementAt(i)));
      }
      final res = await _dio.post("api/AddAddonItem", data: _formData);
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

  Future<BaseResponse> deleteAddonItem(String id) async {
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
        "id": id
      };

      final res = await _dio.post("api/AddonItemDelete", data: data);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final response = ApiResponse.fromJsonString(res.data);
        print('AddonItemDelete Response:$response');
        return BaseResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }

  Future<FoodItems> getFoodItems() async {
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

      final res = await _dio.post("api/ItemList", data: data);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final response = ApiResponse.fromJsonString(res.data);
        print('Foood Item  Response:$response');

        return FoodItems.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }

  Future<BaseResponse> editFoodItem(
      addonitem.Data categoryData,
      String categoryImage,
      String url,
      String tittle,
      String description,
      String price,
      Map<String, String> selectedCategory,
      String isChecked) async {
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
        "sub_item_name": tittle,
        "item_description": description,
        "price": price,
        "addoncat_list": selectedCategory.length.toString() + " selected",
        "upload_option_name": "photo",
        "upload_next_action": "display_image",
        "upload_type": "1",
        "photo": categoryImage,
        "thumbnail": url,
        "status": isChecked,
        "id": categoryData.id,
      };
      data.addAll(selectedCategory);

      final res = await _dio.post("api/AddAddonItem", data: data);
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

  Future<BaseResponse> deleteFoodItem(String id) async {
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
        "id": id
      };

      final res = await _dio.post("api/ItemDelete", data: data);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final response = ApiResponse.fromJsonString(res.data);
        print('AddonItemDelete Response:$response');
        return BaseResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }

  Future<UploadResponse> uploadFile(File categoryImage) async {
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

      var data = FormData.fromMap({
        "device_id": FCM_TOKEN,
        "device_platform": platformType,
        "device_uiid": deviceId,
        "code_version": 1,
        "merchant_token": ACCESS_TOKEN,
        "api_key": API_KEY,
        "lang": lang,
        "upload_option_name": "photo",
        "upload_next_action": "display_image",
        "upload_type": "2",
        "file": dataImage
      });

      final res = await _dio.post("/api/UploadFile", data: data);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final response = ApiResponse.fromJsonString(res.data);
        print('Upload Response:$response');
        return UploadResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }
}
