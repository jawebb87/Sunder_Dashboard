-- ZevDash_luminary.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("luminary", {
    actions = {
    },
    toggles = {
    },

    renderInfo = function(self, mc)
        mc:cecho("\n LUMINARY DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
