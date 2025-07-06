---@class Pipe
---@field x number
---@field y number
---@field width number
local Pipe = {}

local SCROLL_SPEED = 60

function Pipe:new()
	local p = {}
	setmetatable(p, Pipe)
	self.__index = self

	p.image = love.graphics.newImage("assets/pipe.png")
	p.width = p.image:getWidth()
	p.height = p.image:getHeight()
	p.x = GAME_WIDTH
	p.y = math.random(GAME_HEIGHT * 0.5, GAME_HEIGHT * 0.9)

	return p
end

function Pipe:update(dt)
	self.x = self.x - SCROLL_SPEED * dt
end

function Pipe:render()
	love.graphics.draw(self.image, self.x, self.y)
end

return Pipe
