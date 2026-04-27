if not ZevDash then return end

function ZevDash.showHelp(cmd_prefix, topic)
    if not topic or topic == "" then
        cecho("\n<CadetBlue>" .. cmd_prefix:upper() .. " DASHBOARD HELP")
        cecho("\n<MediumSeaGreen>---------------")
        cecho("\n")
        cecho("\n<ForestGreen>Welcome to the <green>Sunder Dashboard<ForestGreen>! This modular UI system automatically tracks your class resources, toggles, summons, and standard Sunder defenses all in one place.")
        cecho("\n")
        cecho("\n<DeepSkyBlue>" .. cmd_prefix .. "               <ForestGreen>Toggle the dashboard UI on or off.")
        cecho("\n<DeepSkyBlue>" .. cmd_prefix .. " reset         <ForestGreen>Reset the window layout and position to coordinates (10, 10).")
        cecho("\n<DeepSkyBlue>" .. cmd_prefix .. " help          <ForestGreen>View this main help menu.")
        cecho("\n<DeepSkyBlue>" .. cmd_prefix .. " help config   <ForestGreen>View instructions on how to customize the dashboard.")
        cecho("\n")
        cecho("\n<MediumSeaGreen>------------------------------------------\n")
    elseif topic == "config" then
        cecho("\n<CadetBlue>" .. cmd_prefix:upper() .. " DASHBOARD CONFIGURATION")
        cecho("\n<MediumSeaGreen>---------------")
        cecho("\n")
        cecho("\n<ForestGreen>The dashboard is highly customizable to fit your exact UI needs. Customizations are broken down into two main areas: styling and logic.")
        cecho("\n")
        cecho("\n<MediumTurquoise>1. Styling and Colors")
        cecho("\n<ForestGreen>To change the background color, border styles, font colors, and hover effects, you need to edit the <white>ZevDash_Custom_Config.lua<ForestGreen> script. This file acts as the CSS stylesheet for your dashboard. If you accidentally break something, you can always copy the default styles from the main framework file.")
        cecho("\n")
        cecho("\n<MediumTurquoise>2. Customizing Class Files")
        cecho("\n<ForestGreen>Every class has its own dedicated configuration file located in the <white>classes<ForestGreen> folder (e.g. <white>ZevDash_wayfarer.lua<ForestGreen>). Inside these files, you can freely modify the <DeepSkyBlue>toggles<ForestGreen> and <DeepSkyBlue>actions<ForestGreen> lists. You can add brand new alias commands to be executed, or remove ones you don't want to see in your class panel. The framework will automatically generate the UI buttons based on the lists you provide!")
        cecho("\n")
        cecho("\n<MediumSeaGreen>------------------------------------------\n")
    else
        cecho("\n<red>ZevDash: Unknown help topic '" .. topic .. "'. Type '" .. cmd_prefix .. " help'.<reset>\n")
    end
end
