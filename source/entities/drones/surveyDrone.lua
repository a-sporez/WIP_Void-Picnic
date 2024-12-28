local Drone = require('source.entities.drones.Drone')
local SurveyDrone = {}
SurveyDrone.__index = SurveyDrone
setmetatable(SurveyDrone, { __index = Drone }) -- Inherit from Drone

function SurveyDrone:new(x, y)
    local drone = Drone.new(self, x, y, 'survey') -- Pass `self` as the class to Drone
    drone.color = {0, 1, 0}
    setmetatable(drone, SurveyDrone) -- Set SurveyDrone as metatable
    print("[DEBUG-SURVEYDRONE] Creating SurveyDrone at:", x, y)
    return drone
end

function SurveyDrone:draw()
    love.graphics.setColor(self.color)
    Drone.draw(self)
    love.graphics.setColor(1, 1, 1)
end

return SurveyDrone