local Buttons      = require('source.scenes.utility.interface.Button')
local GameState    = require('source.states.GameState')

local Menu = {}
local window_width = love.graphics.getWidth()
local window_height = love.graphics.getHeight()
local centre_x = window_width / 2
local centre_y = window_height / 2
local offset_x, offset_y = 48, 18

function Menu:enter()
    local menuFont = love.graphics.newFont('assets/fonts/setbackt.ttf', 22)
    love.graphics.setFont(menuFont)

    self.playButton = Buttons.new(
        centre_x - offset_x,
        centre_y - offset_y,
        96,
        36,
        "PLAY",
        function() GameState:enableRunning() end,
        nil,
        'assets/sprites/button_1.png'
    )

    self.exitButton = Buttons.new(
        centre_x - offset_x,
        centre_y + offset_y,
        96,
        36,
        "EXIT",
        love.event.quit,
        nil,
        'assets/sprites/button_1.png'
    )

end

function Menu:update(dt)
end

function Menu:draw()
    love.graphics.print("menu state", 10, 10)
    self.playButton:draw(self.button_x, self.button_y, 14, 7)
    self.exitButton:draw(self.button_x, self.button_y, 14, 7)
end

function Menu:mousepressed(x, y, button)
    if button == 1 and self.exitButton then
        self.exitButton:checkPressed(x, y, button)
        print("click")
    end
    if button == 1 and self.playButton then
        self.playButton:checkPressed(x, y, button)
        print("click")
    end
end

return Menu