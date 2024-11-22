local camera = require('libraries.camera')

local Camera = {}
Camera.instance = nil
Camera.zoom = 1

function Camera.init(x, y)
    Camera.instance = camera(x, y)
end

function Camera.update(targetX, targetY)
    Camera.instance:lookAt(targetX, targetY)
end

function Camera.setZoom(zoomLevel)
    Camera.zoom = zoomLevel
    Camera.instance:zoomTo(zoomLevel)
end

function Camera.attach()
    Camera.instance:attach()
end

function Camera.detach()
    Camera.instance:detach()
end

return Camera