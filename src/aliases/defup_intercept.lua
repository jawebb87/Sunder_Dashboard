if not ZevDash then return end

-- When the user types defup, Sunder natively resets snd.defenses to its default states.
-- We use a 0.2 second delay to ensure Sunder finishes its table reconstruction
-- before we force ZevDash to overwrite those tables with the user's saved profile.
tempTimer(0.2, function()
    if ZevDash and ZevDash.loadState then
        ZevDash.loadState()
        if ZevDash.visible then
            ZevDash.displayPage(ZevDash.active_page)
        end
    end
end)
