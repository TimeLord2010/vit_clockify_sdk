# VitClockify SDK

A clean and type-safe Dart SDK for interacting with the [Clockify API](https://clockify.me/api).

Clockify is a simple time tracking tool. This SDK provides a convenient interface to:

- Fetch workspaces
- List projects within workspaces
- Get users in workspaces
- Retrieve time entries with flexible date filtering

## Features

- **API Key Management**: Set your API key once with `VitClockify.apiKey = "key"`
- **Module-Based Architecture**: Dedicated modules for workspaces, projects, users, and time entries
- **Type-Safe**: Fully typed responses with strong Dart type conventions

## Implemented Use Cases

### Workspaces

- **List workspaces**: Retrieve all workspaces accessible with the current API key

### Projects

- **List projects in workspace**: Fetch all projects within a specific workspace

### Users

- **List users in workspace**: Get all users in a specific workspace

### Time Entries

- **Create time entry**: Create a new time entry in Clockify

- **Get time entries for user**: Retrieve time entries for a specific user with optional date filtering

## Getting Started

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

## More Information

- [Clockify Official API Documentation](https://clockify.me/api)
- [Clockify Website](https://clockify.me)

## License

This package is open source and available under the MIT License.
