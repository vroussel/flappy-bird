local M = {}

---@type table<string, boolean>
local keys = {}

function M.push(key)
	keys[key] = true
end

function M.pressed(key)
	return keys[key] or false
end

function M.reset()
	keys = {}
end

return M
