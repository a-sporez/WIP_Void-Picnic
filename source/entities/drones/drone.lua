local vector = require('libraries.vector')
local Drone = {}

-- constructor function for the Drone class base method
function Drone:new(x, y, width, height, spritePath)
--    local sprt = spritePath and love.graphic.newImage(spritePath) or nil
--    assert(sprt, "[ERROR-DRONE] Invalid spritePath provided!")
--    print("[DEBUG-DRONE] Sprite dimensions>", sprt:getWidth(), sprt:getHeight())
    local obj = {
        position = vector(x, y),
        velocity = vector(0, 0),
        max_velocity = 10,
        friction = 0.995,
        width = width or 10,
        height = height or 20,
--        sprite = sprt,
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

-- update the Drone with basic movement logic
function Drone:move(dx, dy, dt)
    self.position.x = self.position.x + dx * dt
    self.position.y = self.position.y + dy * dt
end

-- draw an ellipse as placeholder
function Drone:draw()
    love.graphics.ellipse('fill', self.position.x, self.position.y, self.width, self.height)
end

return Drone