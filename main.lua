GAME_WIDTH = 432
GAME_HEIGHT = 243

local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

local love = require("love")
local push = require("push")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	background_img = love.graphics.newImage("assets/background.png")
	ground_img = love.graphics.newImage("assets/ground.png")

	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { resizable = true, vsync = true, fullscreen = false })
	push.setupScreen(GAME_WIDTH, GAME_HEIGHT, { upscale = "normal" })

	math.randomseed(os.time())

	love.window.setTitle("Flappy Bird")
end

function love.resize(w, h)
	push.resize(w, h)
end

function love.keypressed(key)
	if key == "q" then
		love.event.quit()
	end
end

function love.update() end

function love.draw()
	push.start()
	push.finish()
end
