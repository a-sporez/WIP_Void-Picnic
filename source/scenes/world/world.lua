local World = {}

function World:new(width, height)
    local world = {
        width = width,
        height = height,
        entities = {},
    }
    setmetatable(world, self)
    self.__index = self
    print("World created with dimensions:", width, height)
    return world
end

function World:addEntity(entity)
    table.insert(self.entities, entity)
    print("Entity added at position:", entity.x, entity.y)
    return entity
end

function World:update(dt)
    print("Updating World")
    for _, entity in ipairs(self.entities) do
        if entity.update then
            entity:update(dt)
        end
    end
end

function World:draw()
    print("Drawing World")
    for _, entity in ipairs(self.entities) do
        if entity.draw then
            entity:draw()
        end
    end
end

return World