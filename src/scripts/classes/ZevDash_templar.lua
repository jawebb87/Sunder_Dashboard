-- ZevDash_templar.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("templar", {
    actions = {
    },
    toggles = {
        { id = "bladefury", name = "Bladefury" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n TEMPLAR DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
