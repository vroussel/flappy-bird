---@class State
---@field name string
---@field render function
---@field update function
---@field process_ai function
---@field enter function
---@field exit function
---@field state_machine StateMachine|nil
local State = {}

function State:new(o)
	local s = o or {}
	setmetatable(s, self)
	self.__index = self

	s.state_machine = nil

	return s
end

function State:enter() end
function State:exit() end
function State:update(dt) end
function State:render() end
function State:update_ai() end

function State:set_state_machine(state_machine)
	self.state_machine = state_machine
end

return State
