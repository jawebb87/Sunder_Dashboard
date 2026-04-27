-- ZevDash_Render.lua
if not snd then return end
ZevDash = ZevDash or {}

-- Wait for the UI to be built (which only happens on the first 'smenu' call)
if not ZevDash_Render_Init then
  ZevDash_Render_Init = registerAnonymousEventHandler("ZevDash_UiBuilt", function()
    if not snd then return end
    -- Do the very first render
    ZevDash.loadState()
    ZevDash.displayPage("core")
  end)
end

-- Handle the live heartbeat from Sunder
if not ZevDash.syncHandler then
  ZevDash.syncHandler = registerAnonymousEventHandler("sunder_update_toggles", function()
    -- Only update if the UI is actually open and visible!
    if ZevDash.is_built and ZevDash.visible and ZevDash.SunderReady then
      if ZevDash.getCurrentClass() ~= "unknown" then
        ZevDash.displayPage(ZevDash.active_page)
      end
    end
  end)
end

function ZevDash.renderResources(mc)
    if not snd or not snd.charstats then return end
    local found = false
    for k, v in pairs(snd.charstats) do
        if k ~= "class" and k ~= "bleeding" then
            if not found then
                mc:cecho("\n <white><u>RESOURCES</u><reset>\n")
                mc:cecho("<gray> " .. string.rep("-", 55) .. "\n")
                found = true
            end
            mc:cecho("  <yellow>" .. k:title() .. ":<reset> " .. v .. "\n")
        end
    end
    if found then mc:cecho("\n") end
end

function ZevDash.renderCoreButtons()
    if not snd.toggles then return end

    local ignore_core = {
        chameleonpeople = true,
        healing = true,
        standing = true,
        clotting = true,
        cobra = true,
        questing = true,
        goggle_level = true,
        gauntlet_level = true,
        diagaffs = true,
        laesan = true,
        ascendedtype = true,
        mount = true,
        monomode = true,
        pagelength = true,
        reboundingtime = true,
        purge = true,
        purify = true,
        panacea = true
    }

    -- DYNAMIC HIDE: Ignore actions that belong to the active Class Module
    local currentClass = ZevDash.getCurrentClass()
    local activeModule = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
    if activeModule and activeModule.actions then
        for _, act in ipairs(activeModule.actions) do
            ignore_core[act.id] = true
        end
    end

    local keys = {}
    for k, _ in pairs(snd.toggles) do
        if type(snd.toggles[k]) == "boolean" and not ignore_core[k:lower()] then
            table.insert(keys, k)
        end
    end
    table.sort(keys)

    ZevDash.core_labels = ZevDash.core_labels or {}
    local col_a_count, col_b_count, col_c_count = 0, 0, 0
    local step = ZevDash.Layout.buttonHeight + ZevDash.Layout.buttonGap
    local startY = 10

    for i, key in ipairs(keys) do
        local val = snd.toggles[key]
        local mod = i % 3
        local parent_col, index
        if mod == 1 then
            parent_col = ZevDash.core_col_a
            index = col_a_count
            col_a_count = col_a_count + 1
        elseif mod == 2 then
            parent_col = ZevDash.core_col_b
            index = col_b_count
            col_b_count = col_b_count + 1
        else
            parent_col = ZevDash.core_col_c
            index = col_c_count
            col_c_count = col_c_count + 1
        end
        local yPos = (index * step + startY) .. "px"
        if not ZevDash.core_labels[key] then
            ZevDash.core_labels[key] = Geyser.Label:new({
                name = "ZevDashCoreBtn_" .. key,
                x = ZevDash.Layout.buttonX,
                y = yPos,
                width = ZevDash.Layout.buttonWidth,
                height = ZevDash.Layout.buttonHeight .. "px",
            }, parent_col)
            local lbl = ZevDash.core_labels[key]
            lbl:setClickCallback("ZevDash.toggleCore", key)
            lbl:setOnEnter("ZevDash.btnHoverEnter", "core", key)
            lbl:setOnLeave("ZevDash.btnHoverLeave", "core", key)
            local tooltip = ZevDash.CoreTooltips[key:lower()] or ""
            if tooltip ~= "" then lbl:setToolTip(tooltip) end
        end
        local lbl = ZevDash.core_labels[key]
        local display_name = key:title()
        if key == "active" then display_name = "Sunder" end
        lbl:echo("<center><font color='" .. ZevDash.Styles.textColor .. "'>" .. display_name .. "</font></center>")
        lbl:setStyleSheet(val and ZevDash.Styles.style_on_idle or ZevDash.Styles.style_off_idle)
        lbl:move(ZevDash.Layout.buttonX, yPos)
    end
end

function ZevDash.renderDefButtons()
    if not snd.defenses or not snd.def_options then return end
    local keys = {}
    local shown = {}
    local options = snd.def_options.general_defs or {}
    for k, _ in pairs(options) do
        if snd.defenses[k] and not shown[k] then
            table.insert(keys, k)
            shown[k] = true
        end
    end
    local currentClass = ZevDash.getCurrentClass()
    if currentClass ~= "unknown" and snd.def_options[currentClass] then
        for k, _ in pairs(snd.def_options[currentClass]) do
            if snd.defenses[k] and not shown[k] then
                table.insert(keys, k)
                shown[k] = true
            end
        end
    end
    table.sort(keys)
    ZevDash.def_labels = ZevDash.def_labels or {}
    local col_a_count, col_b_count = 0, 0
    local step = ZevDash.Layout.buttonHeight + ZevDash.Layout.buttonGap
    local startY = 10
    for i, key in ipairs(keys) do
        local val = snd.defenses[key].needit
        local is_col_a = (i % 2 ~= 0)
        local parent_col = is_col_a and ZevDash.def_col_a or ZevDash.def_col_b
        local index = is_col_a and col_a_count or col_b_count
        local yPos = (index * step + startY) .. "px"
        if not ZevDash.def_labels[key] then
            ZevDash.def_labels[key] = Geyser.Label:new({
                name = "ZevDashDefBtn_" .. key,
                x = ZevDash.Layout.buttonX,
                y = yPos,
                width = ZevDash.Layout.buttonWidth,
                height = ZevDash.Layout.buttonHeight .. "px",
            }, parent_col)
            local lbl = ZevDash.def_labels[key]
            lbl:setClickCallback("ZevDash.toggleDef", key)
            lbl:setOnEnter("ZevDash.btnHoverEnter", "defs", key)
            lbl:setOnLeave("ZevDash.btnHoverLeave", "defs", key)
        end
        local lbl = ZevDash.def_labels[key]
        local cleanName = key:gsub("^def_", ""):title()
        lbl:echo("<center><font color='" .. ZevDash.Styles.textColor .. "'>" .. cleanName .. "</font></center>")
        lbl:setStyleSheet(val and ZevDash.Styles.style_on_idle or ZevDash.Styles.style_off_idle)
        lbl:move(ZevDash.Layout.buttonX, yPos)
        if is_col_a then col_a_count = col_a_count + 1 else col_b_count = col_b_count + 1 end
    end
end

function ZevDash.renderClassButtons()
    local currentClass = ZevDash.getCurrentClass()
    local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
    if not module then return end
    local actions = module.actions or {}
    local toggles = module.toggles or {}
    ZevDash.class_labels = ZevDash.class_labels or {}
    local step = ZevDash.Layout.buttonHeight + ZevDash.Layout.buttonGap
    local startY = ZevDash.Layout.classButtonStartY
    local actionHeader = module.actionHeader or "ACTIONS"
    local toggleHeader = module.toggleHeader or "TOGGLES"
    ZevDash.lbl_class_actions:echo("<center><b><font color='white'>" .. actionHeader .. "</font></b></center>")
    ZevDash.lbl_class_toggles:echo("<center><b><font color='white'>" .. toggleHeader .. "</font></b></center>")
    for i, act in ipairs(actions) do
        local key = "act_" .. act.id
        local val = module.isActionOn and module.isActionOn(act.id) or false
        local yPos = ((i - 1) * step + startY) .. "px"
        if not ZevDash.class_labels[key] then
            ZevDash.class_labels[key] = Geyser.Label:new({
                name = "ZevDashClassBtn_" .. key,
                x = ZevDash.Layout.buttonX,
                y = yPos,
                width = ZevDash.Layout.buttonWidth,
                height = ZevDash.Layout.buttonHeight .. "px",
            }, ZevDash.class_col_a)
            local lbl = ZevDash.class_labels[key]
            lbl:setClickCallback("ZevDash.doClassAction", act.cmd)
            lbl:setOnEnter("ZevDash.btnHoverEnter", "class_action", key)
            lbl:setOnLeave("ZevDash.btnHoverLeave", "class_action", key)
        end
        local lbl = ZevDash.class_labels[key]
        lbl:echo("<center><font color='" .. ZevDash.Styles.textColor .. "'>" .. act.name .. "</font></center>")
        lbl:setStyleSheet(val and ZevDash.Styles.style_on_idle or ZevDash.Styles.style_off_idle)
        lbl:move(ZevDash.Layout.buttonX, yPos)
    end
    for i, tog in ipairs(toggles) do
        local key = tog.id
        local val = module.isToggleOn and module.isToggleOn(key) or false
        local yPos = ((i - 1) * step + startY) .. "px"
        if not ZevDash.class_labels[key] then
            ZevDash.class_labels[key] = Geyser.Label:new({
                name = "ZevDashClassBtn_" .. key,
                x = ZevDash.Layout.buttonX,
                y = yPos,
                width = ZevDash.Layout.buttonWidth,
                height = ZevDash.Layout.buttonHeight .. "px",
            }, ZevDash.class_col_b)
            local lbl = ZevDash.class_labels[key]
            lbl:setClickCallback("ZevDash.toggleClass", tog.id)
            lbl:setOnEnter("ZevDash.btnHoverEnter", "class_toggle", key)
            lbl:setOnLeave("ZevDash.btnHoverLeave", "class_toggle", key)
        end
        local lbl = ZevDash.class_labels[key]
        lbl:echo("<center><font color='" .. ZevDash.Styles.textColor .. "'>" .. tog.name .. "</font></center>")
        lbl:setStyleSheet(val and ZevDash.Styles.style_on_idle or ZevDash.Styles.style_off_idle)
        lbl:move(ZevDash.Layout.buttonX, yPos)
    end
end

function ZevDash.displayPage(page)
    if not ZevDash.is_built then return end
    ZevDash.active_page = page
    ZevDash.core_pane:hide()
    ZevDash.def_pane:hide()
    ZevDash.class_pane:hide()

    if not snd then
        ZevDash.class_pane:show()
        ZevDash.class_console:cecho("\n Waiting for Sunder Framework...\n")
        return
    end

    if page == "defs" then
        ZevDash.def_pane:show()
        ZevDash.renderDefButtons()
    elseif page == "core" then
        ZevDash.core_pane:show()
        ZevDash.renderCoreButtons()
    elseif page == "class" then
        ZevDash.class_pane:show()

        local currentClass = ZevDash.getCurrentClass()
        local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
        local gaugeH = (module and module.layout and module.layout.classGaugeHeight) or ZevDash.Layout.classGaugeHeight
        local infoH = (module and module.layout and module.layout.classInfoHeight) or ZevDash.Layout.classInfoHeight

        ZevDash.class_gauge_container:resize("100%", gaugeH .. "px")
        local infoY = gaugeH
        ZevDash.class_info_label:move("2%", infoY .. "px")
        ZevDash.class_info_label:resize("96%", infoH .. "px")
        local consoleY = infoY + infoH
        ZevDash.class_console:move(0, consoleY .. "px")

        if gaugeH > 0 then ZevDash.class_gauge_container:show() else ZevDash.class_gauge_container:hide() end
        if infoH > 0 then ZevDash.class_info_label:show() else ZevDash.class_info_label:hide() end

        local mc = ZevDash.class_console
        mc:clear()
        if module then
            if module.renderInfo then module:renderInfo(mc) end
            if module.renderInfoLabel then module:renderInfoLabel() end
        else
            mc:cecho("\n NO MODULE FOUND FOR CLASS.\n")
        end
        ZevDash.renderClassButtons()
    end

    -- Tab Highlighting
    local currentClass = ZevDash.getCurrentClass():upper()
    ZevDash.btn_core:echo("<center><font color='" ..
    (page == "core" and "white" or ZevDash.Styles.textColor) ..
    "'>" .. (page == "core" and "CORE" or "Core") .. "</font></center>")
    ZevDash.btn_def:echo("<center><font color='" ..
    (page == "defs" and "white" or ZevDash.Styles.textColor) ..
    "'>" .. (page == "defs" and "DEFENSES" or "Defenses") .. "</font></center>")
    ZevDash.btn_class_tab:echo("<center><font color='" ..
    (page == "class" and "white" or ZevDash.Styles.textColor) ..
    "'>" .. (page == "class" and "<b>" .. currentClass .. "</b>" or currentClass) .. "</font></center>")
end
