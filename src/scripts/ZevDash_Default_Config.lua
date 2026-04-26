-- ZevDash_Default_Config.lua
-- Default configuration for Wayfarer Dashboard

if not snd then return end

Wayfarer = Wayfarer or {}
Wayfarer.Defaults = {
    textColor = "white",
    
    style_on_idle = [[
        background-color: DarkSlateGray;
        border: 2px solid SlateGray;
        border-radius: 5px;
        qproperty-alignment: 'AlignCenter | AlignVCenter';
    ]],
    style_on_hover = [[
        background-color: SlateGray;
        border: 2px solid DarkSlateGray;
        border-radius: 5px;
        qproperty-alignment: 'AlignCenter | AlignVCenter';
    ]],
    style_off_idle = [[
        background-color: DarkGray;
        border: 2px solid Grey;
        border-radius: 5px;
        qproperty-alignment: 'AlignCenter | AlignVCenter';
    ]],
    style_off_hover = [[
        background-color: Grey;
        border: 2px solid DarkGray;
        border-radius: 5px;
        qproperty-alignment: 'AlignCenter | AlignVCenter';
    ]],
    
    -- Legacy support for tab buttons
    buttonStyle = [[
        border-width: 2px;
        border-style: double;
        border-color: DarkSlateBlue;
        background-color: black;
        border-radius: 5px;
    ]]
}

-- Apply defaults initially
ZevDash = ZevDash or {}
ZevDash.Styles = ZevDash.Styles or {}
ZevDash.Styles.textColor = Wayfarer.Defaults.textColor
ZevDash.Styles.buttonStyle = Wayfarer.Defaults.buttonStyle
ZevDash.Styles.style_on_idle = Wayfarer.Defaults.style_on_idle
ZevDash.Styles.style_on_hover = Wayfarer.Defaults.style_on_hover
ZevDash.Styles.style_off_idle = Wayfarer.Defaults.style_off_idle
ZevDash.Styles.style_off_hover = Wayfarer.Defaults.style_off_hover
