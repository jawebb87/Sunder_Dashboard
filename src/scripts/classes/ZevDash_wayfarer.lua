-- ZevDash_wayfarer.lua
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.toggleChant = function(chantName)
    local toggle_key = "chant_" .. chantName
    local wasOn = ZevDash.class_toggles[toggle_key] or false

    ZevDash._chant_gen = (ZevDash._chant_gen or 0) + 1
    local gen = ZevDash._chant_gen

    if wasOn then
        local cmd = "FURY BATTLECHANT CEASE"
        if snd and snd.set_queue then snd.set_queue(cmd) else send(cmd) end

        tempTimer(getNetworkLatency() + 0.1, [[
      if ZevDash._chant_gen == ]] .. gen .. [[ then
        ZevDash.class_toggles["]] .. toggle_key .. [["] = false
        if ZevDash.displayPage then ZevDash.displayPage("class") end
      end
    ]])
    else
        local cmd = "FURY BATTLECHANT CEASE"
        if snd and snd.set_queue then snd.set_queue(cmd) else send(cmd) end

        tempTimer(getNetworkLatency() + 0.1, [[
      if ZevDash._chant_gen == ]] .. gen .. [[ then
        local chants = {"chant_anthem", "chant_bolster", "chant_rally", "chant_phalanx"}
        for _, c in ipairs(chants) do ZevDash.class_toggles[c] = false end

        ZevDash.class_toggles["]] .. toggle_key .. [["] = true
        local chantCmd = "FURY BATTLECHANT ]] .. chantName:upper() .. [["
        if snd and snd.set_queue then snd.set_queue(chantCmd) else send(chantCmd) end

        if ZevDash.displayPage then ZevDash.displayPage("class") end
      end
    ]])
    end
end

ZevDash.registerClass("wayfarer", {
    layout = {
        classGaugeHeight = 25, -- Tell the math engine to make room for the Fury bar
        classInfoHeight = 20,  -- Tell the math engine to make room for the Axe text
    },

    actionHeader = "BATTLECHANTS",
    actions = {
        { id = "chant_anthem",  name = "Anthem",  cmd = "anthem" },
        { id = "chant_bolster", name = "Bolster", cmd = "bolster" },
        { id = "chant_rally",   name = "Rally",   cmd = "rally" },
        { id = "chant_phalanx", name = "Phalanx", cmd = "phalanx" },
    },

    toggles = {
        { id = "returning",          name = "Returning" },
        { id = "axe avert",          name = "Avert" },
        { id = "axe repel",          name = "Repel" },
        { id = "wayfare fleetfoot",  name = "Fleetfoot" },
        { id = "wayfare greenheart", name = "Greenheart" },
    },

    -- 1. MINICONSOLE: Reserved for event logs / dropped defs
    renderInfo = function(self, mc)
        mc:cecho("\n <dim_gray>Awaiting combat events...<reset>\n")
    end,

    -- 2. LABEL & GAUGE: The single-row horizontal UI
    renderInfoLabel = function(self)
        -- LAZY INIT: Build the Fury Gauge only once
        if not ZevDash.wayfarer_fury_gauge then
            ZevDash.wayfarer_fury_gauge = Geyser.Gauge:new({
                name = "ZevDashWayfarerFuryGauge",
                height = "100%",
            }, ZevDash.class_gauge_hbox)

            ZevDash.wayfarer_fury_gauge:setStyleSheet([[
        QProgressBar { border: 1px solid grey; border-radius: 3px; background-color: #111111; }
        QProgressBar::chunk { background-color: #FF8C00; border-radius: 2px; }
      ]])
            ZevDash.wayfarer_fury_gauge:show()
        end

        -- UPDATE FURY GAUGE
        local fury_val = tonumber(gmcp.Char.Vitals.Fury) or 0
        ZevDash.wayfarer_fury_gauge:setValue(fury_val, 100)
        ZevDash.wayfarer_fury_gauge:echo("<center>Fury: " .. fury_val .. "</center>")

        -- UPDATE HORIZONTAL AXE TRACKER
        if ZevDash.Wayfarer then
            local hand = ZevDash.Wayfarer.axes_held or 0
            local air = ZevDash.Wayfarer.axes_air or 0
            local embedded = ZevDash.Wayfarer.axes_embedded or 0
            local belt = ZevDash.Wayfarer.axes_secured or 0

            local axe_text = string.format(
                "<yellow>AXES >><reset> Hand: %d | Air: %d | Embed: %d | Belt: %d",
                hand, air, embedded, belt
            )
            ZevDash.class_info_label:setFontSize(12)
            ZevDash.class_info_label:echo("<center>" .. axe_text .. "</center>")
        else
            ZevDash.class_info_label:echo("")
        end
    end,

    -- Overridden Chant Logic
    doAction = function(self, action_cmd)
        ZevDash.toggleChant(action_cmd)
    end,

    isActionOn = function(self, id)
        return ZevDash.class_toggles[id] or false
    end
})
