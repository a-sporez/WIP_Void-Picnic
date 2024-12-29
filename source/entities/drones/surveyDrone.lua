local Drone = require('source.entities.drones.Drone')
local SurveyDrone = {}
SurveyDrone.__index = SurveyDrone
setmetatable(SurveyDrone, { __index = Drone })

function SurveyDrone:new(x, y)
    local drone = Drone.new(self, x, y, 'survey')
    drone.color = {0, 1, 0}
    setmetatable(drone, SurveyDrone)
    print("[DEBUG-SURVEYDRONE] Creating SurveyDrone at:", x, y)
    return drone
end

function SurveyDrone:draw()
    Drone.draw(self)
end

return SurveyDrone