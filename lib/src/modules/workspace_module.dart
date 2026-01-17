import 'package:dio/dio.dart';

import '../core/api_exception.dart';
import '../core/error_handler.dart';
import '../core/http_client.dart';
import '../models/workspace.dart';

/// Module for managing Clockify workspace operations.
class WorkspaceModule {
  /// Fetches all workspaces accessible with the current API key.
  ///
  /// Returns a [Future] that resolves to a [List] of [Workspace] objects.
  ///
  /// Throws:
  ///   - [ClockifyAuthException] if the API key is invalid
  ///   - [ClockifyNetworkException] if there's a network issue
  ///   - [ClockifyException] for other API errors
  ///
  /// Example:
  /// ```dart
  /// final workspaces = await VitClockify.workspaces.getAll();
  /// ```
  Future<List<Workspace>> getAll() async {
    try {
      final response = await ClockifyHttpClient.instance.get('/workspaces');
      final List<dynamic> data = response.data;
      return data
          .map((json) => Workspace.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ErrorHandler.handleDioException(e);
    }
  }
}
