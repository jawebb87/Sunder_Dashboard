-- ZevDash_shapeshifter.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("shapeshifter", {
    actions = {
    },
    toggles = {
        { id = "pacing", name = "Pacing" },
        { id = "alertness", name = "Alertness" },
        { id = "metabolize", name = "Metabolize" },
        { id = "stealth", name = "Stealth" },
        { id = "corner", name = "Corner" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n SHAPESHIFTER DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
