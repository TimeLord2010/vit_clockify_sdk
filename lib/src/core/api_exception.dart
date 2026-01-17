/// Base exception for all Clockify API errors.
///
/// Subclass this to create specific exception types for different error scenarios.
class ClockifyException implements Exception {
  /// The error message describing what went wrong.
  final String message;

  /// HTTP status code (if applicable).
  final int? statusCode;

  /// The URL that was being requested when the error occurred.
  final String? url;

  /// Original error that caused this exception.
  final Object? originalError;

  /// StackTrace from the original error.
  final StackTrace? originalStackTrace;

  ClockifyException({
    required this.message,
    this.statusCode,
    this.url,
    this.originalError,
    this.originalStackTrace,
  });

  @override
  String toString() {
    final parts = [message];
    if (statusCode != null) parts.add('Status: $statusCode');
    if (url != null) parts.add('URL: $url');
    return 'ClockifyException: ${parts.join(', ')}';
  }
}

/// Exception thrown when authentication fails (HTTP 401).
///
/// This typically indicates an invalid or missing API key.
class ClockifyAuthException extends ClockifyException {
  ClockifyAuthException({
    required super.message,
    super.statusCode = 401,
    super.url,
    super.originalError,
    super.originalStackTrace,
  });

  @override
  String toString() => 'ClockifyAuthException: $message';
}

/// Exception thrown when a requested resource is not found (HTTP 404).
///
/// This typically means the workspace, project, user, or other resource
/// doesn't exist or the API key doesn't have access to it.
class ClockifyNotFoundException extends ClockifyException {
  ClockifyNotFoundException({
    required super.message,
    super.statusCode = 404,
    super.url,
    super.originalError,
    super.originalStackTrace,
  });

  @override
  String toString() => 'ClockifyNotFoundException: $message';
}

/// Exception thrown when API rate limit is exceeded (HTTP 429).
///
/// The Clockify API has rate limits. When exceeded, wait before retrying.
class ClockifyRateLimitException extends ClockifyException {
  /// Number of seconds to wait before retrying (if provided by server).
  final int? retryAfterSeconds;

  ClockifyRateLimitException({
    required super.message,
    super.statusCode = 429,
    super.url,
    this.retryAfterSeconds,
    super.originalError,
    super.originalStackTrace,
  });

  @override
  String toString() {
    final retryInfo = retryAfterSeconds != null
        ? ' (retry after $retryAfterSeconds seconds)'
        : '';
    return 'ClockifyRateLimitException: $message$retryInfo';
  }
}

/// Exception thrown for server-side errors (HTTP 500+).
///
/// This indicates an error on the Clockify server side.
class ClockifyServerException extends ClockifyException {
  ClockifyServerException({
    required super.message,
    required super.statusCode,
    super.url,
    super.originalError,
    super.originalStackTrace,
  });

  @override
  String toString() => 'ClockifyServerException: $message (Status: $statusCode)';
}

/// Exception thrown for network-related errors.
///
/// This includes timeouts, connection failures, and other network issues.
class ClockifyNetworkException extends ClockifyException {
  ClockifyNetworkException({
    required super.message,
    super.url,
    super.originalError,
    super.originalStackTrace,
  });

  @override
  String toString() => 'ClockifyNetworkException: $message';
}
