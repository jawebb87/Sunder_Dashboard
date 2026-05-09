-- ZevDash_tidesage.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("tidesage", {
    actions = {
    },
    toggles = {
        { id = "synth listen", name = "Listen" },
        { id = "synth attend", name = "Attend" },
        { id = "synth lifebond", name = "Lifebond" },
        { id = "fog obscure", name = "Obscure" },
        { id = "fog fluctuations", name = "Fluctuations" },
        { id = "fog sirensong", name = "Sirensong" },
        { id = "fog panoptic", name = "Panoptic" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n TIDESAGE DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
