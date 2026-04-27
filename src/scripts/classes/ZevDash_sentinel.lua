-- ZevDash_sentinel.lua
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.ClassModules = ZevDash.ClassModules or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("sentinel", {
    summons = {
        { id = "wisp", name = "Wisp" },
        { id = "weasel", name = "Weasel" },
        { id = "rook", name = "Rook" },
        { id = "coyote", name = "Coyote" },
        { id = "raccoon", name = "Raccoon" },
        { id = "gyrfalcon", name = "Gyrfalcon" },
        { id = "raloth", name = "Raloth" },
        { id = "crocodile", name = "Crocodile" },
        { id = "icewyrm", name = "Icewyrm" },
        { id = "cockatrice", name = "Cockatrice" },
    },
    actions = {
        { id = "call animals", name = "Animals", cmd = "CALL ANIMALS" },
        { id = "call wisp", name = "Wisp", cmd = "CALL WISP" },
        { id = "call weasel", name = "Weasel", cmd = "CALL WEASEL" },
        { id = "call rook", name = "Rook", cmd = "CALL ROOK" },
        { id = "call coyote", name = "Coyote", cmd = "CALL COYOTE" },
        { id = "call raccoon", name = "Raccoon", cmd = "CALL RACCOON" },
        { id = "call gyrfalcon", name = "Gyrfalcon", cmd = "CALL GYRFALCON" },
        { id = "call raloth", name = "Raloth", cmd = "CALL RALOTH" },
        { id = "call crocodile", name = "Crocodile", cmd = "CALL CROCODILE" },
        { id = "call icewyrm", name = "Icewyrm", cmd = "CALL ICEWYRM" },
        { id = "call cockatrice", name = "Cockatrice", cmd = "CALL COCKATRICE" },
    },
    toggles = {
        { id = "resting", name = "Resting" },
        { id = "balancing", name = "Balancing" },
        { id = "coagulation", name = "Coagulation" },
    },
    renderInfo = function(self, mc)
        mc:cecho("\n SENTINEL DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
        ZevDash.renderSummonStatus(mc, self.summons)
    end
})
