-- ZevDash_bloodborn.lua
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.ClassModules = ZevDash.ClassModules or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.ClassModules["bloodborn"] = {
    actions = {
    },
    toggles = {
        { id = "well forewarn",  name = "Forewarn" },
        { id = "well severance", name = "Severance" },
        { id = "well disparity", name = "Disparity" },
        { id = "well atrophy",   name = "Atrophy" },
        { id = "well thrombose", name = "Thrombose" },
    },
    resources = {
        "humour",
        "phlegm",
        "black",
        "blood",
    },

    renderInfo = function(mc)
        mc:cecho("\n <white><u>BLOODBORN DATA</u><reset>\n")
        mc:cecho("<gray> " .. string.rep("-", 55) .. "\n")

        -- Resources
        local humour_val = (snd and snd.charstats and snd.charstats.humour) or "0"
        mc:cecho("  <yellow>Humour:<reset> " .. humour_val .. "\n")
        local phlegm_val = (snd and snd.charstats and snd.charstats.phlegm) or "0"
        mc:cecho("  <yellow>Phlegm:<reset> " .. phlegm_val .. "\n")
        local black_val = (snd and snd.charstats and snd.charstats.black) or "0"
        mc:cecho("  <yellow>Black:<reset> " .. black_val .. "\n")
        local blood_val = (snd and snd.charstats and snd.charstats.blood) or "0"
        mc:cecho("  <yellow>Blood):<reset> " .. blood_val .. "\n")


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
