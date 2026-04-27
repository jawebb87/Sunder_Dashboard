-- ZevDash_executor.lua
if not snd then return end

ZevDash = ZevDash or {}
ZevDash.ClassModules = ZevDash.ClassModules or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("executor", {
    summons = {
        { id = "lurker", name = "Lurker" },
        { id = "wardpeeler", name = "Wardpeeler" },
        { id = "lightdrinker", name = "Lightdrinker" },
        { id = "murder", name = "Murder" },
        { id = "pilferer", name = "Pilferer" },
        { id = "darkhound", name = "Darkhound" },
        { id = "monstrosity", name = "Monstrosity" },
        { id = "throatripper", name = "Throatripper" },
        { id = "brutaliser", name = "Brutaliser" },
        { id = "eviscerator", name = "Eviscerator" },
        { id = "rimestalker", name = "Rimestalker" },
        { id = "terrifier", name = "Terrifier" },
    },
    actions = {
        { id = "call accomplices", name = "Accomplices", cmd = "Call Accomplices" },
        { id = "fabricate lurker", name = "Lurker", cmd = "FABRICATE LURKER" },
        { id = "fabricate wardpeeler", name = "Wardpeeler", cmd = "FABRICATE WARDPEELER" },
        { id = "fabricate lightdrinker", name = "Lightdrinker", cmd = "FABRICATE LIGHTDRINKER" },
        { id = "fabricate murder", name = "Murder", cmd = "FABRICATE MURDER" },
        { id = "fabricate pilferer", name = "Pilferer", cmd = "FABRICATE PILFERER" },
        { id = "fabricate darkhound", name = "Darkhound", cmd = "FABRICATE DARKHOUND" },
        { id = "fabricate monstrosity", name = "Monstrosity", cmd = "FABRICATE MONSTROSITY" },
        { id = "fabricate throatripper", name = "Throatripper", cmd = "FABRICATE THROATRIPPER" },
        { id = "fabricate brutaliser", name = "Brutaliser", cmd = "FABRICATE BRUTALISER" },
        { id = "fabricate eviscerator", name = "Eviscerator", cmd = "FABRICATE EVISCERATOR" },
        { id = "fabricate rimestalker", name = "Rimestalker", cmd = "FABRICATE RIMESTALKER" },
        { id = "fabricate terrifier", name = "Terrifier", cmd = "FABRICATE TERRIFIER" },
    },
    toggles = {
        { id = "repose", name = "Repose" },
        { id = "lithe", name = "Lithe" },
        { id = "coagulation", name = "Coagulation" },
    },
    renderInfo = function(self, mc)
        mc:cecho("\n EXECUTOR DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")
        ZevDash.renderSummonStatus(mc, self.summons)
    end
})
