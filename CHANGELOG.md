# Changelog - v1.0.3

## UI & Layout

- **Dynamic Layout Engine**: Migrated all hardcoded UI dimensions from `ZevDash.lua` to `ZevDash.Layout` in the configuration.
- **Auto-Scaling Buttons**: Implemented dynamic math for button positioning (`y = height + gap`). The dashboard now automatically reflows if button sizes or gaps are adjusted in the config.
- **Simplified Window Management**:
  - Renamed `ZevDash.toggle()` to `ZevDash.show()` to prevent accidental toggling via clicks.
  - Added `ZevDash.hide()` for clean window closing.
  - Updated `smenu` alias to call `show()` and added `smenu close` command.

## Class Integration (Wayfarer)

- **Battlechant Support**:
  - Replaced the "Actions" column for Wayfarers with a **"BATTLECHANTS"** column.
  - Imported `toggleChant` logic to handle automatic `CEASE` commands and UI highlighting.
- **Axe Tracking Module**:
  - Added [ZevDash_Wayfarer_AxeTrack.lua](file:///home/zev/Dev/Sunder_Dashboard/src/scripts/classes/ZevDash_Wayfarer_AxeTrack.lua) to manage state for `Held`, `Air`, `Embedded`, and `Secured` axes.
  - Integrated Axe Tracking stats (including Belt tracking) directly into the Wayfarer Class info pane.
- **Permanent Triggers**:
  - Migrated 18 tracking patterns from temporary Lua triggers to permanent system triggers managed via `muddle`.

## Core Dashboard Enhancements

- **Dynamic Headers**: Added support for `module.actionHeader` and `module.toggleHeader`, allowing class-specific column naming.
- **Action Highlighting**: Actions (Column A) can now be highlighted as "ON" (e.g., for active chants) if supported by the class module.
