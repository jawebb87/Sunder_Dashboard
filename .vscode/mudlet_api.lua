---@meta

--- Mudlet API Stubs for Lua Language Server
--- This file provides definitions for Mudlet-specific extensions to the Lua API.

---@class table
table = {}
--- Saves a table to a file.
---@param filename string
---@param t table
function table.save(filename, t) end
--- Loads a table from a file.
---@param filename string
---@param t table
function table.load(filename, t) end

---@class io
io = {}
--- Checks if a file exists.
---@param filename string
---@return boolean
function io.exists(filename) end

--- Displays a message in the Mudlet console with color.
---@param message string
function cecho(message) end

--- Displays a message in the Mudlet console with decho formatting.
---@param message string
function decho(message) end

--- Displays a message in the Mudlet console with hecho formatting.
---@param message string
function hecho(message) end

--- Sends a command to the game.
---@param command string
---@param echo? boolean
function send(command, echo) end

--- Returns the path to the Mudlet home directory.
---@return string
function getMudletHomeDir() end

--- Registers an anonymous event handler.
---@param event string
---@param callback string|function
---@param oneShot? boolean
---@return number
function registerAnonymousEventHandler(event, callback, oneShot) end

--- Creates a temporary timer.
---@param seconds number
---@param code string|function
---@param repeating? boolean
---@return number
function tempTimer(seconds, code, repeating) end

--- Global Sunder table
---@class snd
---@field class string
---@field defenses table
---@field def_options table
---@field toggles table
---@field charstats table
---@field _zdash_load_locked boolean
---@field toggle fun(key: string)
---@field save fun()
---@field set_queue fun(cmd: string)
---@field load_def2 fun(...)
snd = {}

--- Global Geyser table
---@class Geyser
Geyser = {}

---@class Geyser.Window
local Window = {}
function Window:show() end
function Window:hide() end
function Window:move(x, y) end
function Window:resize(w, h) end
function Window:isVisible() end

---@class Geyser.UserWindow : Geyser.Window
---@field hidden boolean
Geyser.UserWindow = {}
---@param options table
---@return Geyser.UserWindow
function Geyser.UserWindow:new(options) end
function Geyser.UserWindow:saveLayout() end
function Geyser.UserWindow:restoreLayout() end

---@class Geyser.Container : Geyser.Window
Geyser.Container = {}
---@param options table
---@param parent? any
---@return Geyser.Container
function Geyser.Container:new(options, parent) end

---@class Geyser.Label : Geyser.Window
Geyser.Label = {}
---@param options table
---@param parent? any
---@return Geyser.Label
function Geyser.Label:new(options, parent) end
---@param message string
function Geyser.Label:echo(message) end
---@param callback string|function
---@param ... any
function Geyser.Label:setClickCallback(callback, ...) end
---@param callback string|function
---@param ... any
function Geyser.Label:setOnEnter(callback, ...) end
---@param callback string|function
---@param ... any
function Geyser.Label:setOnLeave(callback, ...) end
---@param stylesheet string
function Geyser.Label:setStyleSheet(stylesheet) end
---@param tooltip string
function Geyser.Label:setToolTip(tooltip) end

---@class Geyser.MiniConsole : Geyser.Window
Geyser.MiniConsole = {}
---@param options table
---@param parent? any
---@return Geyser.MiniConsole
function Geyser.MiniConsole:new(options, parent) end
---@param message string
function Geyser.MiniConsole:cecho(message) end
function Geyser.MiniConsole:clear() end
---@param font string
function Geyser.MiniConsole:setFont(font) end

--- Global ZevDash table
---@class ZevDash
---@field profiles table
---@field save_file string
---@field SunderReady boolean
---@field is_built boolean
---@field visible boolean
---@field active_page string
---@field Styles table
---@field ClassModules table
---@field class_toggles table
---@field core_labels table
---@field def_labels table
---@field class_labels table
---@field tracked_entities table
ZevDash = {}

--- Global ZevWayfarer table
---@class ZevWayfarer
---@field mode string
---@field axes_held number
---@field axes_air number
---@field axes_embedded number
---@field axes_secured number
---@field survive_ready boolean
---@field hunting boolean
---@field tracking boolean
---@field tracking_target string
---@field track fun(target_name?: string)
---@field chase fun()
---@field manage_combat_defenses fun()
---@field refresh_ui fun()
---@field reset_embedded fun()
---@field Defaults table
---@field Axes table
---@field persistent_chant string
ZevWayfarer = {}

--- Global snd extension
---@class snd
---@field wayfarer_bash fun()
---@field functional fun(): boolean
---@field not_entangled fun(): boolean
---@field have_aff fun(aff: string): boolean
---@field checkAff fun(aff: string): boolean
---@field registerEvent fun(name: string, event: string, callback: string|function)
---@field send fun(cmd: string, echo?: boolean)
---@field message fun(msg: string, type?: string)
---@field delay fun(): number
---@field send_attack fun(cmd: string)
---@field targeting table
---@field players_here table
---@field waiting table
---@field stance table
---@field balance table
---@field used table
---@field sep string
---@field limb_dmg table
---@field target string
---@field bash_shielded boolean
---@field bashing table
---@field def_priority table
---@field def_priorities table

--- Mudlet Stopwatch
---@return number
function createStopWatch() end

--- Get current Mudlet font
---@param windowName? string
---@return string
function getFont(windowName) end

--- Get current Mudlet font size
---@param windowName? string
---@return number
function getFontSize(windowName) end

--- Set current Mudlet font and size
---@param windowName string
---@param fontName string
---@param fontSize number
function setFont(windowName, fontName, fontSize) end
