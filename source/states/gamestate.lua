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

function GameState:enableRunning()
    self:switch(require('source.states.running'))
end

function GameState:enableMenu()
    self:switch(require('source.states.menu'))
end

function GameState:update(dt)
    if self.currentState and self.currentState.update then
        self.currentState:update(dt)
    end
end

function GameState:draw()
    if self.currentState and self.currentState.draw then
        self.currentState:draw()
    end
end

function GameState:mousepressed(x, y, button)
    if self.currentState and self.currentState.mousepressed then
        self.currentState:mousepressed(x, y, button)
    end
end

function GameState:keypressed(key)
    if self.currentState and self.currentState.keypressed then
        self.currentState:keypressed(key)
    end
end

return GameState