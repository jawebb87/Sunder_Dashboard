-- ZevDash_indorani.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("indorani", {
    actions = {
    },
    toggles = {
    },

    renderInfo = function(self, mc)
        mc:cecho("\n INDORANI DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
