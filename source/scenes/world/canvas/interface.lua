local Canvas = require('source.scenes.world.canvas.canvas')

local Interface = setmetatable({}, {__index = Canvas})

function Interface:new(width, height)
    local canvas = Canvas:new(width, height)
    setmetatable(canvas, {__index = self})
    return canvas
end

return Interface