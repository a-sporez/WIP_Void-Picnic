local Button = {}
Button.__index = Button

function Button.new(x, y, width, height, text, func, func_param, sprite_path)
    local self = setmetatable({}, Button)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.text = text or "<none>"
    self.func = func or function() print("no function") end
    self.func_param = func_param
    self.button_x = x
    self.button_y = y
    self.sprite = love.graphics.newImage(sprite_path)
    return self
end

function Button.checkPressed(self, mouse_x, mouse_y, cursor_radius)
    if (mouse_x + cursor_radius >= self.button_x and
        mouse_x - cursor_radius <= self.button_x + self.width) and
        (mouse_y + cursor_radius >= self.button_y and
        mouse_y - cursor_radius <= self.button_y + self.height) then
        if self.func_param then
            self.func(self.func_param)
        else
            self.func()
        end
    end
end

function Button.draw(self, button_x, button_y, text_x, text_y)
    self.button_x = button_x or self.button_x
    self.button_y = button_y or self.button_y
    self.text_x = text_x and (text_x + self.button_x) or self.button_x
    self.text_y = text_y and (text_y + self.button_y) or self.button_y
    love.graphics.draw(self.sprite, self.button_x, self.button_y)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self.text, self.text_x, self.text_y)
    love.graphics.setColor(1, 1, 1)
end

return Button