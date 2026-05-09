-- ZevDash_bloodborn.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("bloodborn", {
    actions = {
    },
    toggles = {
        { id = "well forewarn", name = "Forewarn" },
        { id = "well severance", name = "Severance" },
        { id = "well disparity", name = "Disparity" },
        { id = "well atrophy", name = "Atrophy" },
        { id = "well thrombose", name = "Thrombose" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n BLOODBORN DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
