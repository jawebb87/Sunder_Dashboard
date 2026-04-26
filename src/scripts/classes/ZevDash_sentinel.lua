-- ZevDash_sentinel.lua
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.ClassModules = ZevDash.ClassModules or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.ClassModules["sentinel"] = {
    actions = {
        { id = "call animals", name = "Animals", cmd = "CALL ANIMALS" },
        { id = "call wisp", name = "Wisp", cmd = "CALL WISP" },
        { id = "call weasel", name = "Weasel", cmd = "CALL WEASEL" },
        { id = "call rook", name = "Rook", cmd = "CALL ROOK" },
        { id = "call coyote", name = "Coyote", cmd = "CALL COYOTE" },
        { id = "call raccoon", name = "Raccoon", cmd = "CALL RACCOON" },
        { id = "call gyrfalcon", name = "Gyrfalcon", cmd = "CALL GYRFALCON" },
        { id = "call raloth", name = "Raloth", cmd = "CALL RALOTH" },
        { id = "call crocodile", name = "Crocodile", cmd = "CALL CROCODILE" },
        { id = "call icewyrm", name = "Icewyrm", cmd = "CALL ICEWYRM" },
        { id = "call cockatrice", name = "Cockatrice", cmd = "CALL COCKATRICE" },
    },
    toggles = {
        { id = "resting", name = "Resting" },
        { id = "balancing", name = "Balancing" },
        { id = "coagulation", name = "Coagulation" },
    },
    
    renderInfo = function(mc)
        mc:cecho("\n <white><u>SENTINEL DATA</u><reset>\n")
        mc:cecho("<gray> " .. string.rep("-", 55) .. "\n")
        
        -- Action Tracking

        
        -- Action Tracking
        mc:cecho("\n  <yellow>Summons / Companions:<reset>\n")
        local status_Animals = ZevDash.tracked_entities and ZevDash.tracked_entities["animals"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Animals: " .. status_Animals .. "<reset>\n")
        local status_Wisp = ZevDash.tracked_entities and ZevDash.tracked_entities["wisp"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Wisp: " .. status_Wisp .. "<reset>\n")
        local status_Weasel = ZevDash.tracked_entities and ZevDash.tracked_entities["weasel"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Weasel: " .. status_Weasel .. "<reset>\n")
        local status_Rook = ZevDash.tracked_entities and ZevDash.tracked_entities["rook"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Rook: " .. status_Rook .. "<reset>\n")
        local status_Coyote = ZevDash.tracked_entities and ZevDash.tracked_entities["coyote"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Coyote: " .. status_Coyote .. "<reset>\n")
        local status_Raccoon = ZevDash.tracked_entities and ZevDash.tracked_entities["raccoon"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Raccoon: " .. status_Raccoon .. "<reset>\n")
        local status_Gyrfalcon = ZevDash.tracked_entities and ZevDash.tracked_entities["gyrfalcon"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Gyrfalcon: " .. status_Gyrfalcon .. "<reset>\n")
        local status_Raloth = ZevDash.tracked_entities and ZevDash.tracked_entities["raloth"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Raloth: " .. status_Raloth .. "<reset>\n")
        local status_Crocodile = ZevDash.tracked_entities and ZevDash.tracked_entities["crocodile"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Crocodile: " .. status_Crocodile .. "<reset>\n")
        local status_Icewyrm = ZevDash.tracked_entities and ZevDash.tracked_entities["icewyrm"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Icewyrm: " .. status_Icewyrm .. "<reset>\n")
        local status_Cockatrice = ZevDash.tracked_entities and ZevDash.tracked_entities["cockatrice"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Cockatrice: " .. status_Cockatrice .. "<reset>\n")

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
