/// Represents a Clockify workspace.
///
/// A workspace is the top-level container for all time tracking data,
/// users, projects, and settings in Clockify.
class Workspace {
  /// The unique identifier for this workspace.
  final String id;

  /// The human-readable name of this workspace.
  ///
  /// The Clockify API returns workspace names with a "'s workspace" suffix,
  /// which is automatically removed during parsing for cleaner display.
  final String name;

  /// Creates a new [Workspace] instance.
  Workspace({required this.id, required this.name});

  /// Creates a [Workspace] instance from JSON data.
  ///
  /// Automatically strips the "'s workspace" suffix from the name if present.
  ///
  /// Expects a map with 'id' and 'name' keys.
  factory Workspace.fromJson(Map<String, dynamic> json) {
    String name = json['name'] as String? ?? '';
    const suffix = "'s workspace";
    if (name.endsWith(suffix)) {
      name = name.substring(0, name.length - suffix.length);
    }
    return Workspace(id: json['id'] as String, name: name);
  }

  /// Converts this [Workspace] to JSON format.
  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Workspace && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Workspace(id: $id, name: $name)';
}
