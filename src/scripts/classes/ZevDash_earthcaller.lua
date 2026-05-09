-- ZevDash_earthcaller.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("earthcaller", {
    actions = {
    },
    toggles = {
    },

    renderInfo = function(self, mc)
        mc:cecho("\n EARTHCALLER DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
