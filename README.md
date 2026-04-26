# Sunder Dashboard

![Version](https://img.shields.io/badge/version-1.0.4-blue)
![Dependency](https://img.shields.io/badge/dependency-Sunder-green)
![Platform](https://img.shields.io/badge/platform-Mudlet-maroon)

A modular dashboard system for the **Sunder** framework in Aetolia. This UI is designed to give you instant access to your core toggles, defenses, and class-specific resources in a clean, tabbed interface.

## 🚀 Features

- **Modular Tab System**: Switch between Core, Defenses, and Class-specific data.
- **Class Detection**: Automatically detects your current class via GMCP and loads the appropriate module.
- **Resource Tracking**: Real-time tracking of class resources (e.g., Fury for Wayfarers, Blood for Praenomen).
- **Summon Monitoring**: Dynamic tracking of class summons in the room.
- **Persistence**: Saves your defense profiles per class, so your setup is exactly how you left it.
- **Smart Toggle**: A robust UI summoning system that handles window visibility and layout resets.

## 📥 Installation

1. Download the latest `.mpackage` from the Releases tab on GitHub.
2. In Mudlet, open the **Package Manager**.
3. Click **Install** and select the downloaded file.
4. Type `smenu` in your Mudlet input line to summon the dashboard.

## 🎮 Commands

- `smenu` - Toggles the dashboard UI on or off.
- `smenu reset` - Resets the window position to (10, 10) and default size.
- `smenu help` - Displays the main help menu in your console.
- `smenu help config` - Shows detailed instructions for customization.

## 🛠 Development

This project uses [muddle](https://github.com/demonnic/muddle) to build the Mudlet package.

### Prerequisites

- Java (for running the muddle jar)
- VSCode (recommended)

### Building

If you are using the provided VS Code workspace:

1. Open `Sunder_Dashboard.code-workspace`.
2. Press `Ctrl+Shift+B` to run the **Build Sunder Dashboard** task.
3. The output `.mpackage` will be generated in the `build/` directory.

### Project Structure

- `src/scripts/`: Core logic and framework scripts.
- `src/scripts/classes/`: Individual modules for every Aetolian class.
- `src/aliases/`: Aliases and command intercepts.

## 🎨 Customization

You can customize the look and feel of your dashboard by editing `src/scripts/ZevDash_Custom_Config.lua`. This allows you to override default colors, borders, and hover effects without touching the core framework.

---

**Created by Zev/Jacob Webb**
*Discord: zev7984*

If you encounter any bugs or have feature suggestions, feel free to reach out!
