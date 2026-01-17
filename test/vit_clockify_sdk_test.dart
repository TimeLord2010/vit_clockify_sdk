import 'package:vit_clockify_sdk/vit_clockify_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('VitClockify SDK', () {
    setUp(() {
      // Reset API key before each test
      VitClockify.apiKey = null;
    });

    test('API key can be set and retrieved', () {
      const testKey = 'test-api-key-123';
      VitClockify.apiKey = testKey;
      expect(VitClockify.apiKey, equals(testKey));
    });

    test('API key can be cleared', () {
      VitClockify.apiKey = 'test-key';
      VitClockify.apiKey = null;
      expect(VitClockify.apiKey, isNull);
    });

    test('modules are accessible', () {
      expect(VitClockify.workspaces, isNotNull);
      expect(VitClockify.projects, isNotNull);
      expect(VitClockify.users, isNotNull);
      expect(VitClockify.timeEntries, isNotNull);
    });
  });

  group('Models', () {
    test('Workspace can be created from JSON', () {
      final json = {
        'id': 'ws-123',
        'name': "John's workspace",
      };
      final workspace = Workspace.fromJson(json);
      expect(workspace.id, equals('ws-123'));
      expect(workspace.name, equals('John')); // suffix removed
    });

    test('User can be created from JSON', () {
      final json = {
        'id': 'user-123',
        'name': 'John Doe',
      };
      final user = User.fromJson(json);
      expect(user.id, equals('user-123'));
      expect(user.name, equals('John Doe'));
    });

    test('HourlyRate can be created from JSON', () {
      final json = {'amount': 50.0};
      final rate = HourlyRate.fromJson(json);
      expect(rate.amount, equals(50.0));
    });

    test('Project color is normalized', () {
      final json = {
        'id': 'proj-123',
        'name': 'Test Project',
        'color': '#FF0000',
        'archived': false,
        'memberships': [],
      };
      final project = Project.fromJson(json);
      expect(project.color, equals('FF0000')); // # removed
    });

    test('TimeInterval duration is calculated', () {
      final start = DateTime(2026, 1, 15, 9, 0);
      final end = DateTime(2026, 1, 15, 10, 30);
      final interval = TimeInterval(start: start, end: end);
      expect(interval.duration, equals(Duration(hours: 1, minutes: 30)));
    });
  });

  group('Exception Types', () {
    test('ClockifyException has message', () {
      final exception = ClockifyException(message: 'Test error');
      expect(exception.message, equals('Test error'));
    });

    test('ClockifyAuthException indicates auth failure', () {
      final exception = ClockifyAuthException(message: 'Invalid API key');
      expect(exception.statusCode, equals(401));
    });

    test('ClockifyNotFoundException indicates 404', () {
      final exception = ClockifyNotFoundException(message: 'Not found');
      expect(exception.statusCode, equals(404));
    });

    test('ClockifyNetworkException for network errors', () {
      final exception = ClockifyNetworkException(message: 'Connection failed');
      expect(exception.statusCode, isNull);
    });
  });
}
