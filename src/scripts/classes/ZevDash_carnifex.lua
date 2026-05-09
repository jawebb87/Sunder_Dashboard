-- ZevDash_carnifex.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("carnifex", {
    actions = {
    },
    toggles = {
        { id = "reveling", name = "Reveling" },
        { id = "recklessness", name = "Recklessness" },
        { id = "hammer rage", name = "Rage" },
        { id = "soul harvest", name = "Harvest" },
        { id = "soul alertness", name = "Alertness" },
        { id = "hound flank", name = "Flank" },
        { id = "hound openings", name = "Openings" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n CARNIFEX DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
