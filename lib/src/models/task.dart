import 'package:iso8601_duration/iso8601_duration.dart';
import 'package:vit_clockify_sdk/src/models/hourly_rate.dart';

class Task {
  String id;
  String name;
  String projectId;
  bool billable;
  Duration duration;
  Duration estimate;
  TaskStatus status;
  List<String> assigneeIds;
  final HourlyRate hourlyRate;

  Task({
    required this.id,
    required this.name,
    required this.projectId,
    required this.billable,
    required this.duration,
    required this.estimate,
    required this.status,
    required this.assigneeIds,
    required this.hourlyRate,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    final converter = ISODurationConverter();
    Duration convert(String value) {
      final iso = converter.parseString(isoDurationString: value);
      return Duration(
        days: (iso.day?.toInt() ?? 0) + (iso.week?.toInt() ?? 0) * 7,
        hours: iso.hour?.toInt() ?? 0,
        minutes: iso.minute?.toInt() ?? 0,
        seconds: iso.seconds?.toInt() ?? 0,
      );
    }

    List assigneeIds = map['assigneeIds'];
    return Task(
      id: map['id'],
      name: map['name'],
      projectId: map['projectId'],
      billable: map['billable'],
      duration: convert(map['duration']),
      estimate: convert(map['estimate']),
      status: TaskStatus.fromString(map['status']),
      assigneeIds: assigneeIds.map((x) => x as String).toList(),
      hourlyRate: HourlyRate.fromJson(map['hourlyRate']),
    );
  }
}

enum TaskStatus {
  done,
  all,
  active;

  factory TaskStatus.fromString(String value) {
    return switch (value) {
      'DONE' => .done,
      'ACTIVE' => .active,
      _ => .all,
    };
  }
}
