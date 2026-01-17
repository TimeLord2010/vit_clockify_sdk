/// A Dart SDK for the Clockify API.
///
/// Provides a clean and type-safe interface for interacting with Clockify's
/// time tracking system.
///
/// ## Quick Start
///
/// ```dart
/// import 'package:vit_clockify_sdk/vit_clockify_sdk.dart';
///
/// Future<void> main() async {
///   // Set your API key
///   VitClockify.apiKey = 'your-api-key-here';
///
///   try {
///     // Fetch all workspaces
///     final workspaces = await VitClockify.workspaces.getAll();
///     print('Workspaces: $workspaces');
///
///     if (workspaces.isNotEmpty) {
///       final workspace = workspaces.first;
///
///       // Fetch projects
///       final projects = await VitClockify.projects.getAll(
///         workspaceId: workspace.id,
///       );
///       print('Projects: $projects');
///     }
///   } on ClockifyException catch (e) {
///     print('Error: $e');
///   }
/// }
/// ```
library;

// Main class
export 'src/vit_clockify.dart';

// Models
export 'src/models/hourly_rate.dart';
export 'src/models/membership.dart';
export 'src/models/project.dart';
export 'src/models/time_entry.dart';
export 'src/models/time_interval.dart';
export 'src/models/user.dart';
export 'src/models/workspace.dart';

// Exceptions
export 'src/core/api_exception.dart';
