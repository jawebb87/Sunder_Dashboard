-- ZevDash_ClassDetection.lua
if not snd then return end
ZevDash = ZevDash or {}

function ZevDash.getCurrentClass()
  if not gmcp or not gmcp.Char or not gmcp.Char.Status then return "unknown" end
  if snd and snd.class and snd.class ~= "None" then
    return snd.class:lower()
  elseif gmcp.Char.Status.class then
    return gmcp.Char.Status.class:lower()
  end
  return "unknown"
end
