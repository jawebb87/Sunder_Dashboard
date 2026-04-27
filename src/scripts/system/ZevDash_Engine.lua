-- ZevDash_Engine.lua
if not snd then return end

if not ZevDash_Engine_Init then
    ZevDash_Engine_Init = registerAnonymousEventHandler("ZevDash_CoreInitialized", function()
        if not snd then return end
        ZevDash = ZevDash or {}

        ZevDash.BaseModule = {
            doAction = function(self, action_cmd)
                if snd and snd.set_queue then snd.set_queue(action_cmd) else send(action_cmd) end
            end,
            toggle = function(self, toggle_key)
                ZevDash.class_toggles[toggle_key] = not ZevDash.class_toggles[toggle_key]
                local state = ZevDash.class_toggles[toggle_key] and "ON" or "OFF"
                if snd and snd.toggles and snd.toggles[toggle_key] ~= nil then
                    snd.toggles[toggle_key] = not snd.toggles[toggle_key]
                    if snd.save then snd.save() end
                else
                    local cmd = toggle_key:upper() .. " " .. state
                    if snd and snd.set_queue then snd.set_queue(cmd) else send(cmd) end
                end
                ZevDash.displayPage("class")
            end,
            isToggleOn = function(self, key)
                if snd and snd.toggles and snd.toggles[key] ~= nil then return snd.toggles[key] end
                return ZevDash.class_toggles[key] or false
            end,
            isActionOn = function(self, id)
                return ZevDash.class_toggles[id] or false
            end,
            renderInfo = function(self, mc)
                if ZevDash.renderResources then ZevDash.renderResources(mc) end
            end,
            renderInfoLabel = function(self) end
        }

        function ZevDash.registerClass(className, config)
            local module = config or {}
            setmetatable(module, { __index = ZevDash.BaseModule })
            ZevDash.ClassModules[className] = module
        end

        -- Helper for Summon Tracker classes
        function ZevDash.renderSummonStatus(mc, summonList)
            mc:cecho("\n Summons / Companions:\n")
            for _, summon in ipairs(summonList) do
                local status = ZevDash.tracked_entities and ZevDash.tracked_entities[summon.id] and "Active" or "Inactive"
                mc:cecho(" - " .. summon.name .. ": " .. status .. "\n")
            end
        end

        -- Helper to draw a text-based gauge in a MiniConsole
        function ZevDash.drawTextGauge(current, maximum, label, color)
            if not color then color = "green" end
            local percent = 0
            if maximum and maximum > 0 then percent = math.min(100, math.max(0, (current / maximum) * 100)) end
            local filled = math.floor(percent / 5)
            local empty = 20 - filled
            local bar = string.rep("█", filled) .. string.rep("-", empty)
            return "<" .. color .. ">[" .. bar .. "] " .. label .. ": " .. current
        end
    end)
end
