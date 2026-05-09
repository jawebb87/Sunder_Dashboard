-- ZevDash_akkari.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("akkari", {
    actions = {
    },
    toggles = {
        { id = "telesense", name = "Telesense" },
        { id = "spirit oneness", name = "Oneness" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n AKKARI DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
