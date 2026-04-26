-- ZevDash_voidseer.lua
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.ClassModules = ZevDash.ClassModules or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.ClassModules["voidseer"] = {
    actions = {
    },
    toggles = {
    },
    resources = {
        "insight",
        "chakras",
        "sap",
        "trunk",
        "heartwood",
        "leaf",
        "branch",
        "canopy)",
    },
    
    renderInfo = function(mc)
        mc:cecho("\n <white><u>VOIDSEER DATA</u><reset>\n")
        mc:cecho("<gray> " .. string.rep("-", 55) .. "\n")
        
        -- Resources
        local insight_val = (snd and snd.charstats and snd.charstats.insight) or "0"
        mc:cecho("  <yellow>Insight:<reset> " .. insight_val .. "\n")
        local chakras_val = (snd and snd.charstats and snd.charstats.chakras) or "0"
        mc:cecho("  <yellow>Chakras:<reset> " .. chakras_val .. "\n")
        local sap_val = (snd and snd.charstats and snd.charstats.sap) or "0"
        mc:cecho("  <yellow>Sap:<reset> " .. sap_val .. "\n")
        local trunk_val = (snd and snd.charstats and snd.charstats.trunk) or "0"
        mc:cecho("  <yellow>Trunk:<reset> " .. trunk_val .. "\n")
        local heartwood_val = (snd and snd.charstats and snd.charstats.heartwood) or "0"
        mc:cecho("  <yellow>Heartwood:<reset> " .. heartwood_val .. "\n")
        local leaf_val = (snd and snd.charstats and snd.charstats.leaf) or "0"
        mc:cecho("  <yellow>Leaf:<reset> " .. leaf_val .. "\n")
        local branch_val = (snd and snd.charstats and snd.charstats.branch) or "0"
        mc:cecho("  <yellow>Branch:<reset> " .. branch_val .. "\n")
        local canopy_val = (snd and snd.charstats and snd.charstats.canopy) or "0"
        mc:cecho("  <yellow>Canopy:<reset> " .. canopy_val .. "\n")

        
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
