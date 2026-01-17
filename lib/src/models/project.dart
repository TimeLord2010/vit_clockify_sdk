import 'membership.dart';

/// Represents a project in Clockify.
///
/// Projects are used to organize time entries and can have multiple users
/// with different billing rates through memberships.
class Project {
  /// The unique identifier for this project.
  final String id;

  /// The human-readable name of this project.
  final String name;

  /// The color associated with this project as a hex string (without #).
  ///
  /// Example: 'FF0000' for red, '00FF00' for green.
  final String color;

  /// Whether this project is archived.
  ///
  /// Archived projects are typically hidden from the active project list
  /// but remain in the system for historical records.
  final bool archived;

  /// The list of users who are members of this project.
  ///
  /// Each membership includes the user ID and their hourly rate for this project.
  final List<Membership> memberships;

  /// Creates a new [Project] instance.
  Project({
    required this.id,
    required this.name,
    required this.color,
    required this.archived,
    required this.memberships,
  });

  /// Creates a [Project] instance from JSON data.
  ///
  /// Expects a map with 'id', 'name', 'color', 'archived', and optionally
  /// 'memberships' keys.
  ///
  /// The color is normalized to remove any leading '#' character.
  factory Project.fromJson(Map<String, dynamic> json) {
    String colorStr = json['color'] as String? ?? '';
    if (colorStr.startsWith('#')) {
      colorStr = colorStr.substring(1);
    }

    final membershipsList = json['memberships'] as List<dynamic>? ?? [];
    final memberships = membershipsList
        .map((m) => Membership.fromJson(m as Map<String, dynamic>))
        .toList();

    return Project(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      color: colorStr,
      archived: json['archived'] as bool? ?? false,
      memberships: memberships,
    );
  }

  /// Converts this [Project] to JSON format.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'color': color,
        'archived': archived,
        'memberships': memberships.map((m) => m.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Project(id: $id, name: $name, color: $color, archived: $archived, memberships: ${memberships.length})';
}
