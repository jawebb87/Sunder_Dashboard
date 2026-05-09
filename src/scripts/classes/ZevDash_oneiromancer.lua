-- ZevDash_oneiromancer.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("oneiromancer", {
    actions = {
    },
    toggles = {
    },

    renderInfo = function(self, mc)
        mc:cecho("\n ONEIROMANCER DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
