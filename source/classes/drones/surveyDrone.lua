local Drone = require('source.classes.drones.Drone')
-- this class is an extension of Drone class, adding color.
local surveyDrone = Drone:new()

function surveyDrone:new(x, y)
    local obj = Drone.new(self, x, y)
    obj.color = {0, 1, 0}
    return obj
end

function surveyDrone:draw()
    love.graphics.setColor(self.color)
    Drone.draw(self)
    love.graphics.setColor(1, 1, 1)
end

return surveyDrone