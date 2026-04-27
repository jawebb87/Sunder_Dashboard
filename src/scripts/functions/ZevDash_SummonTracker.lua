-- ZevDash_SummonTracker.lua
if not snd then return end
ZevDash = ZevDash or {}
ZevDash.tracked_entities = ZevDash.tracked_entities or {}

function ZevDash.handleRoomItems(event, arg)
    local currentClass = ZevDash.getCurrentClass()
    local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
    
    -- If the active class doesn't have a summons table, skip all this GMCP processing
    if not module or not module.summons then return end

    -- Dynamically pull the tracking IDs from the class file!
    local keywords = {}
    for _, s in ipairs(module.summons) do
        table.insert(keywords, s.id)
    end

    if event == "gmcp.Room.Items.List" then
        -- Reset tracking for our class entities
        for _, kw in ipairs(keywords) do ZevDash.tracked_entities[kw] = false end
        
        if gmcp.Room and gmcp.Room.Items and gmcp.Room.Items.List and gmcp.Room.Items.List.items then
            for _, item in ipairs(gmcp.Room.Items.List.items) do
                if item.attrib == "m" or item.attrib == "mx" then
                    local name = item.name:lower()
                    for _, kw in ipairs(keywords) do
                        if name:find(kw) and not name:find("corpse") then
                            ZevDash.tracked_entities[kw] = true
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
                for _, kw in ipairs(keywords) do
                    if name:find(kw) and not name:find("corpse") then
                        ZevDash.tracked_entities[kw] = true
                    end
                end
            end
        end
        
    elseif event == "gmcp.Room.Items.Remove" then
        if gmcp.Room and gmcp.Room.Items and gmcp.Room.Items.Remove and gmcp.Room.Items.Remove.item then
            local item = gmcp.Room.Items.Remove.item
            local name = item.name:lower()
            for _, kw in ipairs(keywords) do
                if name:find(kw) and ZevDash.tracked_entities[kw] then
                    ZevDash.tracked_entities[kw] = false
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
