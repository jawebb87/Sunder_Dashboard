-- ZevDash_zealot.lua
SunderSDK.initialize()
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.ClassModules = ZevDash.ClassModules or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.ClassModules["zealot"] = {
    actions = {
    },
    toggles = {
    },
    
    renderInfo = function(mc)
        mc:cecho("\n <white><u>ZEALOT DATA</u><reset>\n")
        mc:cecho("<gray> " .. string.rep("-", 55) .. "\n")
        
        -- Action Tracking

        
        -- Action Tracking

    end,
    
    doAction = function(action_cmd)
        if snd and SunderSDK.api.queueCommand then
            SunderSDK.api.queueCommand(action_cmd)
        else
            send(action_cmd)
        end
    end,
    
    toggle = function(toggle_key)
        -- Fallback to ZevDash dictionary for unmapped toggles
        ZevDash.class_toggles[toggle_key] = not ZevDash.class_toggles[toggle_key]
        
        local state = ZevDash.class_toggles[toggle_key] and "ON" or "OFF"
        
        if snd and snd.toggles and SunderSDK.state.getToggleState(toggle_key) ~= nil then
            SunderSDK.state.getToggleState(toggle_key) = not SunderSDK.state.getToggleState(toggle_key)
            if SunderSDK.state.saveState then SunderSDK.state.saveState() end
        else
            -- Direct command intercept for toggles not in Sunder natively
            local cmd = toggle_key:upper() .. " " .. state
            if snd and SunderSDK.api.queueCommand then
                SunderSDK.api.queueCommand(cmd)
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
