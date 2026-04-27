-- ZevDash_Interactive.lua
if not snd then return end
ZevDash = ZevDash or {}

function ZevDash.toggleDef(def_name)
  if not snd or not snd.defenses or not snd.defenses[def_name] then return end
  snd.defenses[def_name].needit = not snd.defenses[def_name].needit
  ZevDash.saveState()
  ZevDash.displayPage(ZevDash.active_page)
end

function ZevDash.toggleCore(toggle_key)
  if not snd then return end
  if toggle_key == "active" then
    if snd.toggles then
      snd.toggles.active = not snd.toggles.active
      local stateStr = snd.toggles.active and "ACTIVE!" or "INACTIVE!"
      cecho("\nSunder is " .. stateStr .. "\n")
    end
  else
    if snd.toggle then snd.toggle(toggle_key) end
  end
  ZevDash.displayPage("core")
end

function ZevDash.doClassAction(action_cmd)
  local currentClass = ZevDash.getCurrentClass()
  local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
  if module and module.doAction then module:doAction(action_cmd) end
end

function ZevDash.toggleClass(toggle_key)
  local currentClass = ZevDash.getCurrentClass()
  local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
  if module and module.toggle then module:toggle(toggle_key) end
end

function ZevDash.btnHoverEnter(pane, key)
    local lbl, val
    if pane == "core" then
        lbl = ZevDash.core_labels and ZevDash.core_labels[key]
        val = snd.toggles and snd.toggles[key]
    elseif pane == "defs" then
        lbl = ZevDash.def_labels and ZevDash.def_labels[key]
        val = snd.defenses and snd.defenses[key] and snd.defenses[key].needit
    elseif pane == "class_action" then
        lbl = ZevDash.class_labels and ZevDash.class_labels[key]
        local actId = key:gsub("^act_", "")
        local currentClass = ZevDash.getCurrentClass()
        local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
        val = false
        if module and module.isActionOn then val = module:isActionOn(actId) end
    elseif pane == "class_toggle" then
        lbl = ZevDash.class_labels and ZevDash.class_labels[key]
        local currentClass = ZevDash.getCurrentClass()
        local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
        val = false
        if module and module.isToggleOn then val = module:isToggleOn(key) end
    end

    if lbl then
        lbl:setStyleSheet(val and ZevDash.Styles.style_on_hover or ZevDash.Styles.style_off_hover)
        lbl:show() -- Force Qt repaint
    end
end

function ZevDash.btnHoverLeave(pane, key)
    local lbl, val
    if pane == "core" then
        lbl = ZevDash.core_labels and ZevDash.core_labels[key]
        val = snd.toggles and snd.toggles[key]
    elseif pane == "defs" then
        lbl = ZevDash.def_labels and ZevDash.def_labels[key]
        val = snd.defenses and snd.defenses[key] and snd.defenses[key].needit
    elseif pane == "class_action" then
        lbl = ZevDash.class_labels and ZevDash.class_labels[key]
        local actId = key:gsub("^act_", "")
        local currentClass = ZevDash.getCurrentClass()
        local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
        val = false
        if module and module.isActionOn then val = module:isActionOn(actId) end
    elseif pane == "class_toggle" then
        lbl = ZevDash.class_labels and ZevDash.class_labels[key]
        local currentClass = ZevDash.getCurrentClass()
        local module = ZevDash.ClassModules and ZevDash.ClassModules[currentClass]
        val = false
        if module and module.isToggleOn then val = module:isToggleOn(key) end
    end

    if lbl then
        lbl:setStyleSheet(val and ZevDash.Styles.style_on_idle or ZevDash.Styles.style_off_idle)
        lbl:show() -- Force Qt repaint
    end
end
