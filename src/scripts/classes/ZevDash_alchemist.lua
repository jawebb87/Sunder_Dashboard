-- ZevDash_alchemist.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("alchemist", {
    actions = {
    },
    toggles = {
        { id = "derive cognisance", name = "Cognisance" },
        { id = "experiment interposition", name = "Interposition" },
        { id = "botany distractions", name = "Distractions" },
        { id = "botany blightbringer", name = "Blightbringer" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n ALCHEMIST DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
