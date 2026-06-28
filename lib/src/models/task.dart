import 'package:iso8601_duration/iso8601_duration.dart';
import 'package:vit_clockify_sdk/src/models/hourly_rate.dart';

class Task {
  String id;
  String name;
  String projectId;
  bool billable;

  /// The task's logged duration.
  ///
  /// **Limitation:** derived from [durationIso] by mapping only hours, minutes,
  /// seconds, and weeks. If the ISO value contains months
  /// or years, those components are silently ignored and this value will be
  /// inaccurate. Use [durationIso] directly when month/year precision matters.
  Duration? duration;

  /// The raw ISO 8601 duration returned by the Clockify API for logged time.
  ISODuration? durationIso;

  /// The task's estimated duration.
  ///
  /// **Limitation:** derived from [estimateIso] by mapping only hours, minutes,
  /// seconds, and weeks. If the ISO value contains months
  /// or years, those components are silently ignored and this value will be
  /// inaccurate. Use [estimateIso] directly when month/year precision matters.
  Duration? estimate;

  /// The raw ISO 8601 duration returned by the Clockify API for the estimate.
  ISODuration? estimateIso;
  TaskStatus status;
  List<String> assigneeIds;
  HourlyRate? hourlyRate;

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
    required this.durationIso,
    required this.estimateIso,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    final converter = ISODurationConverter();
    (Duration, ISODuration)? convert(String? value) {
      if (value == null) {
        return null;
      }
      final iso = converter.parseString(isoDurationString: value);
      var dur = Duration(
        days: (iso.day?.toInt() ?? 0) + (iso.week?.toInt() ?? 0) * 7,
        hours: iso.hour?.toInt() ?? 0,
        minutes: iso.minute?.toInt() ?? 0,
        seconds: iso.seconds?.toInt() ?? 0,
      );
      return (dur, iso);
    }

    List assigneeIds = map['assigneeIds'];

    var durationValue = convert(map['duration']);
    var estimateValue = convert(map['estimate']);
    var hourlyRate = map['hourlyRate'];
    return Task(
      id: map['id'],
      name: map['name'],
      projectId: map['projectId'],
      billable: map['billable'],
      duration: durationValue?.$1,
      durationIso: durationValue?.$2,
      estimate: estimateValue?.$1,
      estimateIso: estimateValue?.$2,
      status: TaskStatus.fromString(map['status']),
      assigneeIds: assigneeIds.map((x) => x as String).toList(),
      hourlyRate: hourlyRate != null ? HourlyRate.fromJson(hourlyRate) : null,
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
