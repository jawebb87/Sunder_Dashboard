-- ZevDash_ravager.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("ravager", {
    actions = {
    },
    toggles = {
        { id = "ego humiliate", name = "Humiliate" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n RAVAGER DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
