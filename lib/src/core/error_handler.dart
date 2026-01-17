import 'package:dio/dio.dart';

import 'api_exception.dart';
import 'constants.dart';

/// Utility class for converting Dio exceptions to Clockify exceptions.
class ErrorHandler {
  /// Converts a [DioException] to the appropriate [ClockifyException].
  static ClockifyException handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ClockifyNetworkException(
          message: ErrorMessages.timeoutError,
          url: e.requestOptions.path,
          originalError: e,
        );
      case DioExceptionType.cancel:
        return ClockifyNetworkException(
          message: 'Request was cancelled',
          url: e.requestOptions.path,
          originalError: e,
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(e);
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return ClockifyNetworkException(
          message: e.message ?? ErrorMessages.networkError,
          url: e.requestOptions.path,
          originalError: e,
        );
      case DioExceptionType.badCertificate:
        return ClockifyNetworkException(
          message: 'SSL certificate error',
          url: e.requestOptions.path,
          originalError: e,
        );
    }
  }

  static ClockifyException _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode ?? 0;
    final url = e.requestOptions.path;

    switch (statusCode) {
      case HttpStatusCodes.unauthorized:
        return ClockifyAuthException(
          message: ErrorMessages.invalidApiKey,
          statusCode: statusCode,
          url: url,
          originalError: e,
        );
      case HttpStatusCodes.notFound:
        return ClockifyNotFoundException(
          message: ErrorMessages.resourceNotFound,
          statusCode: statusCode,
          url: url,
          originalError: e,
        );
      case HttpStatusCodes.tooManyRequests:
        return ClockifyRateLimitException(
          message: ErrorMessages.rateLimitExceeded,
          statusCode: statusCode,
          url: url,
          originalError: e,
        );
      case HttpStatusCodes.internalServerError:
      case HttpStatusCodes.badGateway:
      case HttpStatusCodes.serviceUnavailable:
        return ClockifyServerException(
          message: ErrorMessages.serverError,
          statusCode: statusCode,
          url: url,
          originalError: e,
        );
      default:
        return ClockifyException(
          message: 'API error: ${e.message}',
          statusCode: statusCode,
          url: url,
          originalError: e,
        );
    }
  }
}
