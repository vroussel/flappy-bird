---@class Bird
---@field x number
---@field y number
---@field width number
---@field height number
---@field image love.Image
local Bird = {}

function Bird:new()
	local b = {}
	setmetatable(b, self)
	self.__index = self

	b.image = love.graphics.newImage("assets/bird.png")
	b.width = b.image:getWidth()
	b.height = b.image:getHeight()
	b.x = GAME_WIDTH / 2 - b.width / 2
	b.y = GAME_HEIGHT / 2 - b.height / 2

	return b
end

function Bird:render()
	love.graphics.draw(self.image, self.x, self.y)
end

return Bird
