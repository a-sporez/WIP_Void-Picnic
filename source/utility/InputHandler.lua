Input = {}
Input.__index = Input

function Input:new(default_bindings)
    local instance = {
        keyStates = {},
        bindings = default_bindings or {
            pan_up = 'up',
            pan_down = 'down',
            pan_left = 'left',
            pan_right = 'right',
            forward = 'w',
            backward = 's',
            left_rot = 'a',
            right_rot = 'd',
            zoom_in = 'pageup',
            zoom_out = 'pagedown'
        },
    }
    setmetatable(instance, Input)
    return instance
end

-- bind key to an action
function Input:bind(action, key)
    self.bindings[action] = key
end

-- track keys when pressed
function Input:keypressed(key)
    self.keyStates[key] = true
end

-- stop tracking keys when released
function Input:keyreleased(key)
    self.keyStates[key] = nil
end

-- check if an action is active.
function Input:continuous(action)
    local key = self.bindings[action]
    return key and love.keyboard.isDown(key)
end

-- check if pressed once
function Input:once(action)
    local key = self.bindings[action]
    return key and self.keyStates[key] == true
end

-- clear the one time triggers at the end of the frame
function Input:clear()
    for key in pairs(self.keyStates) do
        self.keyStates[key] = nil
    end
end

return Input