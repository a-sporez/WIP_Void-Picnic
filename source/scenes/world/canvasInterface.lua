local Canvas = require('source.scenes.world.Canvas')
-- this is where UI elements should be drawn
local canvasInterface = setmetatable({}, {__index = Canvas})

function canvasInterface:create(width, height)
    local canvas = Canvas:new(width, height)
    setmetatable(canvas, {__index = self})
    return canvas
end

return canvasInterface