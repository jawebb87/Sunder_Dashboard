-- ZevDash_predator.lua
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.ClassModules = ZevDash.ClassModules or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("predator", {
    summons = {
        { id = "direwolf", name = "Direwolf" },
        { id = "orel", name = "Orel" },
        { id = "alpha", name = "Alpha" },
        { id = "orgyuk", name = "Orgyuk" },
        { id = "spider", name = "Spider" },
    },
    actions = {
        { id = "beastcall direwolf", name = "Direwolf", cmd = "BEASTCALL DIREWOLF" },
        { id = "beastcall orel", name = "Orel", cmd = "BEASTCALL OREL" },
        { id = "beastcall alpha", name = "Alpha", cmd = "BEASTCALL ALPHA" },
        { id = "beastcall orgyuk", name = "Orgyuk", cmd = "BEASTCALL ORGYUK" },
        { id = "beastcall spider", name = "Spider", cmd = "BEASTCALL SPIDER" },
    },
    toggles = {
        { id = "regeneration", name = "Regeneration" },
    },
    renderInfo = function(self, mc)
        mc:cecho("\n PREDATOR DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
        -- We just pass the summons table to our UI helper!
        ZevDash.renderSummonStatus(mc, self.summons)
    end
})
