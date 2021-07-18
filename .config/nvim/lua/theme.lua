vim.g.applied_theme = "onedark"

local base16
if not pcall(function()
	base16 = require("base16")
end) then
	return false
else
	base16(base16.themes["onedark"], true)
	return true
end
