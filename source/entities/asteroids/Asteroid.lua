local Asteroid = {}

function Asteroid:new(x, y, radius)
    local asteroid = {
        x = x or 0,
        y = y or 0,
        radius = radius or 20
    }
    setmetatable(asteroid, self)
    self.__index = self
    return asteroid
end

return Asteroid