local World = {}

function World:new(width, height)
    local world = {
        width = width,
        height = height,
        entities = {},
    }
    setmetatable(world, self)
    self.__index = self
    return world
end

-- function to add entities to the world.
function World:addEntities(entity)
    table.insert(self.entities, entity)
end

function World:update(dt)
    for _, entity in ipairs(self.entities) do
        if entity.update then
            entity:update(dt)
        end
    end
end

function World:draw()
    for _, entity in ipairs(self.entities) do
        if entity.draw then
            entity:draw()
        end
    end
end

return World