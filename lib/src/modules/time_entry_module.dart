import 'package:dio/dio.dart';

import '../core/api_exception.dart';
import '../core/constants.dart';
import '../core/error_handler.dart';
import '../core/http_client.dart';
import '../models/time_entry.dart';
import '../models/time_entry_request.dart';

/// Module for managing Clockify time entry operations.
class TimeEntryModule {
  /// Creates a new time entry in Clockify.
  ///
  /// Creates a time entry for the specified user in the given workspace.
  /// Note: Creating time entries for other users is a paid feature.
  ///
  /// Parameters:
  ///   - [request]: The [TimeEntryRequest] object containing the entry details,
  ///     including the workspace ID
  ///
  /// Returns a [Future] that resolves to the created [TimeEntry] object.
  ///
  /// Throws:
  ///   - [ClockifyAuthException] if the API key is invalid
  ///   - [ClockifyNotFoundException] if the workspace doesn't exist
  ///   - [ClockifyNetworkException] if there's a network issue
  ///   - [ClockifyException] for other API errors
  ///
  /// Example:
  /// ```dart
  /// final request = TimeEntryRequest(
  ///   workspaceId: 'workspace456',
  ///   start: DateTime.now().toUtc().toIso8601String(),
  ///   end: DateTime.now().add(Duration(hours: 1)).toUtc().toIso8601String(),
  ///   description: 'Implemented new feature',
  ///   projectId: 'project123',
  /// );
  ///
  /// final entry = await VitClockify.timeEntries.create(request);
  /// ```
  Future<TimeEntry> create(TimeEntryRequest request) async {
    try {
      final response = await ClockifyHttpClient.instance.post(
        '/workspaces/${request.workspaceId}/time-entries',
        data: request.toJson(),
      );

      return TimeEntry.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioException(e);
    }
  }

  /// Fetches time entries for a specific user within a workspace.
  ///
  /// Returns a list of [TimeEntry] objects for the given user, optionally
  /// filtered by date range.
  ///
  /// Parameters:
  ///   - [workspaceId]: The unique identifier of the workspace
  ///   - [userId]: The unique identifier of the user
  ///   - [startDate]: Optional start date for filtering entries (inclusive).
  ///     If not provided, defaults to the beginning of the current month.
  ///   - [endDate]: Optional end date for filtering entries (inclusive).
  ///     If not provided, defaults to the end of the current month.
  ///
  /// Returns a [Future] that resolves to a [List] of [TimeEntry] objects.
  ///
  /// Throws:
  ///   - [ClockifyAuthException] if the API key is invalid
  ///   - [ClockifyNotFoundException] if the workspace or user doesn't exist
  ///   - [ClockifyNetworkException] if there's a network issue
  ///   - [ClockifyException] for other API errors
  ///
  /// Example:
  /// ```dart
  /// final entries = await VitClockify.timeEntries.getForUser(
  ///   workspaceId: 'abc123',
  ///   userId: 'user456',
  ///   startDate: DateTime(2026, 1, 1),
  ///   endDate: DateTime(2026, 1, 31),
  /// );
  /// ```
  Future<List<TimeEntry>> getForUser({
    required String workspaceId,
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{'page-size': defaultPageSize};

      if (startDate != null) {
        queryParams['start'] = startDate.toUtc().toIso8601String();
      }

      if (endDate != null) {
        queryParams['end'] = endDate.toUtc().toIso8601String();
      }

      final response = await ClockifyHttpClient.instance.get(
        '/workspaces/$workspaceId/user/$userId/time-entries',
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data;
      return data
          .map((json) => TimeEntry.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ErrorHandler.handleDioException(e);
    }
  }
}
