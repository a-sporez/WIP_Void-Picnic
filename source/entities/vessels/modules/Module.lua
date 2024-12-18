local vector = require('libraries.hump.vector')
local Module = {}

function Module:new(x, y, name, size, type, spritePath)
    local sprt = love.graphics.newImage(spritePath)
    local obj  = {
        type        = type,
        name        = name,
        position    = vector(x, y),
        sprite      = sprt,
        picked      = false,
        active      = false,
        size        = size or 1
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Module:activate() -- Initializing module once installed by hardpoints
    if not self.active then
        self.active = true
    end
end

function Module:deactivate()
    if self.active then
        self.active = false
    end
end

function Module:update(dt)
    
end

function Module:draw()
    love.graphics.push()
    love.graphics.translate(self.position.x, self.position.y)
    love.graphics.draw(self.sprite, -self.sprite:getWidth() / 2, -self.sprite:getHeight() / 2)
    love.graphics.pop()
end

function Module:pickup(ship)
    if not self.picked then
        self.picked = true
        ship.hangar:storedModule(self)
    else
        print("[ERROR] Invalid ship or hangar not initialized")
    end
end

return Module