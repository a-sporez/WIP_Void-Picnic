local Canvas = require('source.scenes.world.canvas.canvas')

local Monitor = setmetatable({}, {__index = Canvas})

function Monitor:new(width, height)
    local canvas = Canvas:new(width, height)
    setmetatable(canvas, {__index = self})
    return canvas
end

return Monitor