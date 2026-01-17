import 'package:dio/dio.dart';

import '../core/api_exception.dart';
import '../core/error_handler.dart';
import '../core/http_client.dart';
import '../models/project.dart';

/// Module for managing Clockify project operations.
class ProjectModule {
  /// Fetches all projects in a workspace.
  ///
  /// Parameters:
  ///   - [workspaceId]: The unique identifier of the workspace
  ///
  /// Returns a [Future] that resolves to a [List] of [Project] objects.
  ///
  /// Throws:
  ///   - [ClockifyAuthException] if the API key is invalid
  ///   - [ClockifyNotFoundException] if the workspace doesn't exist
  ///   - [ClockifyNetworkException] if there's a network issue
  ///   - [ClockifyException] for other API errors
  ///
  /// Example:
  /// ```dart
  /// final projects = await VitClockify.projects.getAll(workspaceId: 'abc123');
  /// ```
  Future<List<Project>> getAll({required String workspaceId}) async {
    try {
      final response = await ClockifyHttpClient.instance
          .get('/workspaces/$workspaceId/projects');
      final List<dynamic> data = response.data;
      return data
          .map((json) => Project.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ErrorHandler.handleDioException(e);
    }
  }
}
