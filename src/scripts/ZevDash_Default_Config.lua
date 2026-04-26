-- ZevDash_Default_Config.lua
-- Default configuration for Sunder Dashboard

if not snd then return end

local dashFont = getFont and getFont() or "Courier"
local dashFontSize = getFontSize and getFontSize() or 9
local fontStyle = "font-family: '" .. dashFont .. "'; font-size: " .. dashFontSize .. "pt;"

ZevDash = ZevDash or {}
ZevDash.Defaults = {
    textColor = "white",
    
    style_on_idle = [[
        background-color: DarkSlateGray;
        border: 2px solid SlateGray;
        border-radius: 5px;
        qproperty-alignment: 'AlignCenter | AlignVCenter';
    ]] .. fontStyle,
    style_on_hover = [[
        background-color: SlateGray;
        border: 2px solid DarkSlateGray;
        border-radius: 5px;
        qproperty-alignment: 'AlignCenter | AlignVCenter';
    ]] .. fontStyle,
    style_off_idle = [[
        background-color: DarkGray;
        border: 2px solid Grey;
        border-radius: 5px;
        qproperty-alignment: 'AlignCenter | AlignVCenter';
    ]] .. fontStyle,
    style_off_hover = [[
        background-color: Grey;
        border: 2px solid DarkGray;
        border-radius: 5px;
        qproperty-alignment: 'AlignCenter | AlignVCenter';
    ]] .. fontStyle,
    
    -- Legacy support for tab buttons
    buttonStyle = [[
        border-width: 2px;
        border-style: double;
        border-color: DarkSlateBlue;
        background-color: black;
        border-radius: 5px;
    ]] .. fontStyle,

    fontFamily = dashFont,
    fontSize = dashFontSize,

    Layout = {
        -- Window dimensions
        windowWidth = "90c",
        windowHeight = "30c",
        
        -- Tab bar
        tabHeight = 30,
        
        -- Button defaults
        buttonHeight = 35,
        buttonWidth = "90%",
        buttonX = "5%",
        buttonGap = 5,
        
        -- Header defaults (Class Pane)
        headerHeight = 30,
        headerY = 5,
        headerX = "5%",
        headerWidth = "90%",
        
        -- Pane specifics
        paneStartY = 30, -- starts after tab bar
        coreCols = 3,
        defCols = 2,
        classCols = 2,
        
        -- Class Pane specific
        classConsoleHeight = "30%",
        classBotPaneHeight = "70%",
        classButtonStartY = 40, 
    }
}

-- Apply defaults initially
ZevDash = ZevDash or {}
ZevDash.Styles = ZevDash.Styles or {}
ZevDash.Layout = ZevDash.Layout or {}

for k, v in pairs(ZevDash.Defaults.Layout) do
    ZevDash.Layout[k] = ZevDash.Layout[k] or v
end
ZevDash.Styles.textColor = ZevDash.Defaults.textColor
ZevDash.Styles.buttonStyle = ZevDash.Defaults.buttonStyle
ZevDash.Styles.style_on_idle = ZevDash.Defaults.style_on_idle
ZevDash.Styles.style_on_hover = ZevDash.Defaults.style_on_hover
ZevDash.Styles.style_off_idle = ZevDash.Defaults.style_off_idle
ZevDash.Styles.style_off_hover = ZevDash.Defaults.style_off_hover
ZevDash.Styles.fontFamily = ZevDash.Defaults.fontFamily
ZevDash.Styles.fontSize = ZevDash.Defaults.fontSize
