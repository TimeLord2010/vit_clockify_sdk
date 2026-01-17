/// API version string for Clockify.
const String apiVersion = 'v1';

/// Default page size for paginated API responses.
/// Clockify API supports up to 5000 items per page.
const int defaultPageSize = 5000;

/// HTTP status codes used in error handling.
class HttpStatusCodes {
  static const int ok = 200;
  static const int created = 201;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int tooManyRequests = 429;
  static const int internalServerError = 500;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
}

/// Common error messages.
class ErrorMessages {
  static const String invalidApiKey = 'Invalid API key. Please check your credentials.';
  static const String resourceNotFound = 'The requested resource was not found.';
  static const String rateLimitExceeded = 'API rate limit exceeded. Please wait before retrying.';
  static const String serverError = 'Clockify server error. Please try again later.';
  static const String networkError = 'Network error. Please check your connection.';
  static const String timeoutError = 'Request timed out. Please try again.';
  static const String parseError = 'Failed to parse API response.';
}
