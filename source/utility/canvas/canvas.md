# Canvas

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