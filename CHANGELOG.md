# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0] - 2026-05-02

### Added
- Integrated Sunder_SDK for standardized Sunder framework access
- New event system using SunderSDKTablesReady for proper initialization sequencing
- Modular API wrappers for snd.* functionality

### Changed
- Replaced all direct snd.* calls with SunderSDK equivalents
- Updated event handling from sunder_login to SunderSDKTablesReady
- Refactored state management through SDK functions
- Moved to proper Mudlet package structure with SDK integration

### Fixed
- Resolved premature execution issues by following Mudlet best practices
- Improved initialization timing for better compatibility

## [1.1.0] - 2026-04-27

### Added
- **Generation Counter**: Implemented a per-invocation ID system in `toggleChant` to eliminate race conditions during rapid state changes.
- **Architectural Refactor**: Decoupled tooltips and summon tracking into dedicated modules (`ZevDash_Tooltips.lua`, `ZevDash_SummonTracker.lua`) for better maintainability.

### Changed
- Improved toggle management with better state persistence
- Enhanced class-specific functionality for all supported classes
- Refined UI rendering for better responsiveness

### Fixed
- Resolved several race conditions in toggle state changes
- Fixed hover and click handling in various UI elements
- Corrected state synchronization issues

