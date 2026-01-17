import 'hourly_rate.dart';

/// Represents a user's membership in a project with associated billing rate.
///
/// Memberships define which users have access to a project and at what
/// hourly rate they should be billed for time spent on that project.
class Membership {
  /// The unique identifier of the user who has this membership.
  final String userId;

  /// The hourly rate for this user in this project.
  HourlyRate hourlyRate;

  /// Creates a new [Membership] instance.
  Membership({required this.userId, required this.hourlyRate});

  /// Creates a [Membership] instance from JSON data.
  ///
  /// Expects a map with 'userId' and 'hourlyRate' keys.
  /// The 'hourlyRate' should be a map with an 'amount' key.
  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      userId: json['userId'] as String,
      hourlyRate: HourlyRate.fromJson(
        (json['hourlyRate'] as Map<String, dynamic>?) ?? {'amount': 0},
      ),
    );
  }

  /// Converts this [Membership] to JSON format.
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'hourlyRate': hourlyRate.toJson(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Membership &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() =>
      'Membership(userId: $userId, hourlyRate: ${hourlyRate.amount})';
}
