// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/chat_message.dart';

class ApiRequest {
  final String message;
  final List<Map<String, dynamic>> history;
  final String userId;

  ApiRequest({
    required this.message,
    required this.history,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'history': history,
      'userId': userId,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class ApiResponse {
  final String message;
  final bool success;
  final dynamic data;

  ApiResponse({
    required this.message,
    required this.success,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['response'] ?? json['message'] ?? 'No message provided',
      success: json['success'] ?? false,
      data: json['data'],
    );
  }
}
class ApiService {
  static const String baseUrl = 'https://apiapp2hwd.pythonanywhere.com/api/';
  static const String userId = 'user_12345';

  static Future<ApiResponse> sendMessage(String message, List<Map<String, dynamic>> history) async {
    try {
      final request = ApiRequest(
        message: message,
        history: history,
        userId: userId,
      );

      final jsonString = request.toJsonString();
      print('Request Body: $jsonString');

      final url = '${baseUrl}chat/'; // Ensure the trailing slash
      print('Request URL: $url');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonString,
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: data['response'] ?? "No response data",
          success: true,
          data: data,
        );
      } else {
        return ApiResponse(
          message: 'Server error: ${response.statusCode}\n${response.body}',
          success: false,
        );
      }
    } catch (e, stackTrace) {
      print('API Error: $e');
      print('Stack trace: $stackTrace');
      return ApiResponse(
        message: 'Error: $e',
        success: false,
      );
    }
  }
}
