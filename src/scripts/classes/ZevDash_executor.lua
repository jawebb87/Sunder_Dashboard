-- ZevDash_executor.lua
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.ClassModules = ZevDash.ClassModules or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.ClassModules["executor"] = {
    actions = {
        { id = "call accomplices", name = "Accomplices", cmd = "Call Accomplices" },
        { id = "fabricate lurker", name = "Lurker", cmd = "FABRICATE LURKER" },
        { id = "fabricate wardpeeler", name = "Wardpeeler", cmd = "FABRICATE WARDPEELER" },
        { id = "fabricate lightdrinker", name = "Lightdrinker", cmd = "FABRICATE LIGHTDRINKER" },
        { id = "fabricate murder", name = "Murder", cmd = "FABRICATE MURDER" },
        { id = "fabricate pilferer", name = "Pilferer", cmd = "FABRICATE PILFERER" },
        { id = "fabricate darkhound", name = "Darkhound", cmd = "FABRICATE DARKHOUND" },
        { id = "fabricate monstrosity", name = "Monstrosity", cmd = "FABRICATE MONSTROSITY" },
        { id = "fabricate throatripper", name = "Throatripper", cmd = "FABRICATE THROATRIPPER" },
        { id = "fabricate brutaliser", name = "Brutaliser", cmd = "FABRICATE BRUTALISER" },
        { id = "fabricate eviscerator", name = "Eviscerator", cmd = "FABRICATE EVISCERATOR" },
        { id = "fabricate rimestalker", name = "Rimestalker", cmd = "FABRICATE RIMESTALKER" },
        { id = "fabricate terrifier", name = "Terrifier", cmd = "FABRICATE TERRIFIER" },
    },
    toggles = {
        { id = "repose", name = "Repose" },
        { id = "lithe", name = "Lithe" },
        { id = "coagulation", name = "Coagulation" },
    },
    
    renderInfo = function(mc)
        mc:cecho("\n <white><u>EXECUTOR DATA</u><reset>\n")
        mc:cecho("<gray> " .. string.rep("-", 55) .. "\n")
        
        -- Action Tracking

        
        -- Action Tracking
        mc:cecho("\n  <yellow>Summons / Companions:<reset>\n")
        local status_Accomplices = ZevDash.tracked_entities and ZevDash.tracked_entities["accomplices"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Accomplices: " .. status_Accomplices .. "<reset>\n")
        local status_Lurker = ZevDash.tracked_entities and ZevDash.tracked_entities["lurker"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Lurker: " .. status_Lurker .. "<reset>\n")
        local status_Wardpeeler = ZevDash.tracked_entities and ZevDash.tracked_entities["wardpeeler"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Wardpeeler: " .. status_Wardpeeler .. "<reset>\n")
        local status_Lightdrinker = ZevDash.tracked_entities and ZevDash.tracked_entities["lightdrinker"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Lightdrinker: " .. status_Lightdrinker .. "<reset>\n")
        local status_Murder = ZevDash.tracked_entities and ZevDash.tracked_entities["murder"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Murder: " .. status_Murder .. "<reset>\n")
        local status_Pilferer = ZevDash.tracked_entities and ZevDash.tracked_entities["pilferer"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Pilferer: " .. status_Pilferer .. "<reset>\n")
        local status_Darkhound = ZevDash.tracked_entities and ZevDash.tracked_entities["darkhound"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Darkhound: " .. status_Darkhound .. "<reset>\n")
        local status_Monstrosity = ZevDash.tracked_entities and ZevDash.tracked_entities["monstrosity"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Monstrosity: " .. status_Monstrosity .. "<reset>\n")
        local status_Throatripper = ZevDash.tracked_entities and ZevDash.tracked_entities["throatripper"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Throatripper: " .. status_Throatripper .. "<reset>\n")
        local status_Brutaliser = ZevDash.tracked_entities and ZevDash.tracked_entities["brutaliser"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Brutaliser: " .. status_Brutaliser .. "<reset>\n")
        local status_Eviscerator = ZevDash.tracked_entities and ZevDash.tracked_entities["eviscerator"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Eviscerator: " .. status_Eviscerator .. "<reset>\n")
        local status_Rimestalker = ZevDash.tracked_entities and ZevDash.tracked_entities["rimestalker"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Rimestalker: " .. status_Rimestalker .. "<reset>\n")
        local status_Terrifier = ZevDash.tracked_entities and ZevDash.tracked_entities["terrifier"] and "<green>Active" or "<red>Inactive"
        mc:cecho("  - Terrifier: " .. status_Terrifier .. "<reset>\n")

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
