-- ZevDash_infiltrator.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("infiltrator", {
    actions = {
    },
    toggles = {
        { id = "worm resonance", name = "Resonance" },
        { id = "palming", name = "Palming" },
        { id = "phaseveil", name = "Phaseveil" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n INFILTRATOR DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
