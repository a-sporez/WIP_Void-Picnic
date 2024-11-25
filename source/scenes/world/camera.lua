local camera = require('libraries.camera')

local Camera = {}
Camera.instance = nil
Camera.zoom = 1

function Camera.init(x, y)
    Camera.instance = camera(x, y)
end

function Camera.update(targetX, targetY, dt)

-- Smoothly pan to the target postion
    if targetX and targetY then
        Camera.instance:lookAt(targetX, targetY)
    end
    local panSpeed = 500 * dt
    if love.keyboard.isDown('up') then
        Camera.instance:move(0, -panSpeed)
    end
    if love.keyboard.isDown('down') then
        Camera.instance:move(0, panSpeed)
    end
    if love.keyboard.isDown('left') then
        Camera.instance:move(-panSpeed, 0)
    end
    if love.keyboard.isDown('right') then
        Camera.instance:move(panSpeed, 0)
    end
end

function Camera.setZoom(zoomLevel)
    Camera.zoom = zoomLevel
    Camera.instance:zoomTo(Camera.zoom)
end

function Camera.adjustZoom(delta)
    Camera.zoom = math.max(0.5, math.min(2, Camera.zoom + delta))
    Camera.instance:zoomTo(Camera.zoom)
end

function Camera.attach()
    Camera.instance:attach()
end

function Camera.detach()
    Camera.instance:detach()
end

return Camera