
local Module = {}

function Module:new(x, y, type, size)
    local obj = {
        x = x,
        y = y,
        type = type,
        size = size
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Module:activate() -- Initializing module once installed by hardpoints
    
end

function Module:deactivate()
    
end

function Module:update(dt)
    
end

function Module:draw()
    
end

return Module