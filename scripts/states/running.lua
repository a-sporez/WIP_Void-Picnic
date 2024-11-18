--luacheck: ignore dt
local love          = require('love')
local GameState     = require('scripts.states.gamestate')
local Buttons       = require('scripts.classes.buttons.buttons')
local SurveyDrone   = require('scripts.classes.drones.survey')

local Running = {}
local window_width = love.graphics.getWidth()
local window_height = love.graphics.getHeight()
local centre_x = window_width / 2
local centre_y = window_height / 2
local offset_x, offset_y = 48, 18

function Running:enter()

    self.menuButton = Buttons.new(
        centre_x - offset_x,
        love.graphics.getHeight() - offset_y * 2,
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
    self.survey2:move(-1, -1)
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