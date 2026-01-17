import 'package:vit_clockify_sdk/vit_clockify_sdk.dart';

Future<void> main() async {
  // Set your API key here
  VitClockify.apiKey = 'YOUR_CLOCKIFY_API_KEY_HERE';

  try {
    // Fetch all workspaces
    print('Fetching workspaces...');
    final workspaces = await VitClockify.workspaces.getAll();
    print('Found ${workspaces.length} workspace(s)');

    if (workspaces.isEmpty) {
      print('No workspaces found. Check your API key.');
      return;
    }

    final workspace = workspaces.first;
    print('\nUsing workspace: ${workspace.name} (ID: ${workspace.id})');

    // Fetch projects in the workspace
    print('\nFetching projects...');
    final projects = await VitClockify.projects.getAll(
      workspaceId: workspace.id,
    );
    print('Found ${projects.length} project(s)');
    for (final project in projects.take(3)) {
      print(
        '  - ${project.name} (${project.archived ? 'archived' : 'active'})',
      );
    }

    // Fetch users in the workspace
    print('\nFetching users...');
    final users = await VitClockify.users.getAll(workspaceId: workspace.id);
    print('Found ${users.length} user(s)');

    if (users.isEmpty) {
      print('No users found in this workspace.');
      return;
    }

    // Fetch time entries for the first user
    final user = users.first;
    print('\nFetching time entries for ${user.name}...');
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);

    final timeEntries = await VitClockify.timeEntries.getForUser(
      workspaceId: workspace.id,
      userId: user.id,
      startDate: startOfMonth,
      endDate: now,
    );

    print('Found ${timeEntries.length} time entries');

    if (timeEntries.isNotEmpty) {
      // Calculate total duration
      final totalDuration = timeEntries.fold<Duration>(
        Duration.zero,
        (sum, entry) => sum + entry.timeInterval.duration,
      );
      final hours = totalDuration.inHours;
      final minutes = totalDuration.inMinutes % 60;
      print('Total time tracked: ${hours}h ${minutes}m');

      // Show first few entries
      print('\nRecent entries:');
      for (final entry in timeEntries.take(3)) {
        final duration = entry.timeInterval.duration;
        final description = entry.description;
        print(
          '  - $description (${duration.inHours}h ${duration.inMinutes % 60}m)',
        );
      }
    }
  } on ClockifyAuthException catch (e) {
    print('Authentication error: ${e.message}');
    print('Make sure your API key is correct.');
  } on ClockifyNotFoundException catch (e) {
    print('Resource not found: ${e.message}');
  } on ClockifyNetworkException catch (e) {
    print('Network error: ${e.message}');
  } on ClockifyException catch (e) {
    print('API error: ${e.message}');
  }
}
