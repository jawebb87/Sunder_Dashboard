# Sunder_Dashboard — Comprehensive Analysis & Change Recommendations

**Date:** 2026-05-08 (updated)  
**Version Analyzed:** 1.1.0 (noSDK branch)  
**Analyst:** Hermes Agent  

---

## 1. Project Overview

Sunder_Dashboard is a modular UI dashboard for the **Sunder** combat framework in the MUD game **Aetolia**, built on the **Mudlet** client. It provides a tabbed Geyser-based interface with three pages — **Core**, **Defenses**, and **Class** — giving players instant access to Sunder toggles, defense profiles, and class-specific resources/actions/summons.

| Property | Value |
|---|---|
| Package Name | Sunder_Dashboard |
| Version | 1.1.0 |
| Author | Norrix/Zev/Jacob Webb |
| License | GPL-3.0 |
| Build System | muddle (Docker-based: `demonnic/muddler`) |
| Dependency | Sunder framework (`snd.*`) |
| Current Branch | `noSDK` |
| Class Modules | 30 Aetolian classes |

---

## 2. Architecture Assessment

### 2.1 Current Structure

```
src/
├── aliases/
│   ├── aliases.json
│   ├── community_menu.lua        — smenu command handler
│   └── defup_intercept.lua       — intercepts defup to re-apply profiles
├── scripts/
│   ├── ZevDash.lua               — Bootloader (core table init, sunder_login listener)
│   ├── configs/
│   │   ├── ZevDash_Default_Config.lua  — Default styles & layout
│   │   └── ZevDash_Custom_Config.lua   — User overrides (stub)
│   ├── system/
│   │   ├── ZevDash_Engine.lua    — BaseModule, registerClass(), helpers (load-time)
│   │   ├── ZevDash_Build.lua     — Geyser UI construction, show/hide logic
│   │   ├── ZevDash_Render.lua    — Page rendering, displayPage(), heartbeat sync
│   │   └── ZevDash_Persistence.lua — saveState/loadState/applyDefLocks (load-time)
│   ├── functions/
│   │   ├── ZevDash_ClassDetection.lua — getCurrentClass() via GMCP/snd (load-time)
│   │   ├── ZevDash_Help.lua      — Help text output
│   │   ├── ZevDash_Interactive.lua — toggleDef/toggleCore/doClassAction/toggleClass + hover
│   │   ├── ZevDash_SummonTracker.lua — GMCP Room.Items tracking
│   │   └── ZevDash_Tooltips.lua  — Core toggle tooltip strings
│   └── classes/
│       ├── scripts.json
│       ├── ZevDash_wayfarer.lua  — Full-featured (gauges, axe track, chants)
│       ├── ZevDash_Wayfarer_AxeTrack.lua — State machine for axe tracking
│       ├── ZevDash_predator.lua  — registerClass() + summons
│       ├── ZevDash_sentinel.lua  — registerClass() + summons
│       └── [27 more class files] — all use registerClass() pattern
├── triggers/
│   ├── triggers.json             — Wayfarer axe trigger group
│   └── [10 trigger .lua files]   — axe_caught, axe_thrown, etc. (class-guarded)
└── resources/
    └── Dashboard.png             — Package icon
```

### 2.2 Initialization Pipeline (v1.1.0 — current)

The initialization follows a **load-time registration + runtime activation** pattern:

```
═══ Package Load (runs once when installed/reloaded) ═══

Mudlet loads scripts in order from scripts.json:

1. ZevDash.lua (root)
   ├── Creates ZevDash table, profiles, ClassModules, class_toggles
   ├── Registers "sunder_login" handler (sets SunderReady, loads state, applies def locks)
   └── NO early return — always runs

2. configs/ — Default_Config, Custom_Config
   └── if not snd then return end — safe: only needed at runtime

3. system/ — Engine, Render, Persistence, Build
   ├── ZevDash_Engine.lua — Defines BaseModule, registerClass(), helpers at TOP LEVEL
   │   No `if not snd then return end` guard — these must exist for class registration
   ├── ZevDash_Persistence.lua — Defines saveState/loadState/applyDefLocks at TOP LEVEL
   │   Functions only reference `snd` at call time, not definition time
   ├── ZevDash_Render.lua — if not snd then return end — safe: only called at runtime
   └── ZevDash_Build.lua — if not snd then return end — safe: only called at runtime

4. functions/ — ClassDetection, Tooltips, Interactive, SummonTracker, Help
   ├── ZevDash_ClassDetection.lua — Defines getCurrentClass() at TOP LEVEL
   │   Has nil guards for snd and gmcp internally
   └── Others — if not snd then return end — safe: only called at runtime

5. classes/ — All 30 class files
   ├── Call ZevDash.registerClass("classname", {...}) at load time
   ├── NO `if not snd then return end` guard — registration must happen at load time
   └── Functions inside the config table reference `snd` at call time only

═══ Runtime Activation ═══

sunder_login event fires (Sunder loaded):
  └── ZevDash.lua handler → sets SunderReady, loadState(), applyDefLocks()

User types "smenu" → ZevDash.show():
  ├── Guards: SunderReady? snd.defenses? getCurrentClass()?
  ├── First time: ZevDash.build() → constructs Geyser UI, visible = true
  └── Subsequent: show(), loadState(), refresh active page

gmcp.Char.Status changes (class change):
  └── ZevDash_Engine handler → saveState(old), loadState(new), applyDefLocks(), refresh display

sunder_update_toggles heartbeat:
  └── if built && visible && SunderReady && class known → displayPage(active_page)
```

**Key design principle:** Functions that only reference `snd` at **call time** are defined at **load time** without an `if not snd then return end` guard. This ensures class modules can register themselves before `snd` exists. Functions that call `snd` APIs during their **definition** (e.g., config files that read `getFont()`) keep the guard since they're only needed at runtime anyway.

### 2.3 Live Update Loop

```
sunder_update_toggles → ZevDash_Render handler
  └── if built && visible && SunderReady && class known
        └── displayPage(active_page)  [full re-render]
```

---

## 3. Strengths

1. **Clean modular architecture** — The v1.1.0 refactor successfully separated concerns into Engine, Build, Render, Persistence, Interactive, and ClassDetection modules.
2. **Load-time registration** — `BaseModule`, `registerClass()`, and persistence functions are defined at load time, eliminating the race condition that previously prevented class modules from being found.
3. **Lazy UI construction** — The dashboard isn't built until the user explicitly calls `smenu`, avoiding premature Geyser operations.
4. **`registerClass()` API** — All 30 class modules now use the registration system with `BaseModule` metatable inheritance. New classes need minimal boilerplate.
5. **Generation counter for chants** — The `_chant_gen` pattern in `toggleChant` prevents race conditions from rapid state changes.
6. **Dynamic summon tracking** — Class modules declare their summons table, and the `SummonTracker` dynamically reads from it — no hardcoded global lists.
7. **Defense profile persistence** — Per-class defense profiles with save/load/apply is well-implemented.
8. **Axe tracking state machine** — The Wayfarer axe tracking module is thorough, covering all edge cases (thrown, caught, embedded, pulled, dropped, fumbled, secured, wielded).
9. **Class change handler** — Automatic save/load of defense profiles when multiclass switching, with dashboard refresh.
10. **Dynamic Core toggle filtering** — Core page hides toggles that are managed by any class module (not just the active class), preventing stale UI.

---

## 4. Issues Fixed in This Session

### 4.1 ✅ CRITICAL — Load Order Race Condition: Class Modules Not Found

**Root Cause:** `ZevDash.registerClass()` was defined inside a `ZevDash_CoreInitialized` event handler in `ZevDash_Engine.lua`. The event was raised by `ZevDash.lua` (which loads FIRST), but the handler was registered by `ZevDash_Engine.lua` (which loads THIRD). By the time Engine registered its handler, the event had already fired with no listeners.

Additionally, both `ZevDash.lua` and `ZevDash_Engine.lua` had `if not snd then return end` at the top. When `snd` didn't exist at package load time (the common case — package is installed before connecting), **neither file executed at all**, so:
- `ZevDash_CoreInitialized` was never raised
- `registerClass()` was never defined
- All 30 class files with `if not snd then return end` also bailed

Even when `snd` WAS available (e.g., reinstalling while connected), the event still fired before Engine's handler was registered, so `registerClass()` was still never defined.

**Fix Applied:**
- Removed `ZevDash_CoreInitialized` event entirely
- Moved `BaseModule`, `registerClass()`, and helper functions out of the event handler — defined at top level in `ZevDash_Engine.lua`
- Removed `if not snd then return end` from `ZevDash_Engine.lua`, `ZevDash_Persistence.lua`, `ZevDash_ClassDetection.lua`
- Removed `if not snd then return end` from all 30 class files
- Removed `if not snd then return end` from `ZevDash.lua` (bootloader must always run)
- Added nil-safe guard: `ZevDash._lastClass = ZevDash._lastClass or (ZevDash.getCurrentClass and ZevDash.getCurrentClass()) or "unknown"`

### 4.2 ✅ CRITICAL — Migrated All Class Modules to `registerClass()`

**Fix Applied:** All 27 legacy class modules migrated from direct `ZevDash.ClassModules["class"] = {}` assignment to `ZevDash.registerClass("class", {})` pattern. Removed duplicated `doAction`/`toggle`/`isToggleOn` boilerplate. Fixed `renderInfo` signature from `function(mc)` to `function(self, mc)` in all modules.

### 4.3 ✅ HIGH — Missing `visible` State Management

**Fix Applied:** Added `ZevDash.visible = true` after `ZevDash.build()` in first-build branch of `ZevDash.show()`.

### 4.4 ✅ HIGH — Stale "Wayfarer" Naming

**Fix Applied:** Updated "Wayfarer Dashboard" → "Sunder Dashboard" in `ZevDash_Custom_Config.lua`.

### 4.5 ✅ MEDIUM — Wayfarer-Only Triggers Always Active

**Fix Applied:** Added `if ZevDash.getCurrentClass() ~= "wayfarer" then return end` guard to all 10 Wayfarer trigger scripts.

### 4.6 ✅ MEDIUM — `applyDefLocks` Missing Class Defs

**Status:** Already fixed in current code — both `general_defs` and `currentClass` defs are included.

### 4.7 ✅ MEDIUM — `send("\n")` Side Effect

**Fix Applied:** Removed `send("\n")` from `load_def2` monkey-patch in `ZevDash_Build.lua`.

### 4.8 ✅ MEDIUM — No Class Change Event Handler

**Fix Applied:** Added `gmcp.Char.Status` event handler in `ZevDash_Engine.lua` that detects class changes, saves old profile, loads new profile, applies def locks, and refreshes display.

### 4.9 ✅ MEDIUM — Core Toggle Filtering is Static

**Fix Applied:** Replaced hardcoded `ignore_core` table with dynamic scan of ALL `ZevDash.ClassModules` toggles+actions. Any toggle managed by any class module is hidden from the Core page.

### 4.10 ✅ LOW — Inconsistent Geyser Element Naming

**Fix Applied:** Renamed `Class_Btn_ClassTab` → `ZevBtn_ClassTab`.

### 4.11 ✅ LOW — Sciomancer Empty Toggle Name

**Fix Applied:** `{ id = "gravity secure", name = "" }` → `{ id = "gravity secure", name = "Secure" }`.

### 4.12 ✅ LOW — Missing GMCP Nil Guard

**Fix Applied:** Wayfarer `renderInfoLabel` now uses `(gmcp and gmcp.Char and gmcp.Char.Vitals and tonumber(gmcp.Char.Vitals.Fury)) or 0`.

### 4.13 ✅ LOW — Typos

**Fix Applied:** "contatct" → "contact" in mfile, "Dash_autit.txt" → "Dash_audit.txt" in .gitignore.

### 4.14 ✅ LOW — Missing `close` Command Documentation

**Fix Applied:** Added `smenu close` line to help text in `ZevDash_Help.lua`.

### 4.15 ✅ LOW — Save File Naming

**Fix Applied:** Renamed `ZevDash_Profiles_Community.lua` → `ZevDash_Profiles.lua` with auto-migration for existing users.

---

## 5. Remaining Issues & Enhancement Opportunities

### 5.1 SunderSDK Integration

**Status:** User decided AGAINST a separate SunderSDK package — it creates user confusion and an extra download. Integration stays in-package using the `registerClass()`/`BaseModule` pattern.

The codebase still has tight coupling to `snd.*` throughout:

| File | Direct `snd.*` Dependencies |
|---|---|
| ZevDash.lua | `snd.toggles`, `snd.save` |
| ZevDash_Engine.lua | `snd.set_queue`, `snd.toggles`, `snd.save` |
| ZevDash_Build.lua | `snd.load_def2`, `snd.defenses`, `snd.toggles` |
| ZevDash_Render.lua | `snd.toggles`, `snd.defenses`, `snd.def_options`, `snd.charstats` |
| ZevDash_Persistence.lua | `snd.defenses`, `snd.def_options` |
| ZevDash_Interactive.lua | `snd.toggle`, `snd.toggles`, `snd.defenses` |
| ZevDash_wayfarer.lua | `snd.set_queue` (3 calls, all nil-guarded) |

All `snd.*` references are at **call time** with nil guards. This is acceptable for now.

### 5.2 Runtime Scripts Still Have `if not snd then return end`

These files retain the guard because they're only needed at runtime (after `sunder_login`):
- `ZevDash_Build.lua` — UI construction
- `ZevDash_Render.lua` — Page rendering (2 guards)
- `ZevDash_Interactive.lua` — Click handlers (2 guards)
- `ZevDash_Tooltips.lua` — Tooltip strings
- `ZevDash_SummonTracker.lua` — GMCP tracking
- `ZevDash_Default_Config.lua` — Style configuration
- `ZevDash_Custom_Config.lua` — User overrides

This is safe — these scripts define functions that are only called after `sunder_login`, at which point `snd` exists. The guard prevents unnecessary work at load time.

### 5.3 Class-Specific Resource Tracking (Beyond Wayfarer)

Only the Wayfarer class has real-time resource tracking (Fury gauge, axe state). Other classes with notable resources (e.g., Praenomen blood, Luminary devotion, Bloodborn blood, Carnifex souls) only show static text headers.

**Recommendation:** Add gauge-based resource tracking for classes that have quantifiable resources exposed via GMCP `Char.Vitals` or `Char.Stats`.

### 5.4 Window Layout Persistence

The current code saves window layout via `sysSaveEvent`, but there's no mechanism to auto-show the dashboard on login if it was previously open.

**Recommendation:** Persist the `visible` state and auto-show the dashboard on `sunder_login` if it was previously open.

### 5.5 Missing Class Actions

Several classes have modules with empty `actions` tables. Review with domain experts to ensure all class-relevant actions are captured:
- Classes with empty `actions`: praenomen, bard, bloodborn, earthcaller, indorani, ravager, teradrim, and others
- These classes likely have combat actions that should be surfaced as buttons

### 5.6 Tooltip Coverage is Incomplete

`ZevDash_Tooltips.lua` only has entries for ~30 core toggles. Many toggles have no tooltip.

**Recommendation:** Add tooltips for all common Sunder toggles. Consider class-specific tooltips in class module definitions.

### 5.7 `defup_intercept` Timing is Fragile

The `defup_intercept` alias uses a hardcoded `tempTimer(0.2, ...)` delay. This timing assumption may break on slow connections.

**Recommendation:** Listen for a Sunder-specific event that signals defense table reconstruction is complete.

---

## 6. Configuration & Build Quality

### 6.1 muddle.json ✅
- Correctly lists all 7 component JSON files
- Package name and version match `mfile`

### 6.2 mfile ✅
- Typo fixed: "contatct" → "contact"
- Version: 1.1.0 — matches `muddle.json`
- Dependencies: Correctly declares "Sunder"

### 6.3 .gitignore ✅
- Typo fixed: `Dash_autit.txt` → `Dash_audit.txt`
- `*.mpackage` is properly ignored

### 6.4 CHANGELOG.md ✅
- Well-structured, documents the v1.1.0 refactor clearly

### 6.5 README.md ⚠️
- Good feature list and usage instructions
- Could document: class change behavior, auto-detection, `close` command

---

## 7. Summary of Changes by Priority

| Priority | Issue | Status |
|---|---|---|
| 🔴 Critical | Load order race condition — class modules not found | ✅ Fixed |
| 🔴 Critical | Migrate all class modules to `registerClass()` | ✅ Fixed |
| 🔴 Critical | Fix `renderInfo` signature inconsistency | ✅ Fixed |
| 🟠 High | Fix missing `visible = true` on first build | ✅ Fixed |
| 🟠 High | Update stale "Wayfarer" references | ✅ Fixed |
| 🟡 Medium | Make Wayfarer triggers class-aware | ✅ Fixed |
| 🟡 Medium | Fix `applyDefLocks` to include class defs | ✅ Fixed (pre-existing) |
| 🟡 Medium | Remove `send("\n")` side effect | ✅ Fixed |
| 🟡 Medium | Add class change event handler | ✅ Fixed |
| 🟡 Medium | Dynamic Core toggle filtering | ✅ Fixed |
| 🟢 Low | Standardize Geyser naming | ✅ Fixed |
| 🟢 Low | Fix sciomancer empty toggle name | ✅ Fixed |
| 🟢 Low | Add GMCP nil guards in class renders | ✅ Fixed |
| 🟢 Low | Fix typos (mfile, .gitignore) | ✅ Fixed |
| 🟢 Low | Rename save file from "Community" | ✅ Fixed |
| 🟢 Low | Document `close` command | ✅ Fixed |

---

## 8. Load Order Reference

For future debugging, here is the exact script execution order as generated by muddle:

1. `ZevDash` (bootloader) — core table init, sunder_login handler
2. `ZevDash_Default_Config` — styles (guards: `if not snd then return end`)
3. `ZevDash_Custom_Config` — user overrides (guards: `if not snd then return end`)
4. `ZevDash_Engine` — BaseModule, registerClass(), helpers, class change handler ⚡ **NO GUARD**
5. `ZevDash_Render` — displayPage, heartbeat (guards: `if not snd then return end`)
6. `ZevDash_Persistence` — saveState/loadState/applyDefLocks ⚡ **NO GUARD**
7. `ZevDash_Build` — Geyser UI construction (guards: `if not snd then return end`)
8. `ZevDash_Tooltips` — tooltip strings (guards: `if not snd then return end`)
9. `ZevDash_ClassDetection` — getCurrentClass() ⚡ **NO GUARD**
10. `ZevDash_Interactive` — click handlers (guards: `if not snd then return end`)
11. `ZevDash_SummonTracker` — GMCP tracking (guards: `if not snd then return end`)
12. `ZevDash_Help` — help text (no `snd` dependency)
13–42. All 30 class files — registerClass() calls ⚡ **NO GUARD**

Scripts marked ⚡ are the **load-time critical path** — they must execute even when `snd` doesn't exist yet, because their output is needed by other scripts or by the runtime system later.

---

*End of analysis.*
