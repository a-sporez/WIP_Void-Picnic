
local Canvas = {}
Canvas.__index = Canvas

function Canvas:new(width, height, currentWorld)
    local obj = {
        canvas = love.graphics.newCanvas(width, height),
        currentWorld = currentWorld or nil
    }
    setmetatable(obj, self)
    return obj
end

function Canvas:start()
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear()
end

function Canvas:stop()
    love.graphics.setCanvas()
end

function Canvas:draw(scaleX, scaleY)
    scaleX = scaleX or 1
    scaleY = scaleY or 1
    love.graphics.draw(self.canvas, 0, 0, 0, scaleX, scaleY)
end

return Canvas