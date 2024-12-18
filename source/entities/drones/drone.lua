local vector = require('libraries.vector')
local Drone = {}

-- constructor function for the Drone class base method
function Drone:new(x, y, width, height)
-- the object contains the base attributes, the prototype.
    local obj = {
        position = vector(x, y),
        width = width or 5,
        height = height or 10
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