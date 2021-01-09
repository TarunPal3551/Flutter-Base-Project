import 'dart:io';

import 'package:kmerchant/api/request_helper.dart';
import 'package:kmerchant/helper/constants.dart';
import 'package:kmerchant/helper/shared_pref_helper.dart';

import 'package:dio/dio.dart';
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

  // Future<OrderResponse> getOrders() async {
  //   try {
  //     final result = await _dio.post("api/rider/orders");
  //     if (result.statusCode >= 200 && result.statusCode < 300) {
  //       return OrderResponse.fromJson(result.data);
  //     } else {
  //       return null;
  //     }
  //   } on Exception catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // Future<EarningResponse> getEarnings() async {
  //   try {
  //     final result = await _dio.get("api/rider/earnings");
  //     if (result.statusCode >= 200 && result.statusCode < 300) {
  //       return EarningResponse.fromJson(result.data);
  //     } else {
  //       return null;
  //     }
  //   } on Exception catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // Future<OrderUpdateResponse> changeServiceStatus(
  //     String status, int orderId) async {
  //   var data = {"order_status": status, "order_id": orderId};
  //   final res = await _dio.post("api/rider/orders/change", data: data);
  //   if (res.statusCode >= 200 && res.statusCode < 300) {
  //     return OrderUpdateResponse.fromJson(res.data);
  //   } else {
  //     return null;
  //   }
  // }

  // Future<SyncData> syncHome(String lat, String long) async {
  //   var data = {"lat": lat, "long": long};
  //   final res = await _dio.post("api/rider/sync", data: data);
  //   if (res.statusCode >= 200 && res.statusCode < 300) {
  //     return SyncData.fromJson(res.data);
  //   } else {
  //     return null;
  //   }
  // }

// Future<ServiceAssoc> addServices(String categories) async {
//   try {
//     var data = {
//       "categories" : categories
//     };
//     final result = await _dio.post("api/provider/profile/services/add",data: data);
//     if (result.statusCode >= 200 && result.statusCode < 300) {
//       return ServiceAssoc.fromJson(result.data);
//     } else {
//       return null;
//     }
//   } on Exception catch (e) {
//     print(e.toString());
//     return null;
//   }
// }
//
// Future changePassword(
//     String oldPassword, String newPassword, String confirmPassword) async {
//   try {
//     var data = {
//       "password_old": oldPassword,
//       "password": newPassword,
//       "password_confirmation": confirmPassword,
//     };
//     final res = await _dio.post("api/provider/profile/password", data: data);
//     if (res.statusCode >= 200 && res.statusCode < 300) {
//       return res.data;
//     } else {
//       return null;
//     }
//   } on DioError catch (e) {
//     print(e.error);
//   }
// }
//
// Future<ProfileModel> updateProfile(
//   String firstName,
//   String lastName,
//   String email,
//   String mobile,
//   File avatar,
// ) async {
//   try {
//     FormData formData = FormData.fromMap({
//       "first_name": firstName,
//       "last_name": lastName,
//       "mobile": mobile,
//       "email": email,
//     });
//
//     if (avatar != null) {
//       String fileName = avatar.path.split('/').last;
//       formData.files.add(
//         MapEntry(
//           "avatar",
//           await MultipartFile.fromFile(avatar.path, filename: fileName),
//         ),
//       );
//     }
//
//     final res = await _dio.post("api/provider/profile", data: formData);
//     if (res.statusCode >= 200 && res.statusCode < 300) {
//       return ProfileModel.fromJson(res.data);
//     } else {
//       return null;
//     }
//   } on DioError catch (e) {
//     print(e.error);
//   }
// }
//
//   Future<Rider> updateProfile(
//       File avatar, String name, String pass, String cpass) async {
//     String avatar_path;
//     var image;
//     if (avatar != null) {
//       avatar_path = avatar.path.split('/').last;
//       image = await MultipartFile.fromFile(avatar.path, filename: avatar_path);
//     } else {
//       image = null;
//     }

//     if (pass.isEmpty) pass = null;
//     if (cpass.isEmpty) cpass = null;
//     var data = FormData.fromMap({
//       "avatar": image,
//       "name": name,
//       "pass": pass,
//       "cpass": cpass,
//     });

//     try {
//       final response = await _dio.post(
//         "/api/rider/profile/edit",
//         data: data,
//       );
//       print(response.data);
//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         return Rider.fromJson(response.data);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   Future<bool> uploadDocuments(
//       File dl_photo,
//       File vehicle_photo,
//       File avatar,
//       String dl_no,
//       String vehicle_color,
//       String vehicle_no,
//       String vehicle_name) async {
//     String dl_path = dl_photo.path.split('/').last;
//     String vehicle_path = vehicle_photo.path.split('/').last;
//     String avatar_path = avatar.path.split('/').last;
//     FormData formData = FormData();
//     formData.files.addAll([
//       MapEntry(
//         "dl_photo",
//         await MultipartFile.fromFile(
//           dl_photo.path,
//           filename: dl_path,
//         ),
//       ),
//       MapEntry(
//         "vehicle_photo",
//         await MultipartFile.fromFile(
//           vehicle_photo.path,
//           filename: vehicle_path,
//         ),
//       ),
//       MapEntry(
//         "avatar",
//         await MultipartFile.fromFile(
//           avatar.path,
//           filename: avatar_path,
//         ),
//       )
//     ]);

//     var data = FormData.fromMap({
//       "dl_photo":
//           await MultipartFile.fromFile(dl_photo.path, filename: dl_path),
//       "vehicle_photo":
//           await MultipartFile.fromFile(dl_photo.path, filename: dl_path),
//       "avatar": await MultipartFile.fromFile(dl_photo.path, filename: dl_path),
//       "dl_no": dl_no,
//       "vehicle_name": vehicle_name,
//       "vehicle_color": vehicle_color,
//       "vehicle_no": vehicle_no
//     });
//     print(data);

//     try {
//       final response = await _dio.post(
//         "/api/rider/documents",
//         data: data,
//       );
//       print(response.data);
//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

// //
// // Future<List<ChatModel>> postchat(
// //     int userId, int orderId, String message) async {
// //   try {
// //     var data = {'user_id': userId, 'order_id': orderId, 'message': message};
// //     final res = await _dio.post("api/provider/chat/new", data: data);
// //     if (res.statusCode >= 200 && res.statusCode < 300) {
// //       List<ChatModel> list = List<ChatModel>();
// //       res.data.forEach((v) {
// //         list.add(ChatModel.fromJson(v));
// //       });
// //       return list;
// //     } else {
// //       return null;
// //     }
// //   } on DioError catch (e) {
// //     print(e.error);
// //   }
// // }
// //
// // Future<List<ChatModel>> loadChat(int userId, int orderId) async {
// //   try {
// //     var data = {'user_id': userId, 'order_id': orderId};
// //     final res = await _dio.post("api/provider/chat/new", data: data);
// //     if (res.statusCode >= 200 && res.statusCode < 300) {
// //       List<ChatModel> list = List<ChatModel>();
// //       res.data.forEach((v) {
// //         list.add(ChatModel.fromJson(v));
// //       });
// //       return list;
// //     } else {
// //       return null;
// //     }
// //   } on DioError catch (e) {
// //     print(e.error);
// //   }
// // }
// //
//   Future<LoginResponse> login(String username, String password) async {
//     try {
//       var data = {
//         "phone": username,
//         "password": password,
//         "fcm_token": FCM_TOKEN,
//         "long": LONGITUDE,
//         "lat": LATITUDE,
//       };
//       //final res = await req.post("api/provider/oauth/token", data, false);
//       final res = await _dio.post("api/rider/login", data: data);
//       if (res.statusCode >= 200 && res.statusCode < 300) {
//         return LoginResponse.fromJson(res.data);
//       } else {
//         return null;
//       }
//     } on DioError catch (e) {
//       print(e.error);
//     }
//   }

//   Future<Register> signup(String fname, String mobile, String password) async {
//     try {
//       String deviceId = await AppUtils.getId();
//       String platformType = "unknown";
//       if (Platform.isAndroid) {
//         platformType = "android";
//       } else if (Platform.isIOS) {
//         platformType = "ios";
//       } else {
//         platformType = "flutter-other";
//       }

//       var data = {
//         'name': fname,
//         'phone': mobile,
//         'password': password,
//         'status': 0
//       };

//       final result = await _dio.post("api/rider/register", data: data);
//       if (result.statusCode >= 200 && result.statusCode < 300) {
//         return Register.fromJson(result.data);
//       } else if (result.statusCode == 422) {
//         print("Data Tarun" + result.data);
//       } else {
//         print(result.redirects);
//         return null;
//       }
//     } on Exception catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

//
// Future<Provider> refreshToken(String username, String password) async {
//   var data = {
//     "email": username,
//     "password": password,
//     "device_token": FCM_TOKEN,
//     "device_id": DEVICE_ID,
//     "device_type": PLATFORM,
//   };
//   //final res = await req.post("api/provider/oauth/token", data, false);
//   final res = await _dio.post("api/provider/oauth/token", data: data);
//   if (res.statusCode >= 200 && res.statusCode < 300) {
//     return Provider.fromJson(res.data);
//   } else {
//     return null;
//   }
// }
//
// Future<WalletTransaction> getWalletTransactions() async {
//   try {
//     final res = await _dio.get("api/provider/wallettransaction");
//     if (res.statusCode >= 200 && res.statusCode < 300) {
//       return WalletTransaction.fromJson(res.data);
//     } else {
//       return null;
//     }
//   } on DioError catch (e) {
//     print(e.error);
//   }
// }
//
// Future<Earning> getEarnings() async {
//   try {
//     final res = await _dio.get("api/provider/target");
//     if (res.statusCode >= 200 && res.statusCode < 300) {
//       return Earning.fromJson(res.data);
//     } else {
//       return null;
//     }
//   } on DioError catch (e) {
//     print(e.error);
//   }
// }
//
// Future<Trip> getTrip() async {
//   try {
//     final res = await _dio
//         .get("/api/provider/trip?latitude=$LATITUDE&longitude=$LONGITUDE");
//     if (res.statusCode >= 200 && res.statusCode < 300) {
//       return Trip.fromJson(res.data);
//     } else if (res.statusCode == 401) {
//       Get.off(LoginScreen());
//     } else {
//       return null;
//     }
//   } on DioError catch (e) {
//     if (e.response.statusCode == 401) {
//       Get.off(LoginScreen());
//     }
//     print(e.error);
//   }
// }
//
// Future<CheckUpdate> checkUpdate() async {
//   var data = {
//     "version": RootConfig.versionNo,
//     "device_type": PLATFORM,
//     "sender": "provider"
//   };
//   final res = await _dio.post("api/user/checkversion", data: data);
//   if (res.statusCode >= 200 && res.statusCode < 300) {
//     return CheckUpdate.fromJson(res.data);
//   } else {
//     return null;
//   }
// }
//
// Future<rq.Request> acceptRequest(int id) async {
//   var data = {"dummy": "dummy"};
//   final res = await _dio.post("/api/provider/trip/$id", data: data);
//   if (res.statusCode >= 200 && res.statusCode < 300) {
//     return rq.Request.fromJson(res.data);
//   } else {
//     return null;
//   }
// }
//
// Future<ProfileModel> loadProfile() async {
//   try {
//     final res = await _dio.get("/api/provider/profile");
//     if (res.statusCode >= 200 && res.statusCode < 300) {
//       return ProfileModel.fromJson(res.data);
//     } else {
//       return null;
//     }
//   } on DioError catch (e) {
//     return null;
//   }
// }
//
// Future<List<OrdersModel>> orderHistory(String id) async {
//   try {
//     var data = {'provider_id': id};
//     final result =
//         await _dio.post("/api/provider/myorders/completed", data: data);
//     if (result.statusCode >= 200 && result.statusCode < 300) {
//       List<OrdersModel> list = List<OrdersModel>();
//       result.data.forEach((v) {
//         list.add(OrdersModel.fromJson(v));
//       });
//       return list;
//     } else {
//       return null;
//     }
//   } on Exception catch (e) {
//     print(e.toString());
//     return null;
//   }
// }
//
// Future<rq.Request> updateStatus(int id, var data) async {
//   final res = await _dio.post("/api/provider/trip/$id", data: data);
//   if (res.statusCode >= 200 && res.statusCode < 300) {
//     return rq.Request.fromJson(res.data);
//   } else {
//     return null;
//   }
// }
//
// Future<Rating> rateUser(int id, var data) async {
//   final res = await _dio.post("api/provider/trip/$id/rate", data: data);
//   if (res.statusCode >= 200 && res.statusCode < 300) {
//     return Rating.fromJson(res.data);
//   } else {
//     return null;
//   }
// }
//
// Future<String> addAdditionalAmount(int id, var data) async {
//   final res =
//       await _dio.post("api/provider/add_additional_amt/$id", data: data);
//   if (res.statusCode >= 200 && res.statusCode < 300) {
//     return res.data.toString();
//   } else {
//     return null;
//   }
// }
//
// Future<List<MyOrders>> myOrders(String providerId) async {
//   var data = {'provider_id': providerId};
//   final res = await _dio.post("api/provider/myorders", data: data);
//   if (res.statusCode >= 200 && res.statusCode < 300) {
//     List<MyOrders> list = List<MyOrders>();
//     res.data.forEach((v) {
//       list.add(MyOrders.fromJson(v));
//     });
//     return list;
//   } else {
//     return null;
//   }
// }
//
// Future<List<MyOrders>> updateOrder(
//     String providerId, int orderId, String status,
//     {double rating, double additionalAmount}) async {
//   var data = {
//     'provider_id': providerId,
//     'order_id': orderId,
//     'status': status,
//     'rating_by_provider': rating,
//     'additional_amount': additionalAmount
//   };
//   final res = await _dio.post("api/provider/myorders/update", data: data);
//   if (res.statusCode >= 200 && res.statusCode < 300) {
//     List<MyOrders> list = List<MyOrders>();
//     res.data.forEach((v) {
//       list.add(MyOrders.fromJson(v));
//     });
//     return list;
//   } else {
//     return null;
//   }
// }
}
