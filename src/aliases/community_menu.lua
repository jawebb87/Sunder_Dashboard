local arg = matches[2]

if not arg or arg == "" then
    ZevDash.show()
elseif arg:find("^help") then
    local topic = arg:match("^help%s*(.*)$")
    if ZevDash and ZevDash.showHelp then
        ZevDash.showHelp("smenu", topic)
    else
        cecho("\n<red>ZevDash: Help module not loaded.<reset>\n")
    end
elseif arg == "close" then
    ZevDash.hide()
elseif arg == "reset" then
    if ZevDash.window then
        ZevDash.window:move(10, 10)
        ZevDash.window:resize("90c", "25c")
        if ZevDash.window.saveLayout then
            ZevDash.window:saveLayout()
        end
        cecho("\n<green>ZevDash: Window layout reset to coordinates (10,10).<reset>\n")
    else
        cecho("\n<red>ZevDash: Window not built yet. Type 'smenu' first.<reset>\n")
    end
else
    cecho("\n<red>ZevDash: Unknown command '" .. arg .. "'. Type 'smenu help'.<reset>\n")
end
