require("Stack")
require("card_abilities")
-- Macros
MAX_HAND_SIZE = 7
DECK_SIZE = 20
STARTING_HAND = 3
LOCATIONS = 3
SLOTS_PER_LOCATION = 4

-- BOARD CLASS ---------------------------------------
Board = {}
Board.__index = Board

function Board:constructor()
    local self = {}
    setmetatable(self, Board)
    self.players = {{},{}}
    self.state = ""                 -- staging, revealing, scoring, gameOver
    self.currentTurn = 1            -- 1 = player, 2 = opponent
    self.revealDuration = 0.5
    self.winner = math.random(2)              -- who reveals first
    self.player_order_buffer = {}
    self.opp_order_buffer = {}
    self.round = 0
    
    -- Create deck display cards (face down representations)
    self.dek = Card:constructor("Deck", 0, 0, "")
    self.dek:change_state("closed")  -- Face down
    self.dek.x = 50   -- Position for player 1 deck
    self.dek.y = 25
    
    self.dek2 = Card:constructor("Deck", 0, 0, "")
    self.dek2:change_state("closed")  -- Face down
    self.dek2.x = 50   -- Position for player 2 deck
    self.dek2.y = 400
    
    return self
end

function Board:initialize()
    -- Generate player decks
    for p = 1, 2 do
        self.players[p].deck = {}
        self.players[p].score = 0
        self.players[p].mana = 0
        self.players[p].locations = {}
        if p == 1 then
         self.players[1].hand = Stack:constructor(150, 25, "spread", "hand")
         self.players[1].discard_pile = Stack:constructor(550, 25, "overlap", "discard")
        else
             self.players[2].hand = Stack:constructor(150, 400, "spread", "hand")
             self.players[2].discard_pile = Stack:constructor(550, 400, "overlap", "discard")
        end
        for i=1, LOCATIONS do
            self.players[p].locations[i] = Stack:constructor(200*i - 75 ,150*p, "spread", "location")
        end

        -- Fill deck with random cards
        create_cards()
        for i = 1, DECK_SIZE do
            local cardIndex = math.random(#allcards)
            local card = table.remove(allcards, cardIndex)
            table.insert(self.players[p].deck, card)
        end
    end

    -- Draw starting hand
        for i = 1, STARTING_HAND do
        if #self.players[1].deck > 0 then
            local card = table.remove(self.players[1].deck, 1)
            self.players[1].hand:insert(card)
            local card = table.remove(self.players[2].deck, 1)
            self.players[2].hand:insert(card)
        end

    self.players[1].hand:open_cards()
    self.players[2].hand:open_cards()
    end
    
    -- Update deck display visibility
    self:update_deck_display()
end

function Board:update_deck_display()
    -- Hide deck display cards when deck is empty
    if #self.players[1].deck == 0 then
        self.dek.visible = false
    else
        self.dek.visible = true
    end
    
    if #self.players[2].deck == 0 then
        self.dek2.visible = false
    else
        self.dek2.visible = true
    end
end

function Board:staging(round)
    if self.round == round then
        if #self.players[1].deck > 0 and #self.players[1].hand.card_stack < 7 then
            local card = table.remove(self.players[1].deck, 1)
            self.players[1].hand:insert(card)
            board:update_position()
            self.players[1].hand:open_cards()
        end
        if #self.players[2].deck > 0 and #self.players[2].hand.card_stack < 7 then
            local card = table.remove(self.players[2].deck, 1)
            self.players[2].hand:insert(card)
            board:update_position()
            self.players[2].hand:close_cards()
        end
        self.round = self.round + 1
        self.players[1].mana = self.players[1].mana + self.round
        self.players[2].mana = self.players[2].mana + self.round
        
        -- Update deck display after drawing cards
        self:update_deck_display()
    end
    self.state = "staging"
end

function Board:opponent_turn()
    self.state = "opponent_turn"
    for i, c in ipairs(self.player_order_buffer) do
        c:change_state("closed")
    end
    -- Place ai 
    local location = math.random(3)
    while #self.players[2].locations[location].card_stack >= 4 do
        local location = math.random(3)
    end 
    local cardIndex = math.random(#self.players[2].hand.card_stack)
    local card = self.players[2].hand:remove(cardIndex, "single")
    card:change_state("closed")
    card.location = location
    table.insert(self.opp_order_buffer,card)
    self.players[2].locations[location]:insert(card)
    -- Reveal Cards
    board:update_position()
    self.state = "reveal"
end

function Board:reveal()
    local card = nil
    if self.winner == 2 then
        if #self.opp_order_buffer ~= 0 then
            card = table.remove(self.opp_order_buffer, 1)
            card:change_state("idle")
            card:act(1)
            return "not done"
        elseif #self.player_order_buffer ~= 0 then
            card = table.remove(self.player_order_buffer, 1)
            card:change_state("idle")
            card:act(2)
            return "not done"
        end
        return "done"
    elseif self.winner == 1 then
        if #self.player_order_buffer ~= 0 then
            card = table.remove(self.player_order_buffer, 1)
            card:change_state("idle")
            card:act(2)
            return "not done"
        elseif #self.opp_order_buffer ~= 0 then
            card = table.remove(self.opp_order_buffer, 1)
            card:change_state("idle")
            card:act(1)
            return "not done"
        end 
        return "done"
    end
end


function Board:endturn()
    print("endturn")
    for loc = 1, LOCATIONS do
        local p1_total = 0
        local p2_total = 0

        -- Sum power for player 1
        local power = self.players[1].locations[loc]:total_power()
            p1_total = p1_total + power

        -- Sum power for player 2
        local power = self.players[2].locations[loc]:total_power()
            p2_total = p2_total + power
        
        -- Award points
        if p1_total > p2_total then
            local diff = p1_total - p2_total
            self.players[1].score = self.players[1].score + diff
            self.winner = 1
        elseif p2_total > p1_total then
            local diff = p2_total - p1_total
            self.players[2].score = self.players[2].score + diff
            self.winner = 2
        else
            self.winner = math.random(2)
        end
    end
    board.state = "endround"
end


function Board:update_position()
    self.players[1].hand:update_position()
    self.players[2].hand:update_position()
    self.players[1].discard_pile:update_position()
    self.players[2].discard_pile:update_position()
    for i=1, LOCATIONS do
        self.players[1].locations[i]:update_position()
        self.players[2].locations[i]:update_position()
    end
end

function Board:staging_display()
end