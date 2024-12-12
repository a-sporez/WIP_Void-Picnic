--[[
Base class to declare the usage of the love2d canvas module.
--]]
local Canvas = {}
-- metatable is defined as Canvas
Canvas.__index = Canvas

-- declare dimensions and pass to currentWorld
function Canvas:new(width, height, currentWorld)
    local obj = {
        -- call the love canvas module
        canvas = love.graphics.newCanvas(width, height),
        -- declare currentWorld or skip with nil
        currentWorld = currentWorld or nil
    }
    setmetatable(obj, self)
    return obj
end

-- Initialize the canvas
function Canvas:start()
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear()
end

-- declare that the canvas end point
function Canvas:stop()
    love.graphics.setCanvas()
end

-- pass parameter to define the scale, otherwise scale to 1
function Canvas:draw(scaleX, scaleY)
    scaleX = scaleX or 1
    scaleY = scaleY or 1
    love.graphics.draw(self.canvas, 0, 0, 0, scaleX, scaleY)
end

return Canvas