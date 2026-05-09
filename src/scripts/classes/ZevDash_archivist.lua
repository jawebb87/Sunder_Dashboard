-- ZevDash_archivist.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("archivist", {
    actions = {
    },
    toggles = {
    },

    renderInfo = function(self, mc)
        mc:cecho("\n ARCHIVIST DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
