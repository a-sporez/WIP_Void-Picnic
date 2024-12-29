# Canvas

### **Canvas**
Manages a drawable surface for rendering visual elements.

  - `Canvas:new(width, height, currentWorld)`: Creates a new canvas.

  - `Canvas:start()` / `Canvas:stop()`: Begin/end drawing on the canvas.

  - `Canvas:draw(scaleX, scaleY)`: Renders the canvas to the screen, optionally scaled.  

---

### **Interface**
Specialized `Canvas` for rendering UI elements like buttons.  

  - `canvasInterface:create(width, height)`: Interface is where the main logic of the UI is being handled.

  example of button instantiation:

  ```lua
  self.buttons = {}
    -- this is the method to add new buttons
    self.menuButton = Button.new(
        window_width - offset_x - 426,
        window_height - offset_y,
        self.width,
        self.height,
        "MENU",
        function() GameState:enableMenu() end,
        nil,
        'assets/sprites/button_1.png'
    )
    table.insert(self.buttons, self.menuButton)
  ```

---

### **canvasMonitor**
Specialized `Canvas` for rendering game worlds dynamically.  

  - `canvasMonitor:create(width, height, currentWorld)`: Initializes a world canvas.  

  - `canvasMonitor:setWorld(world)`: Updates the world being rendered.  

  - `canvasMonitor:render()`: Draws the current world onto the canvas.