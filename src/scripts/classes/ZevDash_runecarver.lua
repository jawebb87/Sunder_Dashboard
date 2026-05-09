-- ZevDash_runecarver.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("runecarver", {
    actions = {
    },
    toggles = {
        { id = "hex rancour", name = "Rancour" },
        { id = "hex assuage", name = "Assuage" },
        { id = "runecarve prowess", name = "Prowess" },
        { id = "runecarve lunacy", name = "Lunacy" },
        { id = "runecarve toil", name = "Toil" },
        { id = "spore hartsblood", name = "Hartsblood" },
        { id = "spore stormstem", name = "Stormstem" },
        { id = "spore ravencap", name = "Ravencap" },
        { id = "spore greycrown", name = "Greycrown" },
        { id = "spore sapmantle", name = "Sapmantle" },
        { id = "spore furyscale", name = "Furyscale" },
        { id = "spore rootcrest", name = "Rootcrest" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n RUNECARVER DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
