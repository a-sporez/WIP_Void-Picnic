local Canvas = require('source.scenes.world.Canvas')

local canvasMonitor = setmetatable({}, {__index = Canvas})

function canvasMonitor:create(width, height, currentWorld)
    local canvas = Canvas:new(width, height, currentWorld)
    setmetatable(canvas, {__index = self})
    return canvas
end

-- dynamically update the world that the canvass in rendering.
function canvasMonitor:setWorld(world)
    self.currentWorld = world
end

function canvasMonitor:render()
    if not self.currentWorld then
        print("No current world to render")
        return
    end
    print("Rendering canvas for world")
    self:start()
    self.currentWorld:draw()
    self:stop()
end

return canvasMonitor