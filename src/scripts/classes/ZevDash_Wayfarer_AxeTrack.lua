-- ZevDash_Wayfarer_AxeTrack.lua
-- Axe Tracking for Wayfarer Class
-- Ported from Wayfarer_Addon

if not snd then return end

ZevDash = ZevDash or {}
ZevDash.Wayfarer = ZevDash.Wayfarer or {}

-- Axe State Variables
ZevDash.Wayfarer.axes_held = ZevDash.Wayfarer.axes_held or 2
ZevDash.Wayfarer.axes_air = ZevDash.Wayfarer.axes_air or 0
ZevDash.Wayfarer.axes_embedded = ZevDash.Wayfarer.axes_embedded or 0
ZevDash.Wayfarer.axes_secured = ZevDash.Wayfarer.axes_secured or 0

-- UI Refresh Helper
function ZevDash.Wayfarer.refreshUI()
    if ZevDash.displayPage and ZevDash.active_page == "class" then
        ZevDash.displayPage("class")
    end
end

-- Axe Tracking Functions (Called by permanent triggers in src/triggers/)
function ZevDash.Wayfarer.axeThrown(count)
    local n = count or 1
    ZevDash.Wayfarer.axes_held = math.max(0, (ZevDash.Wayfarer.axes_held or 0) - n)
    ZevDash.Wayfarer.axes_air = math.min(2, (ZevDash.Wayfarer.axes_air or 0) + n)
    ZevDash.Wayfarer.refreshUI()
end

function ZevDash.Wayfarer.axeCaught()
    ZevDash.Wayfarer.axes_held = (ZevDash.Wayfarer.axes_held or 0) + 1
    ZevDash.Wayfarer.axes_air = math.max(0, (ZevDash.Wayfarer.axes_air or 0) - 1)
    ZevDash.Wayfarer.refreshUI()
end

function ZevDash.Wayfarer.axeEmbedded()
    ZevDash.Wayfarer.axes_embedded = math.min(2, (ZevDash.Wayfarer.axes_embedded or 0) + 1)
    ZevDash.Wayfarer.axes_air = math.max(0, (ZevDash.Wayfarer.axes_air or 0) - 1)
    ZevDash.Wayfarer.refreshUI()
end

function ZevDash.Wayfarer.axePulled()
    ZevDash.Wayfarer.axes_held = (ZevDash.Wayfarer.axes_held or 0) + 1
    ZevDash.Wayfarer.axes_embedded = math.max(0, (ZevDash.Wayfarer.axes_embedded or 0) - 1)
    ZevDash.Wayfarer.refreshUI()
end

function ZevDash.Wayfarer.axeFumbled()
    ZevDash.Wayfarer.axes_held = (ZevDash.Wayfarer.axes_held or 0) + 1
    ZevDash.Wayfarer.axes_air = math.max(0, (ZevDash.Wayfarer.axes_air or 0) - 1)
    ZevDash.Wayfarer.refreshUI()
end

function ZevDash.Wayfarer.axeSecured()
    ZevDash.Wayfarer.axes_held = math.max(0, (ZevDash.Wayfarer.axes_held or 0) - 1)
    ZevDash.Wayfarer.axes_secured = (ZevDash.Wayfarer.axes_secured or 0) + 1
    ZevDash.Wayfarer.refreshUI()
end

function ZevDash.Wayfarer.axeWielded()
    ZevDash.Wayfarer.axes_held = (ZevDash.Wayfarer.axes_held or 0) + 1
    ZevDash.Wayfarer.axes_secured = math.max(0, (ZevDash.Wayfarer.axes_secured or 0) - 1)
    ZevDash.Wayfarer.refreshUI()
end

function ZevDash.Wayfarer.resetEmbedded()
    ZevDash.Wayfarer.axes_embedded = 0
    ZevDash.Wayfarer.refreshUI()
end

-- Sunder Event Hooks for resets
if not ZevDash.Wayfarer.deathHandler1 then
    ZevDash.Wayfarer.deathHandler1 = registerAnonymousEventHandler("SunderTargetDeath", "ZevDash.Wayfarer.resetEmbedded")
    ZevDash.Wayfarer.deathHandler2 = registerAnonymousEventHandler("SunderBashingTargetDeath", "ZevDash.Wayfarer.resetEmbedded")
end
