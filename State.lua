---@class State
---@field name string
---@field render function
---@field update function
---@field process_ai function
---@field enter function
---@field exit function
local State = {}

function State:new(o)
	local s = o or {}
	setmetatable(s, self)
	self.__index = self
	return s
end

function State:enter() end
function State:exit() end
function State:update(dt) end
function State:render() end
function State:update_ai() end

return State
