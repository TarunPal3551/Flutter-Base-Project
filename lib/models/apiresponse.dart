import 'dart:convert';

class ApiResponse {
  Map<String, dynamic> data;

  ApiResponse.fromJsonString(String jsonString) {
    data = jsonDecode(jsonString);
  }

  @override
  String toString() {
    return 'ApiResponse{data: $data}';
  }
}
