-- ZevDash_warden.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("warden", {
    actions = {
    },
    toggles = {
        { id = "ancest victory", name = "Victory" },
        { id = "ancest alertness", name = "Alertness" },
        { id = "simul flank", name = "Flank" },
        { id = "simul openings", name = "Openings" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n WARDEN DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
