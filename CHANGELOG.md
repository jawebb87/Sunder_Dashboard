# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0] - 2026-05-09

### Fixed
- **Critical: Removed all SunderSDK references** — SunderSDK was abandoned but code still called `SunderSDK.initialize()`, `SunderSDK.events.registerEventHandler()`, and `SunderSDK.api.*`. All replaced with direct `snd.*` calls and `sunder_login` event.
- **Critical: Fixed bootloader load-order bug** — `ZevDash.lua` had `if not snd then return end` which prevented the bootloader from initializing when `snd` wasn't loaded yet. Class files that call `registerClass()` at load time would fail silently.
- **Critical: Fixed Engine.lua duplicate BaseModule** — A second BaseModule definition using SunderSDK was embedded inside the class-change event handler, overwriting the correct top-level definition at runtime. Removed the duplicate; BaseModule is now defined once at top level.
- **Fixed Engine.lua broken event handler** — The class-change handler had mismatched `if/end` blocks causing a Lua syntax error on load.
- **Fixed Zealot module** — Removed SunderSDK references, `if not snd then return end` guard (class modules must run at load time), and redundant `doAction`/`toggle` overrides that duplicated BaseModule.

### Changed
- Bootloader now uses `sunder_login` event directly instead of abandoned `SunderSDKTablesReady` event.
- All `snd.*` calls are at call time (inside function bodies), not definition time — safe to define at load time even when `snd` doesn't exist yet.

## [1.1.0] - 2026-04-27

### Added
- **Generation Counter**: Implemented a per-invocation ID system in `toggleChant` to eliminate race conditions during rapid state changes.
- **Architectural Refactor**: Decoupled tooltips and summon tracking into dedicated modules (`ZevDash_Tooltips.lua`, `ZevDash_SummonTracker.lua`) for better maintainability.
- **Dynamic Summon Tracking**: Entities are now tracked dynamically based on the active class module's configuration, removing hardcoded global lists.
- **Class Module Engine**: Introduced `ZevDash.registerClass` to standardize class module initialization and reduce boilerplate.
- **Event-Driven Boot Pipeline**: Implemented a robust initialization sequence using custom Mudlet events (`ZevDash_CoreInitialized`, `ZevDash_SunderReady`, `ZevDash_UiBuilt`). This ensures that modules only initialize once their dependencies are fully available, eliminating load-time race conditions.
- **Asynchronous Initialization**: Decoupled the Geyser UI build process from the script load event, allowing the dashboard to wait for the Sunder framework handshake before constructing the window.
- **Modular Monolith Extraction**: Carved up the core engine into 7 specialized modules (`ClassDetection`, `Persistence`, `Engine`, `Build`, `Interactive`, `Render`, and the `ZevDash` bootloader) to improve maintainability and decouple UI construction from data logic.
- **Improved Build Order**: Standardized the initialization sequence in `scripts.json` to ensure configuration and core modules load before the event listeners fire.

### Changed
- **Class Data Simplification**: Refactored Predator, Sentinel, and Executor modules to use the new dynamic summons table structure.
