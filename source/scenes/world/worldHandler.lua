local love = require('love')
local worldHandler = {}
worldHandler.__index = worldHandler

function worldHandler:new()
    local obj = {
        currentWorld = nil,
        worlds = {},
    }
    setmetatable(obj, self)
    return obj
end

-- add world to the manager's table
function worldHandler:addWorld(name, world_instance)
    self.worlds[name] = world_instance
end

-- switch to a specific world by name
function worldHandler:switch(name)
    if self.worlds[name] then
        self.currentWorld = self.worlds[name]
    else
        error("world '"..name.."' not found!")
    end
end

function worldHandler:update(dt)
    if self.currentWorld then
        self.currentWorld:update(dt)
    end
end

function worldHandler:draw()
    love.graphics.print("World: "..self.currentWorld, 10, 10)
    if self.currentWorld then
        self.currentWorld:draw()
    end
end

return worldHandler