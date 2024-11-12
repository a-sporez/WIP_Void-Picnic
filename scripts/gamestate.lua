local GameState = {}
local currentState = nil

function GameState.switch(state)
    if currentState and currentState.leave then
        currentState:leave()
    end
    currentState = state
    if currentState.enter then
        currentState:enter()
    end
end

function GameState.update(dt)
    if currentState and currentState.update then
        currentState:update(dt)
    end
end

function GameState.draw()
    if currentState and currentState.draw then
        currentState:draw()
    end
end

return GameState