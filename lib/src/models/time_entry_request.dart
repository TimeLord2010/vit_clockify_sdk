/// Request model for creating a time entry in Clockify.
///
/// This model is used to send time entry data to the Clockify API
/// when creating new time entries.
class TimeEntryRequest {
  /// The unique identifier of the workspace where the entry will be created.
  final String workspaceId;

  /// The start time of the time entry (ISO 8601 format).
  final String start;

  /// The end time of the time entry (ISO 8601 format).
  ///
  /// Optional. If not provided, the timer will be started without an end time.
  final String? end;

  /// Description of the work done during this time entry.
  final String? description;

  /// The unique identifier of the project associated with this entry.
  ///
  /// Optional. If not provided, the time entry will not be associated with a project.
  final String? projectId;

  /// The unique identifier of the task associated with this entry.
  ///
  /// Optional. Requires a projectId to be set.
  final String? taskId;

  /// Whether this time entry is billable.
  ///
  /// Defaults to false if not specified.
  final bool? billable;

  /// List of tag IDs to associate with this time entry.
  ///
  /// Optional.
  final List<String>? tagIds;

  /// Custom fields for this time entry.
  ///
  /// Optional. Format depends on your workspace configuration.
  final Map<String, dynamic>? customFields;

  /// Creates a new [TimeEntryRequest] instance.
  TimeEntryRequest({
    required this.workspaceId,
    required this.start,
    this.end,
    this.description,
    this.projectId,
    this.taskId,
    this.billable,
    this.tagIds,
    this.customFields,
  });

  /// Converts this [TimeEntryRequest] to JSON format.
  ///
  /// Omits null values from the resulting map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'start': start,
      if (end != null) 'end': end,
      if (description != null) 'description': description,
      if (projectId != null) 'projectId': projectId,
      if (taskId != null) 'taskId': taskId,
      if (billable != null) 'billable': billable,
      if (tagIds != null && tagIds!.isNotEmpty) 'tagIds': tagIds,
      if (customFields != null && customFields!.isNotEmpty) 'customFields': customFields,
    };
  }
}
