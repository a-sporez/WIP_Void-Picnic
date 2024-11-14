local love        = require('love')
local Button      = require('scripts.classes.buttons.buttons')

local Menu = {}
local window_width = love.graphics.getWidth()
local window_height = love.graphics.getHeight()
local centre_x = window_width / 2
local centre_y = window_height / 2
local offset_x, offset_y = 48, 18

function Menu:enter()
    local menuFont = love.graphics.newFont('assets/fonts/setbackt.ttf', 22)
    love.graphics.setFont(menuFont)

    self.exitButton = Button.new(
        centre_x - offset_x,
        centre_y - offset_y,
        96,
        36,
        "EXIT",
        love.event.quit,
        nil,
        'assets/sprites/button_1.png'
    )

end
--[[
function Menu:update(dt)
end
--]]
function Menu:draw(button_x, button_y, text_x, text_y)
    love.graphics.print("menu state", 10, 10)
    self.exitButton:draw(button_x, button_y, 24, 6)
    if self.exit_button then
        self.exitButton:checkPressed(self.exitButton.x, self.exitButton.y)
    end
end

function Menu:mousepressed(x, y, button)
    if button == 1 and self.exitButton then
        self.exitButton:checkPressed(x, y, 1)
    end
end

return Menu