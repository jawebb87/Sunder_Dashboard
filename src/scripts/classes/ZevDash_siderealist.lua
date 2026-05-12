-- ZevDash_siderealist.lua
-- Siderealist class page for Sunder Dashboard
-- Summons: Regalia items (named by the item you receive)
-- Toggles: Luminesce (cosmic balance stance), Gleam (maintain astral stars)

ZevDash = ZevDash or {}
ZevDash.class_toggles = ZevDash.class_toggles or {}

ZevDash.registerClass("siderealist", {
    summons = {
        { id = "glasses", name = "Glasses" },
        { id = "bow",     name = "Bow" },
        { id = "candle",  name = "Candle" },
        { id = "coin",    name = "Coin" },
        { id = "sword",   name = "Sword" },
        { id = "robe",    name = "Robe" },
        { id = "shoes",   name = "Shoes" },
        { id = "glove",   name = "Glove" },
        { id = "cloak",   name = "Cloak" },
        { id = "axe",     name = "Axe" },
        { id = "mask",    name = "Mask" },
        { id = "hammer",  name = "Hammer" },
        { id = "gear",    name = "Gear" },
        { id = "staff",   name = "Staff" },
        { id = "tome",    name = "Tome" },
    },
    actions = {
        -- Regalia summoning — buttons named by the item received
        { id = "reenact artos",    name = "Glasses",  cmd = "REENACT ARTOS" },
        { id = "reenact cthalut",  name = "Bow",      cmd = "REENACT CTHALUT" },
        { id = "reenact treyes",   name = "Candle",   cmd = "REENACT TREYES" },
        { id = "reenact izuari",   name = "Coin",     cmd = "REENACT IZUARI" },
        { id = "reenact vayua",    name = "Sword",    cmd = "REENACT VAYUA" },
        { id = "reenact loskiou",  name = "Robe",     cmd = "REENACT LOSKIOU" },
        { id = "reenact peripleko",name = "Shoes",    cmd = "REENACT PERIPLEKO" },
        { id = "reenact edamil",   name = "Glove",    cmd = "REENACT EDAMIL" },
        { id = "reenact umbrael",  name = "Cloak",    cmd = "REENACT UMBRAEL" },
        { id = "reenact melot",    name = "Axe",      cmd = "REENACT MELOT" },
        { id = "reenact ontesme",  name = "Mask",     cmd = "REENACT ONTESME" },
        { id = "reenact ulgar",    name = "Hammer",   cmd = "REENACT ULGAR" },
        { id = "reenact drobia",   name = "Gear",     cmd = "REENACT DROBIA" },
        { id = "reenact averroes", name = "Staff",    cmd = "REENACT AVERROES" },
        { id = "reenact ejakodosa",name = "Tome",     cmd = "REENACT EJAKODOSA" },
        -- Forfeit all regalia
        { id = "forfeit all",      name = "Forfeit",  cmd = "FORFEIT ALL" },
    },
    toggles = {
        { id = "luminesce", name = "Luminesce" },
        -- cosmic balance stance -- gates all Astranomia casting
        { id = "gleam",     name = "Gleam" },
        -- maintain astral stars -- drains willpower while active
    },

    renderInfo = function(self, mc)
        mc:cecho("\n SIDEREALIST DATA\n")
        mc:cecho(" " .. string.rep("-", 55) .. "\n")

        -- Summoned regalia tracking
        ZevDash.renderSummonStatus(mc, self.summons)
    end,
})
