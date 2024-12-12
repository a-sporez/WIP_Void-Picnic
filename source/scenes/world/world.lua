
local World = {}

function World:new(width, height)
    local world = {
        width = width,
        height = height,
        entities = {},
    }
    setmetatable(world, self)
    self.__index = self
    print("[DEBUG] World created with dimensions:", width, height)
    return world
end

function World:addEntity(entity)
    table.insert(self.entities, entity)
    print("[DEBUG] Entity added at position:", entity.x, entity.y)
    return entity
end

function World:update(dt)
    print("[DEBUG] Updating World")
    for _, entity in ipairs(self.entities) do
        if entity.update then
            entity:update(dt)
        end
    end
end

function World:drawGrid(cellSize)
    cellSize = cellSize or 100
    love.graphics.setColor(0.2, 0.2, 0.2)
    for x = 0, self.width, cellSize do
        love.graphics.line(x, 0, x, self.height)
    end
    for y = 0, self.height, cellSize do
        love.graphics.line(0, y, self.width, y)
    end
    love.graphics.setColor(1, 1, 1)
end

function World:draw()
    love.graphics.setCanvas(self.canvas) -- Target the world canvas.
    love.graphics.clear() -- Clear the canvas.
    self:drawGrid() -- Draw the grid.
    for _, entity in ipairs(self.entities) do
        entity:draw()
        print("[DEBUG] Entity position:", entity.x, entity.y)
    end
    love.graphics.setCanvas() -- Reset to the main canvas.
end

return World