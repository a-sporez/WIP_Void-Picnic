# Drones

- ## Constructor

```lua
function Drone:new(x, y, drone_type)
    local sprite_paths = {
        ['survey'] = 'assets/sprites/drones/survey.png'
    }

    local sprite_path = sprite_paths[drone_type]
    if not sprite_path then
        error("[ERROR-DRONE] Invalid drone type: "..tostring(drone_type))
    end

    local sprite = love.graphics.newImage(sprite_path)

    local drone = {
        position = vector(x, y),
        velocity = vector(0, 0),
        target = nil,
        max_velocity = 10,
        friction = 0.995,
        sprite = sprite,
        width = sprite:getWidth(),
        height = sprite:getHeight(),
        drone_type = drone_type,
        selected = false
    }
    setmetatable(drone, self)
    self.__index = self
    return drone
end
```