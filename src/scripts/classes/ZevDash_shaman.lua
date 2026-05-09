-- ZevDash_shaman.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("shaman", {
    actions = {
    },
    toggles = {
        { id = "shaman spiritsight", name = "Spiritsight" },
        { id = "familiar tether", name = "Tether" },
        { id = "familiar spiritbond", name = "Spiritbond" },
        { id = "nature whispers", name = "Whispers" },
        { id = "nature greenfoot", name = "Greenfoot" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n SHAMAN DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
