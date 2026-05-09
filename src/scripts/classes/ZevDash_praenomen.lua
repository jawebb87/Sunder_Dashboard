-- ZevDash_praenomen.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("praenomen", {
    actions = {
    },
    toggles = {
        { id = "telesense", name = "Telesense" },
        { id = "blood tune", name = "Tune" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n PRAENOMEN DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
