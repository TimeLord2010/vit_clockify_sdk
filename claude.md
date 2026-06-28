# Claude Development Guidelines

This file contains important guidelines for maintaining the vit_clockify_sdk package.

## Documentation Requirements

### When adding or changing features:

1. **Always update the README.md** when implementing new features or modifying existing functionality
   - Add new features to the "Implemented Use Cases" section under the appropriate module
   - Use consistent formatting: `- **Feature name**: Brief description of what it does`
   - Keep descriptions concise but informative

2. **Update CHANGELOG.md** following semantic versioning conventions
   - Document all changes in the appropriate version section
   - Use standard prefixes: `feat:`, `fix:`, `docs:`, etc.

3. **Version bumping** should be done in pubspec.yaml according to:
   - Major version: Breaking changes
   - Minor version: New features (backwards compatible)
   - Patch version: Bug fixes (backwards compatible)

## Code Conventions

### Module Classes
- Classes ending with `Module` must have **instance methods only** (no `static` methods)
- Module instances are accessed through the unified `VitClockify` class (e.g., `VitClockify.timeEntries.create()`)
- All public methods in modules must be instance methods to maintain consistent access patterns

Example:
```dart
// ✅ CORRECT - Instance methods
class TimeEntryModule {
  Future<TimeEntry> create(TimeEntryRequest request) async { }
  Future<void> delete(String workspaceId, String entryId) async { }
}

// ❌ WRONG - Static methods
class TimeEntryModule {
  static Future<TimeEntry> create(TimeEntryRequest request) async { }
  static Future<void> delete(String workspaceId, String entryId) async { }
}
```

## Pre-Release Checklist

**CRITICAL**: Complete this checklist BEFORE publishing a new version to pub.dev.

### Code Validation
- [ ] Run `dart analyze` and fix all errors/warnings
- [ ] Run `dart pub get` and verify no dependency issues
- [ ] Ensure all public APIs are properly exported in `lib/vit_clockify_sdk.dart`
- [ ] Check that all types referenced in modules are accessible (no missing imports/exports)
- [ ] Verify all methods compile without syntax errors

### Feature Completeness
- [ ] All features mentioned in CHANGELOG.md are fully implemented and functional
- [ ] All newly added modules/classes are properly integrated into the main `VitClockify` class
- [ ] No incomplete or partial implementations in the released code
- [ ] Test that features work when accessed through the unified `VitClockify` class

### Documentation Sync
- [ ] README.md updated with new features under "Implemented Use Cases"
- [ ] CHANGELOG.md updated with version changes (use standard prefixes: `feat:`, `fix:`, `docs:`)
- [ ] All public methods have dartdoc comments with examples
- [ ] CHANGELOG.md matches what's actually in the code (no promised features missing)

### Version Management
- [ ] pubspec.yaml version bumped appropriately:
  - Major: Breaking changes
  - Minor: New features (backwards compatible)
  - Patch: Bug fixes (backwards compatible)
- [ ] Version number is consistent across pubspec.yaml, CHANGELOG.md, and README.md

### Before Publishing
- [ ] All uncommitted changes are committed
- [ ] Run `dart pub publish --dry-run` to verify package is publishable
- [ ] Double-check that the version being released hasn't been published before

## Why This Matters

Keeping documentation in sync with code changes and ensuring code quality:

- Users can discover and understand new features
- The package appears professional and well-maintained on pub.dev
- Contributors understand the current state of the project
- Prevents shipping broken or incomplete features
- Maintains user trust in the package reliability
