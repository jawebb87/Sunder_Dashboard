-- ZevDash_GetResource.lua
if not snd then return end

ZevDash = ZevDash or {}

function ZevDash.renderResources(mc)
    if not snd or not snd.charstats then return end
    
    local found = false
    -- We want to iterate through snd.charstats and show everything that isn't class or bleeding
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
    
    if found then
        mc:cecho("\n")
    end
end
