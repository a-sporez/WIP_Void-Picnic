# World

World scenes are handled independently from the canvas, the handler switches the scenes and handles the base method for all worlds, entities simply need to be added to the table once instantiated.

## Scenes

### **worldHandler**
Manages tables where game worlds are going to be stored and handles switching between them.

  - `function worldHandler:new()`: Initialize the module

  - `function worldHandler:addWorld(name, world_instance)`: helper function to add worlds to the handler's table.

  - `function worldHandler:switch(name)`: triggers the individual world initialization and stores the current world in the table.

  - `function worldHandler:update(dt)`: pass the callback to current world.

  - `function worldHandler:draw()`: pass the callback to the current world.

---

### **World**
Base class for worlds where the game elements are instantiated and interacted with by the player.

  - `function World:new()`: creates new world with basic stattic parameters and stores entities in a table.

  - `function World:addEntity(entity)`: table insert for entities instantiated in the individual world.

  - `function World:update(dt)`: pass the callback to the current world. Dynamically update entities within the world.

  - `function World:drawGrid(cellSize)`: create a 100x100 grid to help visualize movement during development.

  - `function World:draw()`: draws entities defined in the current world and the nav grid.

---