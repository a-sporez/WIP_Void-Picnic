local Canvas = require('source.scenes.world.Canvas')

local canvasMonitor = setmetatable({}, {__index = Canvas})

function canvasMonitor:new(width, height)
    local canvas = Canvas:new(width, height)
    setmetatable(canvas, {__index = self})
    return canvas
end

return canvasMonitor