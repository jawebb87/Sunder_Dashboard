-- ZevDash_bard.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("bard", {
    actions = {
    },
    toggles = {
        { id = "equipoise", name = "Equipoise" },
        { id = "stretching", name = "Stretching" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n BARD DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
