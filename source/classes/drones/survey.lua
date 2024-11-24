local love = require('love')
local Drone = require('source.classes.drones.drone')
-- this class is an extension of Drone class, adding color.
local SurveyDrone = Drone:new()

function SurveyDrone:new(x, y)
    local obj = Drone.new(self, x, y)
    obj.color = {0, 1, 0}
    return obj
end

function SurveyDrone:draw()
    love.graphics.setColor(self.color)
    Drone.draw(self)
    love.graphics.setColor(1, 1, 1)
end

return SurveyDrone