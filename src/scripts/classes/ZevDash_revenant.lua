-- ZevDash_revenant.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("revenant", {
    actions = {
    },
    toggles = {
        { id = "ingather", name = "Ingather" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n REVENANT DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
