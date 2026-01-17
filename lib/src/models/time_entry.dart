import 'hourly_rate.dart';
import 'time_interval.dart';

/// Represents a time entry in Clockify.
///
/// A time entry represents a tracked block of time associated with a user,
/// optionally on a specific project, with an optional description.
class TimeEntry {
  /// Description of what was done during this time entry.
  final String description;

  /// The hourly rate applied to this time entry.
  final HourlyRate hourlyRate;

  /// The unique identifier of the project associated with this entry.
  ///
  /// May be null if the time entry is not associated with any project.
  final String projectId;

  /// The unique identifier of the user who created this time entry.
  final String userId;

  /// The time interval during which this entry was tracked.
  final TimeInterval timeInterval;

  /// Creates a new [TimeEntry] instance.
  TimeEntry({
    required this.description,
    required this.hourlyRate,
    required this.projectId,
    required this.userId,
    required this.timeInterval,
  });

  /// Creates a [TimeEntry] instance from JSON data.
  ///
  /// Expects a map with 'userId', 'timeInterval', and optionally
  /// 'description', 'hourlyRate', and 'projectId' keys.
  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      description: json['description'] ?? '',
      hourlyRate: HourlyRate.fromJson(
        (json['hourlyRate'] as Map<String, dynamic>?) ?? {'amount': 0},
      ),
      projectId: json['projectId'],
      userId: json['userId'] as String,
      timeInterval: TimeInterval.fromJson(
        json['timeInterval'] as Map<String, dynamic>,
      ),
    );
  }

  /// Converts this [TimeEntry] to JSON format.
  Map<String, dynamic> toJson() => {
    'description': description,
    'hourlyRate': hourlyRate.toJson(),
    'projectId': projectId,
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
      'TimeEntry(userId: $userId, projectId: $projectId, description: $description, duration: ${timeInterval.duration})';
}
