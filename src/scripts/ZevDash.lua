-- [[ SUNDER DASHBOARD ]] --
-- Created by: Norrix/Zev/Jacob Webb (Discord Handle: zev7984) & Antigravity
-- Version: 1.0.4

if not snd then return end

ZevDash = ZevDash or {}
ZevDash.SunderReady = ZevDash.SunderReady or false

-- Routing tables for modules
ZevDash.ClassModules = ZevDash.ClassModules or {}

ZevDash.Styles = ZevDash.Styles or {}

-- ZevDash Profiles & Persistence (Community Edition)
ZevDash.profiles = ZevDash.profiles or {}
ZevDash.save_file = getMudletHomeDir() .. "/ZevDash_Profiles_Community.lua"

-- ========================================================
-- GMCP & Class Detection
-- ========================================================

function ZevDash.getCurrentClass()
    if not gmcp or not gmcp.Char or not gmcp.Char.Status then
        return "unknown"
    end
    if snd and snd.class and snd.class ~= "None" then
        return snd.class:lower()
    elseif gmcp.Char.Status.class then
        return gmcp.Char.Status.class:lower()
    end
    return "unknown"
end

-- ========================================================
-- PERSISTENCE ENGINE (Wipe-then-Apply)
-- ========================================================

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
        -- Step 0: If this is the first time loading this class, import Sunder's defaults
        if not ZevDash.profiles[currentClass] then
            ZevDash.profiles[currentClass] = {}
            for def_name, def_data in pairs(snd.defenses) do
                if def_data.needit then
                    ZevDash.profiles[currentClass][def_name] = true
                end
            end
            ZevDash.saveState()
        end

        -- Step 1: Wipe all
        for def_name, _ in pairs(snd.defenses) do
            snd.defenses[def_name].needit = false
        end
        -- Step 2: Apply saved profile
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

    -- First time seeing this class? Import Sunder's defaults
    if not ZevDash.profiles[currentClass] then
        ZevDash.profiles[currentClass] = {}
        for def_name, def_data in pairs(snd.defenses) do
            if def_data.needit then
                ZevDash.profiles[currentClass][def_name] = true
            end
        end
        ZevDash.saveState()
    end

    local managed = {}
    for k in pairs(snd.def_options.general_defs or {}) do
        if snd.defenses[k] then managed[k] = true end
    end
    for k in pairs(snd.def_options[currentClass] or {}) do
        if snd.defenses[k] then managed[k] = true end
    end

    local profile = ZevDash.profiles[currentClass]
    for def_name in pairs(managed) do
        if not profile[def_name] then
            snd.defenses[def_name].needit = false
        end
    end
end

-- ========================================================
-- 1. THE BUILD ENGINE (Geyser.UserWindow)
-- ========================================================

function ZevDash.build()
    ZevDash.window = Geyser.UserWindow:new({
        name = "ZevDash",
        titleText = "Sunder Dashboard",
        width = ZevDash.Layout.windowWidth,
        height = ZevDash.Layout.windowHeight,
    })

    -- Plain Container for tab bar
    ZevDash.tabbar = Geyser.Container:new({
        name = "ZevDashTabBar",
        x = 0,
        y = 0,
        width = "100%",
        height = ZevDash.Layout.tabHeight .. "px",
    }, ZevDash.window)

    -- Fixed Columns for Tab Bar (33% width each)
    ZevDash.col_core_tab = Geyser.Container:new({
        name = "ZevDashCol_CoreTab",
        x = "0%",
        y = "0%",
        width = "33%",
        height = "100%",
    }, ZevDash.tabbar)

    ZevDash.col_def_tab = Geyser.Container:new({
        name = "ZevDashCol_DefTab",
        x = "33%",
        y = "0%",
        width = "34%",
        height = "100%",
    }, ZevDash.tabbar)

    ZevDash.col_class_tab = Geyser.Container:new({
        name = "ZevDashCol_ClassTab",
        x = "67%",
        y = "0%",
        width = "33%",
        height = "100%",
    }, ZevDash.tabbar)

    -- Tab Buttons
    ZevDash.btn_core = Geyser.Label:new({
        name = "ZevBtn_Core",
        x = 0,
        y = 0,
        width = "100%",
        height = "100%",
        message = "<center>Core</center>",
        stylesheet = ZevDash.Styles.buttonStyle,
        fgColor = ZevDash.Styles.textColor
    }, ZevDash.col_core_tab)

    ZevDash.btn_def = Geyser.Label:new({
        name = "ZevBtn_Def",
        x = 0,
        y = 0,
        width = "100%",
        height = "100%",
        message = "<center>Defenses</center>",
        stylesheet = ZevDash.Styles.buttonStyle,
        fgColor = ZevDash.Styles.textColor
    }, ZevDash.col_def_tab)

    ZevDash.btn_class_tab = Geyser.Label:new({
        name = "Class_Btn_ClassTab",
        x = 0,
        y = 0,
        width = "100%",
        height = "100%",
        message = "<center>Class</center>",
        stylesheet = ZevDash.Styles.buttonStyle,
        fgColor = ZevDash.Styles.textColor
    }, ZevDash.col_class_tab)

    -- --- CORE PANE ---
    ZevDash.core_pane = Geyser.Container:new({
        name = "ZevDashCorePane",
        x = 0,
        y = ZevDash.Layout.paneStartY .. "px",
        width = "100%",
        height = "-" .. ZevDash.Layout.paneStartY .. "px",
    }, ZevDash.window)
    ZevDash.core_col_a = Geyser.Container:new({
        name = "ZevDashCoreColA",
        x = "0%",
        y = 0,
        width = "33%",
        height = "100%",
    }, ZevDash.core_pane)
    ZevDash.core_col_b = Geyser.Container:new({
        name = "ZevDashCoreColB",
        x = "33%",
        y = 0,
        width = "34%",
        height = "100%",
    }, ZevDash.core_pane)
    ZevDash.core_col_c = Geyser.Container:new({
        name = "ZevDashCoreColC",
        x = "67%",
        y = 0,
        width = "33%",
        height = "100%",
    }, ZevDash.core_pane)

    ZevDash.def_pane = Geyser.Container:new({
        name = "ZevDashDefPane",
        x = 0,
        y = ZevDash.Layout.paneStartY .. "px",
        width = "100%",
        height = "-" .. ZevDash.Layout.paneStartY .. "px",
    }, ZevDash.window)
    ZevDash.def_col_a = Geyser.Container:new({
        name = "ZevDashDefColA",
        x = "0%",
        y = 0,
        width = "50%",
        height = "100%",
    }, ZevDash.def_pane)
    ZevDash.def_col_b = Geyser.Container:new({
        name = "ZevDashDefColB",
        x = "50%",
        y = 0,
        width = "50%",
        height = "100%",
    }, ZevDash.def_pane)

    -- --- CLASS PANE (Split Top/Bot) ---
    ZevDash.class_pane = Geyser.Container:new({
        name = "ZevDashClassPane",
        x = 0,
        y = ZevDash.Layout.paneStartY .. "px",
        width = "100%",
        height = "-" .. ZevDash.Layout.paneStartY .. "px",
    }, ZevDash.window)

    ZevDash.class_console = Geyser.MiniConsole:new({
        name = "ZevDashClassConsole",
        x = 0,
        y = 0,
        width = "100%",
        height = ZevDash.Layout.classConsoleHeight,
        color = "black",
        fontSize = ZevDash.Styles.fontSize,
    }, ZevDash.class_pane)

    if ZevDash.Styles.fontFamily then
        ZevDash.class_console:setFont(ZevDash.Styles.fontFamily)
    end

    ZevDash.class_bot_pane = Geyser.Container:new({
        name = "ZevDashClassBotPane",
        x = 0,
        y = ZevDash.Layout.classConsoleHeight,
        width = "100%",
        height = ZevDash.Layout.classBotPaneHeight,
    }, ZevDash.class_pane)

    ZevDash.class_col_a = Geyser.Container:new({
        name = "ZevDashClassColA", x = "0%", y = 0, width = "50%", height = "100%",
    }, ZevDash.class_bot_pane)
    ZevDash.class_col_b = Geyser.Container:new({
        name = "ZevDashClassColB", x = "50%", y = 0, width = "50%", height = "100%",
    }, ZevDash.class_bot_pane)

    -- Headers for Class Pane
    ZevDash.lbl_class_actions = Geyser.Label:new({
        name = "ZevDashLblClassActions",
        x = ZevDash.Layout.headerX,
        y = ZevDash.Layout.headerY .. "px",
        width = ZevDash.Layout.headerWidth,
        height = ZevDash.Layout.headerHeight .. "px",
        message = "<center><b><font color='white'>ACTIONS</font></b></center>",
        color = "black",
    }, ZevDash.class_col_a)
    ZevDash.lbl_class_toggles = Geyser.Label:new({
        name = "ZevDashLblClassToggles",
        x = ZevDash.Layout.headerX,
        y = ZevDash.Layout.headerY .. "px",
        width = ZevDash.Layout.headerWidth,
        height = ZevDash.Layout.headerHeight .. "px",
        message = "<center><b><font color='white'>TOGGLES</font></b></center>",
        color = "black",
    }, ZevDash.class_col_b)

    ZevDash.btn_core:setClickCallback("ZevDash.displayPage", "core")
    ZevDash.btn_def:setClickCallback("ZevDash.displayPage", "defs")
    ZevDash.btn_class_tab:setClickCallback("ZevDash.displayPage", "class")

    ZevDash.is_built = true
    ZevDash.visible = true

    if snd.load_def2 and not snd._zdash_load_locked then
        local _orig_load_def2 = snd.load_def2
        snd.load_def2 = function(...)
            _orig_load_def2(...)
            if ZevDash and ZevDash.applyDefLocks then
                ZevDash.applyDefLocks()
            end
            send("\n")
        end
        snd._zdash_load_locked = true
    end

    if ZevDash.window and ZevDash.window.restoreLayout then
        ZevDash.window:restoreLayout()
    end

    ZevDash.loadState()
    ZevDash.displayPage("core")
end

function ZevDash.saveWindowLayout()
    if ZevDash.window and ZevDash.window.saveLayout then
        ZevDash.window:saveLayout()
    end
end

if not ZevDash.sysSaveEventHandler then
    ZevDash.sysSaveEventHandler = registerAnonymousEventHandler("sysSaveEvent", "ZevDash.saveWindowLayout")
end

-- ========================================================
-- 2. INTERACTIVE LOGIC
-- ========================================================

function ZevDash.toggleDef(def_name)
    if not snd or not snd.defenses or not snd.defenses[def_name] then return end
    snd.defenses[def_name].needit = not snd.defenses[def_name].needit
    ZevDash.saveState()
    ZevDash.displayPage(ZevDash.active_page)
end

function ZevDash.toggleCore(toggle_key)
    if not snd then return end

    if toggle_key == "active" then
        if snd.toggles then
            snd.toggles.active = not snd.toggles.active
            local stateStr = snd.toggles.active and "<green>ACTIVE!" or "<red>INACTIVE!"
            cecho("\n<white>Sunder is " .. stateStr .. "<reset>\n")
        end
    else
        if snd.toggle then
            snd.toggle(toggle_key)
        end
    end
    ZevDash.displayPage("core")
end

-- Router for Class Actions
function ZevDash.doClassAction(action_cmd)
    local currentClass = ZevDash.getCurrentClass()
    local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
    if module and module.doAction then
        module.doAction(action_cmd)
    end
end

-- Router for Class Toggles
function ZevDash.toggleClass(toggle_key)
    local currentClass = ZevDash.getCurrentClass()
    local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
    if module and module.toggle then
        module.toggle(toggle_key)
    end
end

-- ========================================================
-- 3. DATA POPULATION & DYNAMIC LABELS
-- ========================================================

function ZevDash.btnHoverEnter(pane, key)
    local lbl, val
    if pane == "core" then
        lbl = ZevDash.core_labels and ZevDash.core_labels[key]
        val = snd.toggles and snd.toggles[key]
    elseif pane == "defs" then
        lbl = ZevDash.def_labels and ZevDash.def_labels[key]
        val = snd.defenses and snd.defenses[key] and snd.defenses[key].needit
    elseif pane == "class_action" then
        lbl = ZevDash.class_labels and ZevDash.class_labels[key]
        local actId = key:gsub("^act_", "")
        local currentClass = ZevDash.getCurrentClass()
        local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
        val = module and module.isActionOn and module.isActionOn(actId) or false
    elseif pane == "class_toggle" then
        lbl = ZevDash.class_labels and ZevDash.class_labels[key]
        val = ZevDash.class_toggles[key]
    end
    if lbl then
        lbl:setStyleSheet(val and ZevDash.Styles.style_on_hover or ZevDash.Styles.style_off_hover)
    end
end

function ZevDash.btnHoverLeave(pane, key)
    local lbl, val
    if pane == "core" then
        lbl = ZevDash.core_labels and ZevDash.core_labels[key]
        val = snd.toggles and snd.toggles[key]
    elseif pane == "defs" then
        lbl = ZevDash.def_labels and ZevDash.def_labels[key]
        val = snd.defenses and snd.defenses[key] and snd.defenses[key].needit
    elseif pane == "class_action" then
        lbl = ZevDash.class_labels and ZevDash.class_labels[key]
        local actId = key:gsub("^act_", "")
        local currentClass = ZevDash.getCurrentClass()
        local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
        val = module and module.isActionOn and module.isActionOn(actId) or false
    elseif pane == "class_toggle" then
        lbl = ZevDash.class_labels and ZevDash.class_labels[key]
        val = ZevDash.class_toggles[key]
    end
    if lbl then
        lbl:setStyleSheet(val and ZevDash.Styles.style_on_idle or ZevDash.Styles.style_off_idle)
    end
end

ZevDash.CoreTooltips = {
    goggles = "Telling Sunder you have antiquated goggles.",
    lighting = "Toggle lighting pipes.",
    affcalling = "Call affs over web.",
    balecho = "Replaces bal/eq with colorful echoes.",
    chameleon = "Use chameleon tattoo/racial.",
    dome = "Do you want Sunder to auto dome for you?",
    listening = "Accept targets over web.",
    enrich = "Do you want to enrich while you bash?",
    parrying = "Basic parry set-up.",
    defenses = "Maintain defenses automatically.",
    dash = "Use of dash while pathing around.",
    newbie = "Newbie bashing attacks only.",
    gathering = "Pick up items while bashing.",
    active = "System full stop of on/off.",
    plants = "Shows plants in the room as you walk.",
    rockharvest = "Harvest rocks as you walk around.",
    nontargetgags = "Remove nontarget cures from output.",
    prism = "Do you want to prism/triplicate bash?",
    auto_reject = "Should we auto reject lust attempts?",
    fasthunt = "Toggle on to clear rooms as you walk around.",
    attacking = "Turns on/off based on aliases for PvP.",
    disperse = "Use disperse to remove writhes from allies.",
    bashing = "Kill NPCs in your room.",
    gallop = "Use gallop while pathing around.",
    lightning = "Toggle luminary lightning to bash.",
    webannounce = "Announce stuff over web",
    atkecho = "Replaces attack lines with shorthand.",
    calling = "Call targets over web.",
    lifesense = "Toggle on lifesense defence.",
    generics = "Uses name instead of number while bashing.",
    vermin = "Vermin walking/killing/turnin."
}

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

    -- Update Headers
    local actionHeader = module.actionHeader or "ACTIONS"
    local toggleHeader = module.toggleHeader or "TOGGLES"
    ZevDash.lbl_class_actions:echo("<center><b><font color='white'>" .. actionHeader .. "</font></b></center>")
    ZevDash.lbl_class_toggles:echo("<center><b><font color='white'>" .. toggleHeader .. "</font></b></center>")

    -- Render Actions (Column A)
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

    -- Render Toggles (Column B)
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
        ZevDash.class_console:cecho("\n  <red>Waiting for Sunder Framework...<reset>\n")
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
        local mc = ZevDash.class_console
        mc:clear()

        local currentClass = ZevDash.getCurrentClass()
        local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]

        if ZevDash.renderResources then
            ZevDash.renderResources(mc)
        end

        if module and module.renderInfo then
            module.renderInfo(mc)
        else
            mc:cecho("\n <white><u>" .. currentClass:upper() .. " DATA</u><reset>\n")
            mc:cecho("<gray> " .. string.rep("-", 55) .. "\n")
            mc:cecho("\n  <red>NO MODULE FOUND FOR CLASS.<reset>\n")
        end

        -- Render Bottom Pane Labels
        ZevDash.renderClassButtons()
    end

    -- ---- TAB HIGHLIGHTING ----
    local currentClass = ZevDash.getCurrentClass():upper()
    ZevDash.btn_core:echo("<center><font color='" .. (page == "core" and "white" or ZevDash.Styles.textColor) .. "'>"
        .. (page == "core" and "<b>CORE</b>" or "Core") .. "</font></center>")
    ZevDash.btn_def:echo("<center><font color='" .. (page == "defs" and "white" or ZevDash.Styles.textColor) .. "'>"
        .. (page == "defs" and "<b>DEFENSES</b>" or "Defenses") .. "</font></center>")
    ZevDash.btn_class_tab:echo("<center><font color='" ..
        (page == "class" and "white" or ZevDash.Styles.textColor) .. "'>"
        .. (page == "class" and "<b>" .. currentClass .. "</b>" or currentClass) .. "</font></center>")
end

-- ========================================================
-- 4. THE SMART SUMMONER
-- ========================================================

function ZevDash.show()
    if not ZevDash.SunderReady then
        cecho("\n<red>ZevDash: Sunder is not ready yet. Sending 'def' to probe...<reset>\n")
        send("def", false)
        return
    end

    if not snd or not snd.defenses then
        cecho("\n<red>ZevDash: Sunder defenses table is empty. Please wait...<reset>\n")
        return
    end

    if ZevDash.getCurrentClass() == "unknown" then
        cecho("\n<red>ZevDash: Class data missing. Sending 'def' to sync...<reset>\n")
        send("def", false)
        return
    end

    if not ZevDash.is_built then
        ZevDash.build()
    else
        ZevDash.window:show()
        ZevDash.visible = true
        ZevDash.loadState()
        ZevDash.displayPage(ZevDash.active_page or "core")
    end
end

function ZevDash.hide()
    if ZevDash.window then
        ZevDash.window:hide()
        ZevDash.visible = false
    end
end

-- ========================================================
-- 5. SUNDER HEARTBEAT
-- ========================================================

if not ZevDash.syncHandler then
    ZevDash.syncHandler = registerAnonymousEventHandler("sunder_update_toggles", function()
        if ZevDash.is_built and ZevDash.window and ZevDash.SunderReady then
            if ZevDash.getCurrentClass() ~= "unknown" then
                ZevDash.displayPage(ZevDash.active_page)
            end
        end
    end)
end

if not ZevDash.initHandler then
    ZevDash.initHandler = registerAnonymousEventHandler("sunder_login", function()
        ZevDash.SunderReady = true
        ZevDash.loadState()
    end)
end

-- ========================================================
-- 6. SUMMON TRACKING
-- ========================================================

ZevDash.tracked_entities = ZevDash.tracked_entities or {}
ZevDash.summon_keywords = {
    "direwolf", "orel", "alpha", "orgyuk", "spider",                                                            -- Predator
    "wisp", "weasel", "rook", "coyote", "raccoon", "gyrfalcon", "raloth", "crocodile", "icewyrm", "cockatrice", -- Sentinel
    "lurker", "wardpeeler", "lightdrinker", "murder", "pilferer", "darkhound", "monstrosity", "throatripper",
    "brutaliser", "eviscerator", "rimestalker",
    "terrifier"                                                                                                 -- Executor
}

function ZevDash.handleRoomItems(event, arg)
    if event == "gmcp.Room.Items.List" then
        ZevDash.tracked_entities = {}
        if gmcp.Room and gmcp.Room.Items and gmcp.Room.Items.List and gmcp.Room.Items.List.items then
            for _, item in ipairs(gmcp.Room.Items.List.items) do
                if item.attrib == "m" or item.attrib == "mx" then
                    local name = item.name:lower()
                    for _, summon in ipairs(ZevDash.summon_keywords) do
                        if name:find(summon) and not name:find("corpse") then
                            ZevDash.tracked_entities[summon] = true
                        end
                    end
                end
            end
        end
    elseif event == "gmcp.Room.Items.Add" then
        if gmcp.Room and gmcp.Room.Items and gmcp.Room.Items.Add and gmcp.Room.Items.Add.item then
            local item = gmcp.Room.Items.Add.item
            if item.attrib == "m" or item.attrib == "mx" then
                local name = item.name:lower()
                for _, summon in ipairs(ZevDash.summon_keywords) do
                    if name:find(summon) and not name:find("corpse") then
                        ZevDash.tracked_entities[summon] = true
                    end
                end
            end
        end
    elseif event == "gmcp.Room.Items.Remove" then
        if gmcp.Room and gmcp.Room.Items and gmcp.Room.Items.Remove and gmcp.Room.Items.Remove.item then
            local item = gmcp.Room.Items.Remove.item
            local name = item.name:lower()
            for _, summon in ipairs(ZevDash.summon_keywords) do
                if name:find(summon) and ZevDash.tracked_entities[summon] then
                    ZevDash.tracked_entities[summon] = false
                end
            end
        end
    end

    if ZevDash.visible and ZevDash.active_page == "class" then
        ZevDash.displayPage("class")
    end
end

if not ZevDash.roomItemsHandler1 then
    ZevDash.roomItemsHandler1 = registerAnonymousEventHandler("gmcp.Room.Items.List", "ZevDash.handleRoomItems")
    ZevDash.roomItemsHandler2 = registerAnonymousEventHandler("gmcp.Room.Items.Add", "ZevDash.handleRoomItems")
    ZevDash.roomItemsHandler3 = registerAnonymousEventHandler("gmcp.Room.Items.Remove", "ZevDash.handleRoomItems")
end

-- Force immediate load state on compile just in case sunder_login already fired
if snd and snd.defenses then
    ZevDash.loadState()
end
