import 'package:dio/dio.dart';
import 'package:kmerchant/helper/constants.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RequestHelper {
  String get _bearerToken {
    return "Bearer $ACCESS_TOKEN";
  }

  Dio get _dio {
    Dio dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 5000,
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

  Future<Response> post(String url, dynamic data, bool isFormUrlEncoded) async {
    Options opt = Options(followRedirects: true);
    if (isFormUrlEncoded) {
      opt = Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: true);
    }
    final res = await _dio.post(url, data: data, options: opt);
    if (res.statusCode >= 200 && res.statusCode < 300) {
    } else {}
  }
}
