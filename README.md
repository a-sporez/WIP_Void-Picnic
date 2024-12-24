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

- **`love.textinput()`**
  Registers text input

- **`love.mousepressed(x, y, button)`**:  
  Passes mouse press events to the current game state.

- **`love.keypressed(key)`**:  
  Passes key press events to the current game state.

---