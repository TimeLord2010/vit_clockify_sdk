import 'core/http_client.dart';
import 'modules/project_module.dart';
import 'modules/time_entry_module.dart';
import 'modules/user_module.dart';
import 'modules/workspace_module.dart';

/// Main entry point for the VitClockify SDK.
///
/// Provides access to Clockify API operations through module-based interfaces.
/// Configure the API key before making any API calls.
///
/// Example:
/// ```dart
/// // Set your API key
/// VitClockify.apiKey = 'your-api-key-here';
///
/// // Fetch all workspaces
/// final workspaces = await VitClockify.workspaces.getAll();
///
/// // Fetch projects in a workspace
/// final projects = await VitClockify.projects.getAll(
///   workspaceId: workspaces.first.id,
/// );
///
/// // Fetch time entries for a user
/// final entries = await VitClockify.timeEntries.getForUser(
///   workspaceId: workspaces.first.id,
///   userId: users.first.id,
/// );
/// ```
class VitClockify {
  // Private constructor to prevent instantiation
  VitClockify._();

  // Static API key property
  static String? _apiKey;

  /// Sets the API key for authenticating all subsequent API requests.
  ///
  /// The API key is stored in the 'x-api-key' header for each request.
  /// Pass `null` or an empty string to clear the API key.
  ///
  /// Example:
  /// ```dart
  /// VitClockify.apiKey = 'your-api-key';
  /// // Now you can make API calls
  ///
  /// VitClockify.apiKey = null; // Clear the API key
  /// ```
  static set apiKey(String? key) {
    _apiKey = key;
    ClockifyHttpClient.setApiKey(key);
  }

  /// Gets the currently set API key.
  ///
  /// Returns the API key that was previously set, or `null` if no key is set.
  static String? get apiKey => _apiKey;

  // Module instances (lazy-initialized singletons)
  static WorkspaceModule? _workspaceModule;
  static ProjectModule? _projectModule;
  static UserModule? _userModule;
  static TimeEntryModule? _timeEntryModule;

  /// Module for workspace operations.
  ///
  /// Use this to fetch and manage workspaces:
  /// ```dart
  /// final workspaces = await VitClockify.workspaces.getAll();
  /// ```
  static WorkspaceModule get workspaces =>
      _workspaceModule ??= WorkspaceModule();

  /// Module for project operations.
  ///
  /// Use this to fetch and manage projects within a workspace:
  /// ```dart
  /// final projects = await VitClockify.projects.getAll(
  ///   workspaceId: 'workspace-id',
  /// );
  /// ```
  static ProjectModule get projects => _projectModule ??= ProjectModule();

  /// Module for user operations.
  ///
  /// Use this to fetch and manage users within a workspace:
  /// ```dart
  /// final users = await VitClockify.users.getAll(
  ///   workspaceId: 'workspace-id',
  /// );
  /// ```
  static UserModule get users => _userModule ??= UserModule();

  /// Module for time entry operations.
  ///
  /// Use this to fetch time entries for users:
  /// ```dart
  /// final entries = await VitClockify.timeEntries.getForUser(
  ///   workspaceId: 'workspace-id',
  ///   userId: 'user-id',
  /// );
  /// ```
  static TimeEntryModule get timeEntries =>
      _timeEntryModule ??= TimeEntryModule();
}
