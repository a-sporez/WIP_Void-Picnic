local Canvas = require('source.utility.canvas.Canvas')
-- this submodule declares the canvas where elements of the world are drawn.
local canvasMonitor = setmetatable({}, {__index = Canvas})

-- pass dimensions and currentWorld from the base class
function canvasMonitor:create(width, height, currentWorld)
    local canvas = Canvas:new(width, height, currentWorld)
    setmetatable(canvas, {__index = self})
    return canvas
end

-- dynamically update the world that the canvass in rendering.
function canvasMonitor:setWorld(world)
    self.currentWorld = world
end

-- 
function canvasMonitor:render()
    if not self.currentWorld then
        print("[ERROR] No current world to render")
        return
    end
    print("[DEBUG] Rendering canvas for world")
    self:start()
    self.currentWorld:draw()
    self:stop()
end

return canvasMonitor