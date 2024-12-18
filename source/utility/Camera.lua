local camera = require('libraries.camera')

local Camera = {}
Camera.focus = nil
Camera.zoom = 1

function Camera:new(x, y)
    self.focus = camera(x, y)
end

function Camera:update(targetX, targetY)
-- Smoothly pan to the target postion
    if targetX and targetY then
        self.focus:lookAt(targetX, targetY)
    end
end

function Camera:move(dx, dy)
    local x, y = self.focus.x, self.focus.y
    self.focus:lookAt(x + dx, y + dy)
end

function Camera:setZoom(zoomLevel)
    self.zoom = zoomLevel
    self.focus:zoomTo(Camera.zoom)
end

function Camera:adjustZoom(delta)
    self.zoom = math.max(0.5, math.min(2, Camera.zoom + delta))
    self.focus:zoomTo(Camera.zoom)
end

function Camera:attach()
    self.focus:attach()
end

function Camera:detach()
    self.focus:detach()
end

return Camera