# Changelog - v1.0.4

## Core Architecture

- **First-Time Setup**:
  - Implemented an initialization check that safely imports Sunder's default defense settings (its native `needit` states) when loading a class profile for the very first time.
  - This prevents the dashboard from turning off all defenses if a user opens it before setting up their profile, providing a much friendlier out-of-the-box experience.

- **Centralized Class Resource Handling**:
  - Implemented `ZevDash.renderResources(mc)` in a new [ZevDash_GetResource.lua](file:///home/zev/Dev/Sunder_Dashboard/src/scripts/ZevDash_GetResource.lua) script.
  - The dashboard now dynamically iterates through `snd.charstats` to display class resources (Fury, Blood, Essence, etc.), automatically title-casing them.
  - This eliminates the need for manual resource definitions for every class.

- **System-Wide Script Optimization**:
  - Cleaned up **31 class scripts** in `src/scripts/classes/`, removing hundreds of lines of redundant hardcoded resource rendering logic.
  - Standardized the module structure across all classes.

## Sunder Integration

- **Defense Load Nudge**:
  - Modified the `snd.load_def2` hook in [ZevDash.lua](file:///home/zev/Dev/Sunder_Dashboard/src/scripts/ZevDash.lua) to execute `send("\n")` immediately after applying dashboard defense locks.
  - This "nudge" ensures that Sunder re-evaluates and applies defensive states correctly upon initialization or class change.

## Class Integration (Wayfarer)

- **Battlechant UI Synchronization**:
  - Implemented dynamic, latency-synced UI updates for Battlechants.
  - The dashboard now utilizes `getNetworkLatency()` and a dedicated failure trigger (`chant_failed.lua`) to ensure that a chant toggle only visually turns off if the server confirms the `CEASE` command was successful (preventing UI desync when off Fury balance).
- **Core Pane Fix**:
  - Wayfarer Battlechants no longer improperly populate on the Core settings pane.
