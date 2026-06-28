## 1.2.1

- Fix: Corrected TimeEntryModule.update method syntax
- Fix: TaskModule methods are now instance methods (following module pattern)
- Fix: Task and SortOrder models are now properly exported

## 1.2.0

- Add `TaskModule` with `create`, `find`, and `delete` methods for managing project tasks.
- Add `update` method to `TimeEntryModule` to update an existing time entry.
- Add `delete` method to `TimeEntryModule` to delete a time entry.

## 1.1.0

- Add `id` field to TimeEntry model.
- Add `stopTimer` method to stop a running timer.
- Add `getRunningTimer` method to retrieve the currently running timer.

## 1.0.1

- Allow TimeInterval to have null end dates.

## 1.0.0

- Initial version.
