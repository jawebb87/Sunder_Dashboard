-- ZevDash_Persistence.lua
if not snd then return end

if not ZevDash_Persistence_Init then
    ZevDash_Persistence_Init = registerAnonymousEventHandler("ZevDash_CoreInitialized", function()
        if not snd then return end
        ZevDash = ZevDash or {}

        function ZevDash.saveState()
            local currentClass = ZevDash.getCurrentClass()
            if currentClass == "unknown" then return end

            ZevDash.profiles[currentClass] = {}
            if snd and snd.defenses then
                for def_name, def_data in pairs(snd.defenses) do
                    if def_data.needit == true then
                        ZevDash.profiles[currentClass][def_name] = true
                    end
                end
            end
            table.save(ZevDash.save_file, ZevDash.profiles)
        end

        function ZevDash.loadState()
            local currentClass = ZevDash.getCurrentClass()
            if currentClass == "unknown" then return end

            if io.exists(ZevDash.save_file) then
                table.load(ZevDash.save_file, ZevDash.profiles)
            end

            if snd and snd.defenses then
                if not ZevDash.profiles[currentClass] then
                    ZevDash.profiles[currentClass] = {}
                    for def_name, def_data in pairs(snd.defenses) do
                        if def_data.needit then ZevDash.profiles[currentClass][def_name] = true end
                    end
                    ZevDash.saveState()
                end

                for def_name, _ in pairs(snd.defenses) do
                    snd.defenses[def_name].needit = false
                end

                for def_name, _ in pairs(ZevDash.profiles[currentClass]) do
                    if snd.defenses[def_name] then
                        snd.defenses[def_name].needit = true
                    end
                end
            end
        end

        function ZevDash.applyDefLocks()
            if not snd or not snd.defenses or not snd.def_options then return end
            local currentClass = ZevDash.getCurrentClass()
            if currentClass == "unknown" then return end

            if not ZevDash.profiles[currentClass] then
                ZevDash.profiles[currentClass] = {}
                for def_name, def_data in pairs(snd.defenses) do
                    if def_data.needit then ZevDash.profiles[currentClass][def_name] = true end
                end
                ZevDash.saveState()
            end

            local managed = {}
            for k in pairs(snd.def_options.general_defs or {}) do if snd.defenses[k] then managed[k] = true end end
            for k in pairs(snd.def_options[currentClass] or {}) do if snd.defenses[k] then managed[k] = true end end

            local profile = ZevDash.profiles[currentClass]
            for def_name in pairs(managed) do
                if not profile[def_name] then
                    snd.defenses[def_name].needit = false
                end
            end
        end
    end)
end
