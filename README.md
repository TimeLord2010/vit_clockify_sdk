# VitClockify SDK

A clean and type-safe Dart SDK for interacting with the [Clockify API](https://clockify.me/api).

Clockify is a simple time tracking tool. This SDK provides a convenient interface to:
- Fetch workspaces
- List projects within workspaces
- Get users in workspaces
- Retrieve time entries with flexible date filtering

## Features

- 🔐 **Simple API Key Management**: Set your API key once with `VitClockify.apiKey = "key"`
- 📦 **Module-Based Architecture**: Clean separation of concerns with dedicated modules for each resource type
- ⚡ **Type-Safe**: Fully typed responses with strong Dart conventions
- 🛡️ **Error Handling**: Custom exception hierarchy for precise error handling
- 📝 **Well Documented**: Comprehensive dartdoc comments for all public APIs
- 🔄 **Async/Await**: Modern async API with Futures

## Getting Started

### Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  vit_clockify_sdk: ^0.1.0
```

Then run:

```bash
dart pub get
```

### Prerequisites

You'll need a Clockify API key. Get one from your [Clockify profile settings](https://app.clockify.me/user/settings).

## Usage

### Basic Example

```dart
import 'package:vit_clockify_sdk/vit_clockify_sdk.dart';

Future<void> main() async {
  // Set your API key
  VitClockify.apiKey = 'your-api-key-here';

  try {
    // Fetch all workspaces
    final workspaces = await VitClockify.workspaces.getAll();
    print('Workspaces: $workspaces');

    if (workspaces.isNotEmpty) {
      final workspace = workspaces.first;

      // Fetch projects
      final projects = await VitClockify.projects.getAll(
        workspaceId: workspace.id,
      );
      print('Projects: $projects');

      // Fetch users
      final users = await VitClockify.users.getAll(
        workspaceId: workspace.id,
      );
      print('Users: $users');
    }
  } on ClockifyException catch (e) {
    print('Error: $e');
  }
}
```

### Fetching Time Entries

```dart
final entries = await VitClockify.timeEntries.getForUser(
  workspaceId: 'workspace-id',
  userId: 'user-id',
  startDate: DateTime(2026, 1, 1),
  endDate: DateTime(2026, 1, 31),
);

for (final entry in entries) {
  print('${entry.description}: ${entry.timeInterval.duration}');
}
```

### Error Handling

```dart
import 'package:vit_clockify_sdk/vit_clockify_sdk.dart';

try {
  final workspaces = await VitClockify.workspaces.getAll();
} on ClockifyAuthException catch (e) {
  print('Invalid API key: ${e.message}');
} on ClockifyNetworkException catch (e) {
  print('Network error: ${e.message}');
} on ClockifyException catch (e) {
  print('API error: ${e.message}');
}
```

## API Reference

### VitClockify Class

Main entry point for the SDK.

#### Static Properties

- `apiKey` - Get/set the API key for authentication

#### Static Modules

- `workspaces` - Access workspace operations
- `projects` - Access project operations
- `users` - Access user operations
- `timeEntries` - Access time entry operations

### Workspace Module

```dart
// Get all workspaces
final workspaces = await VitClockify.workspaces.getAll();
```

### Project Module

```dart
// Get all projects in a workspace
final projects = await VitClockify.projects.getAll(
  workspaceId: 'workspace-id',
);
```

### User Module

```dart
// Get all users in a workspace
final users = await VitClockify.users.getAll(
  workspaceId: 'workspace-id',
);
```

### TimeEntry Module

```dart
// Get time entries for a user
final entries = await VitClockify.timeEntries.getForUser(
  workspaceId: 'workspace-id',
  userId: 'user-id',
  startDate: DateTime(2026, 1, 1),
  endDate: DateTime(2026, 1, 31),
);
```

## Models

### Workspace

```dart
class Workspace {
  final String id;
  final String name;
}
```

### Project

```dart
class Project {
  final String id;
  final String name;
  final String color;  // Hex color (e.g., 'FF0000')
  final bool archived;
  final List<Membership> memberships;
}
```

### User

```dart
class User {
  final String id;
  final String name;
}
```

### TimeEntry

```dart
class TimeEntry {
  final String? description;
  final HourlyRate hourlyRate;
  final String? projectId;
  final String userId;
  final TimeInterval timeInterval;
}
```

### TimeInterval

```dart
class TimeInterval {
  final DateTime start;
  final DateTime end;
  Duration get duration;
}
```

## Exception Types

The SDK provides specific exception types for error handling:

- `ClockifyAuthException` - Authentication failed (invalid API key)
- `ClockifyNotFoundException` - Resource not found (404)
- `ClockifyRateLimitException` - API rate limit exceeded (429)
- `ClockifyServerException` - Server error (500+)
- `ClockifyNetworkException` - Network connectivity issues
- `ClockifyException` - Base exception for other errors

## More Information

- [Clockify Official API Documentation](https://clockify.me/api)
- [Clockify Website](https://clockify.me)

## License

This package is open source and available under the MIT License.
