-- ZevDash_predator.lua
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.ClassModules = ZevDash.ClassModules or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.ClassModules["predator"] = {
    actions = {
        { id = "beastcall direwolf", name = "Direwolf", cmd = "BEASTCALL DIREWOLF" },
        { id = "beastcall orel", name = "Orel", cmd = "BEASTCALL OREL" },
        { id = "beastcall alpha", name = "Alpha", cmd = "BEASTCALL ALPHA" },
        { id = "beastcall orgyuk", name = "Orgyuk", cmd = "BEASTCALL ORGYUK" },
        { id = "beastcall spider", name = "Spider", cmd = "BEASTCALL SPIDER" },
    },
    toggles = {
        { id = "regeneration", name = "Regeneration" },
    },
    resources = {
    },
    
    renderInfo = function(mc)
        mc:cecho("\n <white><u>PREDATOR DATA</u><reset>\n")
        mc:cecho("<gray> " .. string.rep("-", 55) .. "\n")
        
        -- Resources
        mc:cecho("  <gray>No special resources to track.<reset>\n")

        
        -- Action Tracking
        mc:cecho("\n  <yellow>Summons / Companions:<reset>\n")
        local status_Direwolf = ZevDash.tracked_entities and ZevDash.tracked_entities["direwolf"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Direwolf: " .. status_Direwolf .. "<reset>\n")
        local status_Orel = ZevDash.tracked_entities and ZevDash.tracked_entities["orel"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Orel: " .. status_Orel .. "<reset>\n")
        local status_Alpha = ZevDash.tracked_entities and ZevDash.tracked_entities["alpha"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Alpha: " .. status_Alpha .. "<reset>\n")
        local status_Orgyuk = ZevDash.tracked_entities and ZevDash.tracked_entities["orgyuk"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Orgyuk: " .. status_Orgyuk .. "<reset>\n")
        local status_Spider = ZevDash.tracked_entities and ZevDash.tracked_entities["spider"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Spider: " .. status_Spider .. "<reset>\n")

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
