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
 
 For this project the main concern was elevating the UI to a more polished state. This still included a lot of new learning: such as drawing and importing images and dealing with creating sounds from scratch( I have some expereicne in this). 
 The process was pretty smooth at first with the creation of the pixel art, and a little rockier once it came to the integration. My biggest annoyance was probably getting the formating of the images and making the sounds feel dynamic enough 
 while still being really simple. My biggest triumph is my lack of big bugs. Now that I have experience with lua I would like to make a 3D game with it or something a little more ambitious. 