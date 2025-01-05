# Void-Picnic

Salvage and engineering in the void. I have chosen this title and theme for the game as a tribute to the book Roadside Picnic by Arkady & Boris Strugatsky and the film director Andrei Tarkovsky.

**Spaceships, logistics-based wargaming, electronic warfare, information warfare, religious (and other) nutjobs, engineering (geology and refining, invention-research, manufacturing) vector geometry, deltaV calculation, , drones, FUKKEN-MECHAS-N-CARRIERZ-N-SHIT-ZERS, crew protraits with all sorts of personality and gender profiles, text based conversation arcs, space anomalies, asteroids... and rare but cruel and nerve wrenching combat encounters**

The story so far...

The era is somewhere around 250 years from now, well I guess that depends entirely on whose faction you were employed by before... humanity has exerted some form of control over the solar system and left it's mark on the most notable bodies, there are no space nations, i dont think 250 years is enough time for humanity to develop a 'space-faring' culture no matter how much our eras techbros would like to brag about being able to do it. We are simply not meant to exist in the vacuum, yet we cannot survive by remaining on our little planet. This is a very core part of the story I want the whole atmosphere of 'you are not meant to be here' vibe, i want to make the context of what it means to be a human within a society of human thought provoking, albeit not to an uncomfortable extent... It is a game after all!

Overall story theme is about a small crew on a spaceship, a surplus spaceship... with some part rigged here and there to hold the bulkheads to gether when the torchdrive is active, and they are simply surviving the aftermath of an event that cut off the outer planets (beyond the mars belt) from planet earth. They are exceptionally bonded together and while none of them share any family ties, they have lived in the same ship together for almost their entire lives, they love each other beyond any concepts of romance that can be explained in simple normative ways. They are about launched in the middle of a very unfortunate series of events that will define how their stories unfold.

-Design note: I am planning a cast of 5 to 6 central characters, but each module that has any functionality within a ship, structure, or any of the drones/mechas it carries

It is referred to as Void, simply because nobody knows anything about it, contact was lost with Sol's 'golden zone' planets Mars, Earth, and Venus. All ships heading within a certain distance of mars are never heard from again, all ship that were heading out reported to the home port. Turning telecopes towards the inner solar system to see what is happening would seem simple but every single corporation that could look at earth either lied outrageously about it or reported completely absurd data about the redshift of the photons they manage to print. To make matters worse, there is a field effect of some kind that makes it so any instrument that captures photons at any length of the electromagnetic spectrum suffer decades worth of tear, for no reason than any of the corporation that maintain those facilities can agree on.

It is a time of confusion and uncertainty, none of the the outer systems have developed healthy societies and barely managed to maintain some resemblance of moral ethics in their many indsutrial facilities to various degrees.

## Modules

TODO: Unified entity management module
All modules are complete and currently undergoing many refactoring for me to extend modularity as I increase the amount of boilerplate. I am a noice programmer meaning I am likely to create code that is much too verbose and then simplify methods as I learn to connect the modules in a solid way that maximizes performance over rendering quality.

The prototype is a framework in Löve2D Lua that acts as a foundation for the overall project. My intent is to create a modular sandbox RTS within procedurally generated maps that progress in complexity between sessions. I am planning for a central gameplay hub, like a hideout of sorts similar to FPS/RPG hybrids. From this central planning hub each session can be prepared by allocating resources, ships and crews to a deployment area.
Inspirations for the planning phase are 

I understand the concept of scoping in video game design therefore I felt it would be better to limit the scope to 2 dimensiona handmade sprites in order to focus on the code structuring.

Source code:

I have imported the HUMP library for vectors module and camera module, LICK is in the lib folder but not implemented yet. LICK will allow me to hot reload the framework, meaning on top of running the test console from VS Code with alt+L the script will automatically update each frame to fit with each ctrl+s, so I can update on the variable while the game is running. I think I am about hallfway through this process althought Dunning-Kruger is very much to be considered here so this is an estimate.


This is the file structure map made with markdown links pre-placed for me to keep better track of version control.

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
