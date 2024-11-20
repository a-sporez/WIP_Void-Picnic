local World = {}

function World:new(width, height)
    local world = {
        width = width,
        height = height
    }
    setmetatable(world, self)
    self.__index = self
    return world
end

function World:update(dt)
    
end

return World