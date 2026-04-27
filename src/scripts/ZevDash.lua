-- [[ SUNDER DASHBOARD ]] --
-- Created by: Norrix/Zev/Jacob Webb (Discord Handle: zev7984) & Antigravity
-- Version: 1.1.0

-- ZevDash.lua (The Bootloader)
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.SunderReady = ZevDash.SunderReady or false
ZevDash.profiles = ZevDash.profiles or {}
ZevDash.save_file = getMudletHomeDir() .. "/ZevDash_Profiles_Community.lua"

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

-- Broadcast that our core table exists
raiseEvent("ZevDash_CoreInitialized")
