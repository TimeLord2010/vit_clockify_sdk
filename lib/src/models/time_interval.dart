/// Represents a time interval with a start and end time.
///
/// Time intervals are used to represent the duration of a time entry.
/// They can be converted to/from ISO 8601 date-time strings.
class TimeInterval {
  /// The start time of the interval (in local time).
  final DateTime start;

  /// The end time of the interval (in local time).
  ///
  /// For ongoing entries, this may be set to the current time.
  final DateTime end;

  /// Creates a new [TimeInterval] instance.
  TimeInterval({required this.start, required this.end});

  /// The duration of this time interval.
  Duration get duration => end.difference(start);

  /// Creates a [TimeInterval] instance from JSON data.
  ///
  /// Expects a map with 'start' and optionally 'end' keys containing
  /// ISO 8601 formatted date-time strings in UTC.
  ///
  /// The times are automatically converted from UTC to local time.
  /// If 'end' is missing or null (indicating an ongoing entry),
  /// it defaults to the current time.
  factory TimeInterval.fromJson(Map<String, dynamic> json) {
    final startStr = json['start'] as String?;
    final endStr = json['end'] as String?;

    if (startStr == null) {
      throw FormatException('TimeInterval requires a "start" field');
    }

    final start = DateTime.parse(startStr).toLocal();
    final end = endStr != null && endStr.isNotEmpty
        ? DateTime.parse(endStr).toLocal()
        : DateTime.now();

    return TimeInterval(start: start, end: end);
  }

  /// Converts this [TimeInterval] to JSON format.
  ///
  /// Returns ISO 8601 formatted date-time strings in UTC.
  Map<String, dynamic> toJson() => {
        'start': start.toUtc().toIso8601String(),
        'end': end.toUtc().toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeInterval &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  String toString() => 'TimeInterval(start: $start, end: $end)';
}
