import 'package:dio/dio.dart';

/// Singleton HTTP client for all Clockify API requests.
///
/// Provides a configured Dio instance with proper timeouts, base URL,
/// and authentication header management.
class ClockifyHttpClient {
  // Private constructor to prevent instantiation
  ClockifyHttpClient._();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.clockify.me/api/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  /// Returns the singleton Dio instance for API requests.
  static Dio get instance => _dio;

  /// Sets the API key for authenticating requests.
  ///
  /// The API key is stored in the 'x-api-key' header. Pass null to remove
  /// the API key from subsequent requests.
  static void setApiKey(String? apiKey) {
    if (apiKey == null || apiKey.isEmpty) {
      _dio.options.headers.remove('x-api-key');
    } else {
      _dio.options.headers['x-api-key'] = apiKey;
    }
  }
}
