inspect = require("inspect")
require("board")
require("card")
require("player")

io.stdout:setvbuf('no')
math.randomseed(os.time())
-- Game macros
VICTORY_POINTS = 20  -- Changed to 20 as per your request
ROUND = 0

-- Button configuration
local end_turn_button = {
    x = 600,
    y = 500,
    width = 120,
    height = 40,
    text = "End Turn",
    font = nil,
    hovered = false
}

-- Restart button configuration
local restart_button = {
    x = 350,
    y = 350,
    width = 150,
    height = 50,
    text = "Restart Game",
    font = nil,
    hovered = false
}

-- Game state variables
local winner = nil

-- Loading----------------------------------------------
function love.load()
    love.window.setTitle("Mythology wars")
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0, 0.7, 0.2, 1)
    
    -- Create fonts for buttons
    end_turn_button.font = love.graphics.newFont(16)
    restart_button.font = love.graphics.newFont(18)
    
    initialize_game()
end

-- Function to initialize/reset the game
function initialize_game()
    board = Board:constructor()
    board:initialize()
    board:update_position()
    board.state = "staging"
    ROUND = 0
    winner = nil
end

dtotal = 0
-- Main Game Loop --------------------------------------
function love.update(dt)
    -- Update button hover states
    local mx, my = love.mouse.getPosition()
    end_turn_button.hovered = is_point_in_button(mx, my, end_turn_button)
    restart_button.hovered = is_point_in_button(mx, my, restart_button)
    
    -- Check for win condition
    if board.state ~= "win" then
        check_win_condition()
    end
    
    if board.state == "staging" then
        board:staging(ROUND)
    elseif board.state == "opponent_turn" then
        board:opponent_turn()
    elseif board.state == "reveal" then 
        dtotal = dtotal + dt   -- we add the time passed since the last update, probably a very small number like 0.01
            if dtotal >= 1 then
                dtotal = dtotal - 1   -- reduce our timer by a second, but don't discard the change... what if our framerate is 2/3 of a second?
                result = board:reveal()
                if result == "done" then 
                    board.state = "endturn"
                    board:endturn()
                    ROUND = ROUND + 1
                end
            end
    elseif board.state == "win" then
        -- Win state - waiting for restart
    end
end

-- Function to check win condition
function check_win_condition()
    if board.players[1].score >= VICTORY_POINTS then
        winner = "Player"
        board.state = "win"
    elseif board.players[2].score >= VICTORY_POINTS then
        winner = "Opponent"
        board.state = "win"
    end
end

-- Graphics---------------------------------------------
function love.draw()
    if board.state == "win" then
        draw_win_screen()
    else
        draw_game_screen()
    end
end

-- Draw the main game screen
function draw_game_screen()
    love.graphics.setColor(1,1,1)
    love.graphics.print("I am: " .. board.state, 10, 6-0)
    love.graphics.print("Player score: " .. board.players[1].score, 10, 500)
    love.graphics.print("Opponents score: " .. board.players[2].score, 10, 510)
    love.graphics.print("Round: " .. ROUND, 10, 520)
    love.graphics.print("Player mana: " .. board.players[1].mana, 10, 530)
    love.graphics.print("Opp mana: " .. board.players[2].mana, 10, 540)
    love.graphics.print("When stage is End Round-- press SPACE to enter staging", 10, 550)
    
    board.players[1].hand:draw()
    board.players[2].hand:draw()
    board.players[1].discard_pile:draw()
    board.players[2].discard_pile:draw()
    board.dek:draw()
    board.dek2:draw()
    for i=1, 3 do
        board.players[1].locations[i]:draw()
        board.players[2].locations[i]:draw()
    end
    
    -- Draw the End Turn button (only during staging state)
    if board.state == "staging" then
        draw_button(end_turn_button)
    end
end

-- Draw the win screen
function draw_win_screen()
    -- Draw semi-transparent overlay
    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    
    -- Draw win message
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(restart_button.font)
    
    local win_text = winner .. " Wins!"
    local final_score_text = "Final Score - Player: " .. board.players[1].score .. "  Opponent: " .. board.players[2].score
    local rounds_text = "Game lasted " .. ROUND .. " rounds"
    
    -- Center the text
    local win_text_width = restart_button.font:getWidth(win_text)
    local score_text_width = restart_button.font:getWidth(final_score_text)
    local rounds_text_width = restart_button.font:getWidth(rounds_text)
    
    local screen_width = love.graphics.getWidth()
    
    -- Draw win message
    love.graphics.setColor(1, 1, 0, 1) -- Yellow for win text
    love.graphics.print(win_text, (screen_width - win_text_width) / 2, 200)
    
    -- Draw score
    love.graphics.setColor(1, 1, 1, 1) -- White for other text
    love.graphics.print(final_score_text, (screen_width - score_text_width) / 2, 250)
    love.graphics.print(rounds_text, (screen_width - rounds_text_width) / 2, 280)
    
    -- Draw restart button
    draw_button(restart_button)
end

-- Button drawing function
function draw_button(button)
    -- Set button color based on hover state
    if button.hovered then
        love.graphics.setColor(0.8, 0.8, 1, 1) -- Light blue when hovered
    else
        love.graphics.setColor(0.6, 0.6, 0.9, 1) -- Default blue
    end
    
    -- Draw button background
    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
    
    -- Draw button border
    love.graphics.setColor(0.2, 0.2, 0.3, 1)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", button.x, button.y, button.width, button.height)
    
    -- Draw button text
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(button.font)
    local text_width = button.font:getWidth(button.text)
    local text_height = button.font:getHeight()
    local text_x = button.x + (button.width - text_width) / 2
    local text_y = button.y + (button.height - text_height) / 2
    love.graphics.print(button.text, text_x, text_y)
end

-- Helper function to check if point is inside button
function is_point_in_button(x, y, button)
    return x >= button.x and x <= button.x + button.width and
           y >= button.y and y <= button.y + button.height
end

--Mouse Events------------------------------------------
-- Grabber table
grabber = {
    dragging = false,
    active_card = nil,
    location = nil,
    card_index = nil
}

-- Attempt picking up card
function love.mousepressed(x, y, button)
    if button == 1 then -- left click
        -- Check if restart button was clicked during win state
        if board.state == "win" and is_point_in_button(x, y, restart_button) then
            initialize_game()
            return
        end
        
        -- Check if End Turn button was clicked during staging
        if board.state == "staging" and is_point_in_button(x, y, end_turn_button) then
            board.state = 'opponent_turn'
            return
        end
        
        -- Original card dragging logic
        if board.state == "staging" then
            print("attempt_dragging_card()")
            -- Find card that is clicked
            local card, card_index = board.players[1].hand:find_card(x, y)
            -- If card was clicked
            if card ~= nil then
            -- If card was clicked then start dragging
                grabber.active_card = card
                grabber.card_index = card_index
                grabber.dragging = true
                -- Set offset of activecard
                grabber.active_card:set_offset(x,y)  
            end
        end
    end
end

-- Dragging card
function love.mousemoved(x,y,dx,dy)
    if grabber.dragging then
        grabber.active_card:drag_move(x,y)
    end
end

-- Attempt releasing card
function love.mousereleased(x, y, button)
    if button == 1 and board.state == "staging" then -- left click
        -- If had valid card selected check destination and move
        if grabber.active_card ~= nil then 
            check_move(grabber)
        end
        -- Refresh display of cards
        board:update_position()
        board:staging_display()

        -- Reset selector
        grabber.dragging = false
        grabber.active_card = nil
        grabber.card_index = nil
    end
end

-- Keep spacebar as backup, but main interaction is now the button
function love.keypressed(key)
    if key == "space" and board.state == 'staging' 
    then board.state ='opponent_turn'
    elseif key == "space" and board.state == 'endround' 
    then board.state = 'staging'
    elseif key == "r" and board.state == 'win'
    then initialize_game() -- Added keyboard shortcut for restart
    end
end

--------------------------------------------------------
function check_move(grabber)
    local moving_buffer = {}
    for i=1, LOCATIONS do
        bounds = board.players[1].locations[i]:get_cap()
        if bounds:isOverlapping(grabber.active_card) then
            print("Overlap")
            if #board.players[1].locations[i].card_stack >= 4 then
                return false
            end
            if not card_rules(grabber.active_card, grabber.card_index) then 
                return false
            else
                board.players[1].hand:remove(grabber.card_index,"single")
                board.players[1].locations[i]:insert(grabber.active_card)
                table.insert(board.player_order_buffer, grabber.active_card) 
                grabber.active_card.location = i
                return true
            end
        end
            -- Not in correct area
    end
    return false
end

function card_rules()
    if grabber.active_card.cost > board.players[1].mana then 
        return false
    elseif  board.players[1].mana >= grabber.active_card.cost then
        board.players[1].mana = board.players[1].mana - grabber.active_card.cost
        return true
    end
end

-- STAGING
-- Mana increases incrementally
-- Players move cards to locations (3 locs with 4 slots)
-- AI also moves cards

-- REVEAL
-- Reveal opponent cards

-- END OF TURN
-- Per location, the player with more total power earns points 
-- Based on the difference in power.
-- Update points

-- CHECK WINNING CONDITIONS
-- Check if points > N