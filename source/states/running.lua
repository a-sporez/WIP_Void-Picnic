--luacheck: ignore dt
local love          = require('love')
local GameState     = require('source.states.gamestate')
local Buttons       = require('source.classes.buttons.buttons')
local SurveyDrone   = require('source.classes.drones.survey')
local world         = require('source.scenes.world.world')

local Running = {}
local window_width = love.graphics.getWidth()
local window_height = love.graphics.getHeight()
local offset_x, offset_y = 48, 18

function Running:enter()

    self.World = world:new(10000, 10000)

    self.menuButton = Buttons.new(
        window_width - offset_x * 2,
        window_height - offset_y * 2,
        96,
        36,
        "MENU",
        function() GameState:enableMenu() end,
        nil,
        'assets/sprites/button_1.png'
    )

    self.survey2 = SurveyDrone:new(600, 600)
end

function Running:update(dt)
    self.survey2:move(-1, -1, dt)
    self.World:update(dt)
end

function Running:draw()

    self.menuButton:draw(self.button_x, self.button_y, 14, 7)

    love.graphics.print("running", 10, 10)
    self.survey2:draw()
end

function Running:mousepressed(x, y, button)
    if button == 1 and self.menuButton then
        self.menuButton:checkPressed(x, y, button)
        print("click")
    end
end

return Running