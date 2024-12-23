# Void-Picnic

Salvage and engineering in the void.

Now this is definitely the furthest I have made it into a prototype, of course I have used a coding assistant but I am satisfied with my control over the flow, up until now. And so I thought it was probably about time I write stuff in the readme.

## Modules

Source code:

- [Source Code](source/source.md)
  - [utility](source/utility/utility.md)
    - [canvas](source/utility/canvas/canvas.md)
    - [ui](source/utility/ui/ui.md)
  - [states](source/states/states.md)
  - [scenes](source/scenes/scenes.md)
    - [world](source/scenes/world/world.md)
  - [entities](source/entities/entities.md)
    - [asteroids](source/entities/asteroids/asteroids.md)
    - [drones](source/entities/drones/drones.md)
    - [vessels](source/entities/vessels/vessels.md)

- [Assets](assets/assets.md)
  - [asteroids](assets/sprites/asteroids/asteroids.md)
  - [drones](assets/sprites/drones/drones.md)
  - [hardpoints](assets/sprites/hardpoints/hardpoints.md)
  - [modules](assets/sprites/modules/modules.md)
  - [motherships](assets/sprites/motherships/motherships.md)

---

### **Main**
Handles the initialization and connection of game states.

- **`love.load()`**:  
  Sets up the game by enabling key repeat and switching to the `Menu` state.
  
- **`love.update(dt)`**:  
  Updates the current game state.

- **`love.draw()`**:  
  Renders the current game state.

- **`love.mousepressed(x, y, button)`**:  
  Passes mouse press events to the current game state.

- **`love.keypressed(key)`**:  
  Passes key press events to the current game state.

---

## States

### **GameState**
Manages state transitions and delegates updates and rendering to the active state.

- **`GameState:switch(state)`**:  
  Transitions to a new state, calling `leave` on the current state and `enter` on the new one.

- **`GameState:enableRunning()`**:  
  Switches to the `Running` state.

- **`GameState:enableMenu()`**:  
  Switches to the `Menu` state.

- **`GameState:update(dt)`**:  
  Updates the current state.

- **`GameState:draw()`**:  
  Renders the current state.

- **`GameState:mousepressed(x, y, button)`**:  
  Passes mouse press events to the current state.

- **`GameState:keypressed(key)`**:  
  Passes key press events to the current state.

---

### **Menu**
The initial game state, presenting the main menu with interactive buttons.

- **`Menu:enter()`**:  
  Initializes the menu by setting the font and creating "PLAY" and "EXIT" buttons.

- **`Menu:update(dt)`**:  
  Updates the menu state (currently unused).

- **`Menu:draw()`**:  
  Draws the menu text and buttons.

- **`Menu:mousepressed(x, y, button)`**:  
  Handles mouse input to trigger button actions ("PLAY" or "EXIT").

---

### **Running**
The game’s main gameplay state, managing the world, player ship, and interface.

- **`Running:enter()`**:  
  Initializes the game state:
  - Creates and switches to initial worlds (`Void` and `Nebula`).
  - Sets up the `CanvasMonitor`, `Camera`, and player ship (`Surveyor`).
  - Adds the player ship to the current world.

- **`Running:update(dt)`**:  
  Updates the active world, player ship, camera focus, and canvas monitor.

- **`Running:draw()`**:  
  Draws the game state:
  - Renders the world and player ship within the camera's view.
  - Displays the interface.

- **`Running:keypressed(key)`**: Handles keyboard input to switch worlds or move the camera.

- **`Running:mousepressed(x, y, button)`**: Passes mouse press events to the interface module.

---

## Utility

### **Canvas**
Manages a drawable surface for rendering visual elements.

  - `Canvas:new(width, height, currentWorld)`: Creates a new canvas.

  - `Canvas:start()` / `Canvas:stop()`: Begin/end drawing on the canvas. 

  - `Canvas:draw(scaleX, scaleY)`: Renders the canvas to the screen, optionally scaled.  

---

### **canvasInterface**
Specialized `Canvas` for rendering UI elements like buttons.  

  - `canvasInterface:create(width, height)`: Creates a canvas for UI.  

---

### **canvasMonitor**
Specialized `Canvas` for rendering game worlds dynamically.  

  - `canvasMonitor:create(width, height, currentWorld)`: Initializes a world canvas.  

  - `canvasMonitor:setWorld(world)`: Updates the world being rendered.  

  - `canvasMonitor:render()`: Draws the current world onto the canvas.  

---

### **Camera**
Handles smooth panning, zooming, and viewport transformations using `HUMP.camera`.  

  - `Camera:init(x, y)`: Initializes the camera at a position.  

  - `Camera:update(targetX, targetY)`: Smoothly pans to a target position.  

  - `Camera:move(dx, dy)`: Moves the camera by a delta.  

  - `Camera:setZoom(zoomLevel)` / `Camera:adjustZoom(delta)`: Controls zoom.  

  - `Camera:attach()` / `Camera:detach()`: Applies or removes the camera’s transformations.  

---

### **Interface**
Manages user interface elements like buttons and handles interactions.  

  - `Interface.new()`: Creates an interface with default buttons (e.g., `menuButton`).  

  - `Interface:draw()`: Draws all UI elements to the screen.  

  - `Interface:mousepressed(x, y, button)`: Handles button click interactions.  

---

### **Button**
Represents a clickable UI button with visual and functional properties.  

  - `Button.new(x, y, width, height, text, func, func_param, sprite_path)`: Creates a new button.  

  - `Button:checkPressed(mouse_x, mouse_y, cursor_radius)`: Triggers the button’s action if clicked.  

  - `Button:draw(button_x, button_y, text_x, text_y)`: Renders the button.  

---

### **Console**
Central hub for in-game executable functions for testing and also gameplay... eventually.

  - `function Console:new()`: Initializes the console

  - `function Console:addAlias(aliasName, command)`: adds a user defined alias to the list of aliases.

  - `function Console:listAliases()`: prints a list of stored aliases in the console.

  - `function Console:processSingleCommand(command)`: This is the console output point and where individual commands are processed.

  - `function Console:processCommand(command)`: Function that processes the total output of commands in order, split by a semi;colon

  - `function Console:textinput(key)`: receives text input for processing.

  - `function Console:keypressed(key)`: receives other type of keyboard input for processing.

  - `function Console:draw()`: Contains all of the logic for drawing and placement of the terminal.

  ---

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

#### *Worlds*

  * Void
  
  * Nebula