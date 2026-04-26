-- ZevDash_zealot.lua
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.ClassModules = ZevDash.ClassModules or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.ClassModules["zealot"] = {
    actions = {
    },
    toggles = {
    },
    resources = {
        "energy",
    },
    
    renderInfo = function(mc)
        mc:cecho("\n <white><u>ZEALOT DATA</u><reset>\n")
        mc:cecho("<gray> " .. string.rep("-", 55) .. "\n")
        
        -- Resources
        local energy_val = (snd and snd.charstats and snd.charstats.energy) or "0"
        mc:cecho("  <yellow>Energy:<reset> " .. energy_val .. "\n")

        
        -- Action Tracking

    end,
    
    doAction = function(action_cmd)
        if snd and snd.set_queue then
            snd.set_queue(action_cmd)
        else
            send(action_cmd)
        end
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
    end
}
