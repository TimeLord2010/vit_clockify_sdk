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

## Pre-Release Checklist

Before pushing a new version:
- [ ] README.md updated with new features
- [ ] CHANGELOG.md updated with version changes
- [ ] pubspec.yaml version bumped appropriately
- [ ] All tests passing
- [ ] Code documented with proper dartdoc comments

## Why This Matters

Keeping documentation in sync with code changes ensures:
- Users can discover and understand new features
- The package appears professional and well-maintained on pub.dev
- Contributors understand the current state of the project
- Version history is clear and traceable
