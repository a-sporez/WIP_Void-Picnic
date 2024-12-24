# Utility

[canvas](canvas/canvas.md)

[ui](ui/ui.md)

---

### **Camera**
Handles smooth panning, zooming, and viewport transformations using `HUMP.camera`.  

  -`Camera:init(x, y)`: Initializes the camera at a position.  

  -`Camera:update(targetX, targetY)`: Smoothly pans to a target position.  

  -`Camera:move(dx, dy)`: Moves the camera by a delta.  

  -`Camera:setZoom(zoomLevel)` / `Camera:adjustZoom(delta)`: Controls zoom.  

  -`Camera:attach()` / `Camera:detach()`: Applies or removes the camera’s transformations.

  ---

### **Console**
Central hub for in-game executable functions for testing and also gameplay... eventually.

  -`function Console:new()`: Initializes the console

  -`function Console:addAlias(aliasName, command)`: adds a user defined alias to the list of aliases.

  -`function Console:listAliases()`: prints a list of stored aliases in the console.

  -`function Console:processSingleCommand(command)`: This is the console output point and where individual commands are processed.

  -`function Console:processCommand(command)`: Function that processes the total output of commands in order, split by a semi;colon

  -`function Console:textinput(key)`: receives text input for processing.

  -`function Console:keypressed(key)`: receives other type of keyboard input for processing.

  -`function Console:draw()`: Contains all of the logic for drawing and placement of the terminal.

  