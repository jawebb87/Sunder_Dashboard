-- ZevDash_voidseer.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("voidseer", {
    actions = {
    },
    toggles = {
    },

    renderInfo = function(self, mc)
        mc:cecho("\n VOIDSEER DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
