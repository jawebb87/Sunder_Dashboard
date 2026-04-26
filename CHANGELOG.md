# Changelog

All notable changes to this project will be documented in this file.

## [1.0.4] - 2026-04-26

### Added

- **Wayfarer Precision Sync**: Implemented a latency-aware toggle system for Battlechants. Toggles now wait for server confirmation before updating UI state.
- **First-Time Setup**: Automatic importation of Sunder's default defense state (`needit`) when a class profile is first initialized.
- **Fury Balance Trigger**: New trigger for "You cannot bring forth your Fury again just yet" to prevent UI desync during rapid toggling.

### Changed

- **UI Organization**: Battlechant toggles have been removed from the "Core" page and now live exclusively in the class-specific tab.
- **Resource Management**: Refactored internal resource handling to be more dynamic and class-agnostic.
- **Font Scaling**: Improved stylesheet injection for more consistent font rendering across different Mudlet display settings.
