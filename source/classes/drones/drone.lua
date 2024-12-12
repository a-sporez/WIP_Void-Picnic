local Drone = {}

-- constructor function for the Drone class base method
function Drone:new(x, y, width, height)
-- the object contains the base attributes, the prototype.
    local obj = {
        x = x or 0,
        y = y or 0,
        width = width or 5,
        height = height or 10
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

-- update the Drone with basic movement logic
function Drone:move(dx, dy, dt)
    self.x = self.x + dx * dt
    self.y = self.y + dy * dt
end

-- draw an ellipse as placeholder
function Drone:draw()
    love.graphics.ellipse('fill', self.x, self.y, self.width, self.height)
end

return Drone