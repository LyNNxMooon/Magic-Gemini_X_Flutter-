import 'package:dio/dio.dart';

class ApiErrorConfig {
  
  ApiErrorConfig._();
  static final ApiErrorConfig _singleton = ApiErrorConfig._();
  factory ApiErrorConfig() => _singleton;

  Object throwExceptionForRequest(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return "No Internet!";
      }
      if (error.response?.data is Map<String, dynamic>) {
        try {
          return "Error asking to Gemini!";
        } catch (error) {
          return error.toString();
        }
      }
      return error.response.toString();
    }
    return error.toString();
  }
}
