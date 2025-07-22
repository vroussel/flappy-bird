local M = {}

---@type table
local subscribers = {}

M.notify = function(key, scancode)
	for _, fn in ipairs(subscribers) do
		fn(key, scancode)
	end
end

M.subscribe = function(callback)
	table.insert(subscribers, callback)
end

return M
