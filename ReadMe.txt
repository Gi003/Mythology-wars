# Mythology Wars - Card Game

## Programming Patterns Used

 State Pattern

**Implementation**: The game uses states like "staging", "opponent_turn", "reveal", "endturn", and "win".
I used this because the state allows appropriate actions to happen in each phase, preventing invalid game states.

 Command Pattern 

Card abilities are handled through a centralized `card:act()` method that executes different effects based on card type. 
I used it because it allows for  card effects without modifying core game logic. Each card can have unique abilities while having consistent execution.

Event Queue

The cards are added to an event queue in order to be revealed in the same order they were placed.

## Feedback

 Person 1: Kenshin Chao

 Suggested implementing a state machine to handle game phases. I replaced scattered  state variables with one `board.state` string that controls game flow through the main update loop.

 Person 2: Phinhas 

Was happy with the game but didnt think the balancing of mana and power was fair. I therefore recalculated the mana and power and made the AI not care about cost in order to give more difficulty in winning

 Person 3: Marcus Ochoa

Suggested improving the card dragging system by showing its drag and suggested displaying the text of cards only when dragged . 
I added visual feedback by showing card text during dragging.

### Person 4: Cal Friedman

Suggested for me to change the delay for when cards get revealed, 
I added a bigger delay

 Project Postmortem

 What Went Well

- Clean State Management: The state pattern worked well for managing game phases and preventing invalid actions.
- **Modular Design**: Separating  Board, Card, Stack, and Player classes made the code easier to debug.

### What Could Be Improved

All of my assets (sound, and visuals) where made by me

Some of the modifications I made in this version were:
1. I switched to another color theme. 
2. Made turn taking more intuitive with better UI 
3. Added images and sound.
 ----------------
For this project, my main focus was improving the UI to a more polished, engaging game. Even though that might sound like a straightforward goal, I ended up learning a lot. I had to figure out how to draw and import custom pixel art, as well as create sounds from scratch(something I had some experience in but hadn’t done in a game making context in lua). Balancing aesthetics with technical implementation was more complex than I expected.
The process started out relatively smooth. Creating the pixel art was enjoyable and familiar territory, and I was able to get into a good rhythm during that stage. Things got a little rockier once it came time to integrate the assets. The formatting of the images—making sure they were scaled correctly, transparent where they needed to be, and properly placed, turned out to be frustrating. A big issue I had was the order of loading in the images and displaying them had to be intentional and specific in the .load function. The sound design also proved more difficult than I thought, mostly because I wanted the effects to feel dynamic and intentional without overwhelming the simplicity of the project. In the end the project might have gotten a bit bulkier due to these implementations. This hurdle might have com from underestimating how much time it takes to give something an aesthetic
Compared to previous projects I’ve worked on( js games using phaser and three.js) this one felt more focused on polish rather than raw functionality. I think that’s what made it both rewarding and occasionally tiresome. In game jams, I’m often rushing just to get things working, so it was interesting to slow down and think more about presentation and player experience.
The biggest triumph of this project was that, surprisingly, I didn’t run into any major bugs. That’s not something I take for granted, especially since I was working in Lua, which I only recently became comfortable with. That lack of setbacks let me focus more on the design and aesthetics, which I really enjoyed.
On the other hand, the biggest annoyance was definitely asset integration. It was a lot of trial and error to get things looking and sounding the way I wanted. If I were to do this project again, I’d build in more time for asset testing and maybe find or build better tools for visual preview and sound debugging.
Having now worked with Lua and gotten more confident in integrating multimedia elements, I would actually be interested in doing something more ambitious with it, maybe even a simple 3D card project or expanding this card game on to a board. There’s definitely more room to grow. This means I would like to work on something like this because I feel like I got over the initial learning curve
A funny bug story: at one point I accidentally had a sound effect loop infinitely because I forgot to stop its state. It wasn’t immediately obvious what was happening, so for a while I thought I’d broken something much bigger. It turned out to be a single line of code.
Overall, I think this project taught me that polish can be just as challenging and rewarding as core functionality. It’s a different mindset, but one I want to get better at.

