/// Represents a user in Clockify.
///
/// Users can be members of workspaces and track time entries.
class User {
  /// The unique identifier for this user.
  final String id;

  /// The human-readable name of this user.
  final String name;

  /// Creates a new [User] instance.
  User({required this.id, required this.name});

  /// Creates a [User] instance from JSON data.
  ///
  /// Expects a map with 'id' and 'name' keys.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
    );
  }

  /// Converts this [User] to JSON format.
  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'User(id: $id, name: $name)';
}
