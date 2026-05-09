-- ZevDash_ascendril.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("ascendril", {
    actions = {
    },
    toggles = {
        { id = "fulcrum echoes", name = "Echoes" },
        { id = "fulcrum schism", name = "Schism" },
        { id = "fulcrum imbalance", name = "Imbalance" },
        { id = "fulcrum degradation", name = "Degradation" },
        { id = "fulcrum spiritrift", name = "Spiritrift" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n ASCENDRIL DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
