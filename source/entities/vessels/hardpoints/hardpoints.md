# Hardpoints

- ## Constructor

```lua
function Hardpoint:new(name, type, cpu, pwg, mount_x, mount_y)
    local sprite_paths = {
        ["8x8"] = 'assets/sprites/hardpoints/8x8_mk1.png',
        ["16x18"] = 'assets/sprites/hardpoints/18x16_mk1.png'
    }
    local sprite_path = sprite_paths[type]
    if not sprite_path then
        error("Invalid hardpoint type: " .. tostring(type))
    end
    local sprt = love.graphics.newImage(sprite_path)
    local obj = {
        name = name,
        type = type,
        cpu = cpu,
        pwg = pwg,
        installed = nil,
        occupied = false,
        mount = vector(mount_x, mount_y),
        sprite = sprt,
        width = sprt:getWidth(),
        height = sprt:getHeight()
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end
```
