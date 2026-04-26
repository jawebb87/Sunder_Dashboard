-- ZevDash_wayfarer.lua
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.ClassModules = ZevDash.ClassModules or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.toggleChant = function(chantName)
    local cmd = "FURY BATTLECHANT CEASE"
    if snd and snd.set_queue then
        snd.set_queue(cmd)
    else
        send(cmd)
    end
    
    local chants = {"chant_anthem", "chant_bolster", "chant_rally", "chant_phalanx"}
    for _, c in ipairs(chants) do
        ZevDash.class_toggles[c] = false
        if snd and snd.toggles then
            snd.toggles[c] = false
        end
    end
    
    local toggle_key = "chant_" .. chantName
    ZevDash.class_toggles[toggle_key] = true
    if snd and snd.toggles then
        snd.toggles[toggle_key] = true
    end
    
    local chantCmd = "FURY BATTLECHANT " .. chantName:upper()
    if snd and snd.set_queue then
        snd.set_queue(chantCmd)
    else
        send(chantCmd)
    end
    
    if ZevDash.displayPage then
        ZevDash.displayPage("class")
    end
end

ZevDash.ClassModules["wayfarer"] = {
    actionHeader = "BATTLECHANTS",
    actions = {
        { id = "chant_anthem", name = "Anthem", cmd = "anthem" },
        { id = "chant_bolster", name = "Bolster", cmd = "bolster" },
        { id = "chant_rally", name = "Rally", cmd = "rally" },
        { id = "chant_phalanx", name = "Phalanx", cmd = "phalanx" },
    },
    toggles = {
        { id = "returning", name = "Returning" },
        { id = "axe avert", name = "Avert" },
        { id = "axe repel", name = "Repel" },
        { id = "wayfare fleetfoot", name = "Fleetfoot" },
        { id = "wayfare greenheart", name = "Greenheart" },
    },
    resources = {
        "fury",
    },
    
    renderInfo = function(mc)
        mc:cecho("\n <white><u>WAYFARER DATA</u><reset>\n")
        mc:cecho("<gray> " .. string.rep("-", 55) .. "\n")
        
        -- Resources
        local fury_val = (snd and snd.charstats and snd.charstats.fury) or "0"
        mc:cecho("  <yellow>Fury:<reset> " .. fury_val .. "\n")

        -- Axe Tracking
        if ZevDash.Wayfarer then
            local hand = ZevDash.Wayfarer.axes_held or 0
            local air = ZevDash.Wayfarer.axes_air or 0
            local embedded = ZevDash.Wayfarer.axes_embedded or 0
            local belt = ZevDash.Wayfarer.axes_secured or 0
            
            mc:cecho("\n <white><u>AXE TRACKING</u><reset>\n")
            mc:cecho("<gray> " .. string.rep("-", 55) .. "\n")
            mc:cecho("  <yellow>Axes in Hand:<reset> " .. hand .. "\n")
            mc:cecho("  <yellow>Axes in Air:<reset> " .. air .. "\n")
            mc:cecho("  <yellow>Axes Embedded:<reset> " .. embedded .. "\n")
            mc:cecho("  <yellow>Axes on Belt:<reset> " .. belt .. "\n")
        end
    end,
    
    doAction = function(action_cmd)
        -- In our case, action_cmd is the chant name (anthem, bolster, etc)
        ZevDash.toggleChant(action_cmd)
    end,
    
    toggle = function(toggle_key)
        -- Fallback to ZevDash dictionary for unmapped toggles
        ZevDash.class_toggles[toggle_key] = not ZevDash.class_toggles[toggle_key]
        
        local state = ZevDash.class_toggles[toggle_key] and "ON" or "OFF"
        
        if snd and snd.toggles and snd.toggles[toggle_key] ~= nil then
            snd.toggles[toggle_key] = not snd.toggles[toggle_key]
            if snd.save then snd.save() end
        else
            -- Direct command intercept for toggles not in Sunder natively
            local cmd = toggle_key:upper() .. " " .. state
            if snd and snd.set_queue then
                snd.set_queue(cmd)
            else
                send(cmd)
            end
        end
        ZevDash.displayPage("class")
    end,
    
    isToggleOn = function(key)
        if snd and snd.toggles and snd.toggles[key] ~= nil then
            return snd.toggles[key]
        end
        return ZevDash.class_toggles[key] or false
    end,

    isActionOn = function(id)
        -- For Wayfarer, actions are chants
        if snd and snd.toggles and snd.toggles[id] ~= nil then
            return snd.toggles[id]
        end
        return ZevDash.class_toggles[id] or false
    end
}
