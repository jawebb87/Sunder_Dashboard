-- ZevDash_zealot.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("zealot", {
    actions = {
    },
    toggles = {
    },

    renderInfo = function(self, mc)
        mc:cecho("\n ZEALOT DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
