# States

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