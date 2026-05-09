-- ZevDash_sciomancer.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("sciomancer", {
    actions = {
    },
    toggles = {
        { id = "cast engulf", name = "Engulf" },
        { id = "cast purity", name = "Purity" },
        { id = "cast devour", name = "Devour" },
        { id = "cast rigor", name = "Rigor" },
        { id = "cast madness", name = "Madness" },
        { id = "cast spectre", name = "Spectre" },
        { id = "gravity weight", name = "Weight" },
        { id = "gravity absorb", name = "Absorb" },
        { id = "gravity attunement", name = "Attunement" },
        { id = "gravity pulsar", name = "Pulsar" },
        { id = "gravity horizon", name = "Horizon" },
        { id = "gravity stability", name = "Stability" },
        { id = "gravity secure", name = "Secure" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n SCIOMANCER DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
