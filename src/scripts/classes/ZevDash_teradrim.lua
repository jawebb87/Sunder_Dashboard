-- ZevDash_teradrim.lua

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("teradrim", {
    actions = {
    },
    toggles = {
        { id = "golem listen", name = "Listen" },
        { id = "golem servant", name = "Servant" },
        { id = "golem twinsoul", name = "Twinsoul" },
        { id = "sand disturbances", name = "Disturbances" },
        { id = "sand swelter", name = "Swelter" },
        { id = "sand projection", name = "Projection" },
    },

    renderInfo = function(self, mc)
        mc:cecho("\n TERADRIM DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
    end,
})
