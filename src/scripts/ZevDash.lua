-- [[ SUNDER DASHBOARD ]] --
-- Created by: Norrix/Zev/Jacob Webb (Discord Handle: zev7984) & Antigravity
-- Version: 1.2.0

-- ZevDash.lua (The Bootloader)
-- This MUST run at load time even when `snd` doesn't exist yet.
-- It initializes the global table and registers the Sunder handshake listener.
-- Class files need ZevDash.ClassModules and ZevDash.registerClass to exist
-- at load time, so we cannot bail early with `if not snd then return end`.

ZevDash = ZevDash or {}
ZevDash.SunderReady = ZevDash.SunderReady or false
ZevDash.profiles = ZevDash.profiles or {}
ZevDash.save_file = getMudletHomeDir() .. "/ZevDash_Profiles.lua"

-- Migrate old Community save file if new one doesn't exist
local _old_save = getMudletHomeDir() .. "/ZevDash_Profiles_Community.lua"
if io.exists(_old_save) and not io.exists(ZevDash.save_file) then
    os.rename(_old_save, ZevDash.save_file)
end

ZevDash.Layout = ZevDash.Layout or {}
ZevDash.Styles = ZevDash.Styles or {}
ZevDash.ClassModules = ZevDash.ClassModules or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

-- Listen for Sunder's Handshake
if not ZevDash.initHandler then
  ZevDash.initHandler = registerAnonymousEventHandler("sunder_login", function()
    ZevDash.SunderReady = true
    
    -- Sync defense profiles in the background, but DO NOT build the UI!
    if ZevDash.loadState then ZevDash.loadState() end
    if ZevDash.applyDefLocks then ZevDash.applyDefLocks() end
    
  end)
end
