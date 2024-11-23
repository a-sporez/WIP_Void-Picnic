local Canvas = require('source.scenes.world.Canvas')

local canvasInterface = setmetatable({}, {__index = Canvas})

function canvasInterface:new(width, height)
    local canvas = Canvas:new(width, height)
    setmetatable(canvas, {__index = self})
    return canvas
end

return canvasInterface