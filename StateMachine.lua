---@class StateMachine
---@field states table<string, fun(...):State>
---@field current State
---@field render function
---@field update function
---@field process_ai function
---@field enter function
---@field exit function
---@field keypressed function
local StateMachine = {}

---@param states table<string, fun(...): State>
---@param initial_state string
function StateMachine:new(states, initial_state)
	local s = {}
	setmetatable(s, self)
	self.__index = self
	s.states = states
	s.current = states[initial_state]()
	s.current:enter()

	return s
end

function StateMachine:change(state_name, state_params)
	assert(self.states[state_name])

	local old_state = self.current
	self.current:exit()
	self.current = self.states[state_name]()
	self.current:enter(state_params)
	print("Changed state from " .. old_state.name .. " to " .. self.current.name)
end

function StateMachine:update(dt)
	self.current:update(dt)
end

function StateMachine:render()
	self.current:render()
end

function StateMachine:process_ai()
	self.current:process_ai()
end

function StateMachine:keypressed(key, code)
	self.current:keypressed(key, code)
end

return StateMachine
