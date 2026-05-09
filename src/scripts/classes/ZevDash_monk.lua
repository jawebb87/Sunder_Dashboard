-- ZevDash_monk.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("monk", {
    actions = {
    },
    toggles = {
        { id = "regeneration", name = "Regeneration" },
        { id = "projectiles", name = "Projectiles" },
        { id = "telesense", name = "Telesense" },
        { id = "mind insight", name = "Insight" },
        { id = "mind cloak", name = "Cloak" },
        { id = "mind net", name = "Net" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n MONK DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
