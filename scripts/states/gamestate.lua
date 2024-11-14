local GameState = {}
local currentState = nil

function GameState:switch(state)
    if state then  -- add this condition
        if self.currentState and self.currentState.leave then
            self.currentState:leave()
        end
        self.currentState = state
        if self.currentState.enter then
            self.currentState:enter()
        end
    end
end

function GameState.update(dt)
    if GameState.currentState and GameState.currentState.update then
        GameState.currentState:update(dt)
    end
end

function GameState.draw()
    if GameState.currentState and GameState.currentState.draw then
        GameState.currentState:draw()
    end
end

return GameState