---@class State
---@field name string
---@field render function
---@field update function
---@field process_ai function
---@field enter function
---@field exit function
local State = {}

function State:enter() end
function State:exit() end
function State:update() end
function State:render() end
function State:update_ai() end

return State
