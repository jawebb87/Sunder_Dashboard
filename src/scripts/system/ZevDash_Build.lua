-- ZevDash_Build.lua
if not snd then return end
ZevDash = ZevDash or {}

-- NO premature event handlers here! We wait for the user to ask for the UI.

function ZevDash.build()
    ZevDash.window = Geyser.UserWindow:new({
        name = "ZevDash",
        titleText = "Sunder Dashboard",
        width = ZevDash.Layout.windowWidth,
        height = ZevDash.Layout.windowHeight,
    })
    ZevDash.window:disableAutoDock()
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

    -- --- CLASS PANE (Dynamic Layout) ---
    ZevDash.class_pane = Geyser.Container:new({
        name = "ZevDashClassPane",
        x = 0,
        y = ZevDash.Layout.paneStartY .. "px",
        width = "100%",
        height = "-" .. ZevDash.Layout.paneStartY .. "px",
    }, ZevDash.window)

    ZevDash.class_gauge_container = Geyser.Container:new({
        name = "ZevDashClassGaugeContainer",
        x = 0,
        y = 0,
        width = "100%",
        height = ZevDash.Layout.classGaugeHeight .. "px", -- Will be resized dynamically
    }, ZevDash.class_pane)

    ZevDash.class_gauge_hbox = Geyser.HBox:new({
        name = "ZevDashClassGaugeHBox",
        x = 0,
        y = 0,
        width = "100%",
        height = "100%",
    }, ZevDash.class_gauge_container)

    ZevDash.class_info_label = Geyser.Label:new({
        name = "ZevDashClassInfoLabel",
        x = "2%",
        y = ZevDash.Layout.classGaugeHeight .. "px",
        width = "96%",
        height = ZevDash.Layout.classInfoHeight .. "px",
        message = "",
        stylesheet = [[ background-color: transparent; ]],
        fgColor = "white"
    }, ZevDash.class_pane)

    -- Console and BotPane will be moved dynamically in displayPage(),
    -- but we create them here anchored to the class_pane.
    ZevDash.class_console = Geyser.MiniConsole:new({
        name = "ZevDashClassConsole",
        x = 0,
        y = (ZevDash.Layout.classGaugeHeight + ZevDash.Layout.classInfoHeight) .. "px",
        width = "100%",
        height = ZevDash.Layout.classConsoleHeight,
        color = "black",
        fontSize = ZevDash.Styles.fontSize,
    }, ZevDash.class_pane)
    if ZevDash.Styles.fontFamily then ZevDash.class_console:setFont(ZevDash.Styles.fontFamily) end

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

    ZevDash.is_built = true
end

function ZevDash.show()
    -- 1. Safety check: Has Sunder finished loading?
    if not ZevDash.SunderReady then
        cecho("\nZevDash: Sunder is not ready yet. Sending 'def' to probe...\n")
        send("def", false)
        return
    end

    -- 2. Safety check: Does Sunder's defense table actually exist?
    if not snd or not snd.defenses then
        cecho("\nZevDash: Sunder defenses table is empty. Please wait...\n")
        return
    end

    -- 3. Safety check: Do we know what class we are?
    if ZevDash.getCurrentClass() == "unknown" then
        cecho("\nZevDash: Class data missing. Sending 'def' to sync...\n")
        send("def", false)
        return
    end

    -- 4. LAZY LOAD: If this is the first time they hit smenu, build the UI
    if not ZevDash.is_built then
        ZevDash.build()
        -- Tell the Render engine it's safe to draw the first page
        raiseEvent("ZevDash_UiBuilt")
    else
        -- UI already exists, just show it and refresh
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
