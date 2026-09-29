import 'hourly_rate.dart';
import 'time_interval.dart';

/// Represents a time entry in Clockify.
///
/// A time entry represents a tracked block of time associated with a user,
/// optionally on a specific project, with an optional description.
class TimeEntry {
  /// The unique identifier of this time entry.
  final String id;

  /// Description (title) of what was done during this time entry.
  ///
  /// Mutable to allow updating the entry in place after
  /// `TimeEntryModule.updateDescription`.
  String description;

  /// The hourly rate applied to this time entry.
  final HourlyRate hourlyRate;

  /// The unique identifier of the project associated with this entry.
  ///
  /// May be null if the time entry is not associated with any project.
  final String projectId;

  /// The unique identifier of the task associated with this entry, if any.
  final String? taskId;

  /// Whether this time entry is billable.
  final bool billable;

  /// The identifiers of the tags applied to this time entry.
  final List<String> tagIds;

  /// The unique identifier of the user who created this time entry.
  final String userId;

  /// The time interval during which this entry was tracked.
  final TimeInterval timeInterval;

  /// Creates a new [TimeEntry] instance.
  TimeEntry({
    required this.id,
    required this.description,
    required this.hourlyRate,
    required this.projectId,
    this.taskId,
    this.billable = false,
    this.tagIds = const [],
    required this.userId,
    required this.timeInterval,
  });

  /// Creates a [TimeEntry] instance from JSON data.
  ///
  /// Expects a map with 'id', 'userId', 'timeInterval', and optionally
  /// 'description', 'hourlyRate', 'projectId', 'taskId', 'billable' and
  /// 'tagIds' keys.
  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'] as String,
      description: json['description'] ?? '',
      hourlyRate: HourlyRate.fromJson(
        (json['hourlyRate'] as Map<String, dynamic>?) ?? {'amount': 0},
      ),
      projectId: json['projectId'],
      taskId: json['taskId'] as String?,
      billable: json['billable'] as bool? ?? false,
      tagIds: (json['tagIds'] as List<dynamic>?)?.cast<String>() ?? const [],
      userId: json['userId'] as String,
      timeInterval: TimeInterval.fromJson(
        json['timeInterval'] as Map<String, dynamic>,
      ),
    );
  }

  /// Converts this [TimeEntry] to JSON format.
  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'hourlyRate': hourlyRate.toJson(),
    'projectId': projectId,
    'taskId': taskId,
    'billable': billable,
    'tagIds': tagIds,
    'userId': userId,
    'timeInterval': timeInterval.toJson(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeEntry &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          timeInterval == other.timeInterval;

  @override
  int get hashCode => userId.hashCode ^ timeInterval.hashCode;

  @override
  String toString() =>
      'TimeEntry(id: $id, userId: $userId, projectId: $projectId, description: $description, duration: ${timeInterval.duration})';
}
