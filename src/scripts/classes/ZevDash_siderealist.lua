-- ZevDash_siderealist.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("siderealist", {
    actions = {
    },
    toggles = {
    },

    renderInfo = function(self, mc)
        mc:cecho("\n SIDEREALIST DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
