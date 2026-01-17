import 'package:dio/dio.dart';

import '../core/api_exception.dart';
import '../core/error_handler.dart';
import '../core/http_client.dart';
import '../models/user.dart';

/// Module for managing Clockify user operations.
class UserModule {
  /// Fetches all users in a workspace.
  ///
  /// Parameters:
  ///   - [workspaceId]: The unique identifier of the workspace
  ///
  /// Returns a [Future] that resolves to a [List] of [User] objects.
  ///
  /// Throws:
  ///   - [ClockifyAuthException] if the API key is invalid
  ///   - [ClockifyNotFoundException] if the workspace doesn't exist
  ///   - [ClockifyNetworkException] if there's a network issue
  ///   - [ClockifyException] for other API errors
  ///
  /// Example:
  /// ```dart
  /// final users = await VitClockify.users.getAll(workspaceId: 'abc123');
  /// ```
  Future<List<User>> getAll({required String workspaceId}) async {
    try {
      final response = await ClockifyHttpClient.instance
          .get('/workspaces/$workspaceId/users');
      final List<dynamic> data = response.data;
      return data.map((json) => User.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw ErrorHandler.handleDioException(e);
    }
  }
}
