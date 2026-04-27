# Changelog

All notable changes to this project will be documented in this file.

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
