-- require("card")


-- allcards  = {}

-- function create_cards()
--     for i = 1, 2 do 
--         card = Card:constructor("Wood Cow", 1, 1, "Vanilla")
--         card.img = love.graphics.newImage("img/wood.png")
--         table.insert(allcards,card)
--          card = Card:constructor("Pegasus", 2, 5, "Vanilla")
--          card.img = love.graphics.newImage("img/Pegasus.png")
--         table.insert(allcards,card)
--          card = Card:constructor("Minotaur", 4, 9, "Vanilla")
--          card.img = love.graphics.newImage("img/Minotaur.png")
--         table.insert(allcards,card)
--          card = Card:constructor("Titan", 5, 12, "Vanilla")
--          card.img = love.graphics.newImage("img/Titan.png")
--         table.insert(allcards,card)

--         card = Card:constructor("Zeus", 2, 6, "Lower the power of each card in your opponent's hand by 1.")
--         card.ability = function(self, opponent) 
--             for i,opp_card in ipairs(board.players[opponent].hand.card_stack) do
--                 print("Zeuses hand")
--                 opp_card:change_power(-1)
--                 if opp_card.power == 0 then
--                 local dead = board.players[opponent].hand:remove(i, "single")
--                 board.players[opponent].discard_pile:insert(dead)
--                 board:update_position()
--                 end
--             end
--         end 
--         card.img = love.graphics.newImage("img/Zeus.png")
--         table.insert(allcards,card)

--         card = Card:constructor("Ares", 5 , 8, "Gain +2 power for each enemy card here.")
--         card.ability = function(self, opponent) 
--             print("activated card turn")
--             local location = self.location
--             print(location)
--             for i, opp_card in ipairs(board.players[opponent].locations[location].card_stack) do
--                 print(inspect(board.players[opponent].locations[location].card_stack))
--                 print("detected card")
--                 self:change_power(2)
--             end
--         end 
--         card.img = love.graphics.newImage("img/Ares.png")
--         table.insert(allcards,card)


--         card = Card:constructor("Cyclops", 2, 4, "When Revealed: Discard your other cards here, gain +2 power for each discarded.")
--         card.ability = function(self, opponent) 
--             local player = 0
--             local location = self.location
--             if opponent == 1 then player = 2
--             elseif opponent == 2 then player = 1
--             end
--             for i,card in ipairs(board.players[player].locations[location].card_stack) do
--                 if card.name ~= "Cyclops" then
--                     print("Discarding card")
--                     local dead = board.players[player].locations[location]:remove(i, "single")
--                     board.players[player].discard_pile:insert(dead)
--                     self:change_power(2)
--                     board:update_position()
--                 end
--             end
--         end 
--         card.img = love.graphics.newImage("img/Cyclops.png")
--         table.insert(allcards,card)

--         card = Card:constructor("Artemis", 3, 5, "When Revealed: Gain +5 power if there is exactly one enemy card here.")
--         card.ability = function(self, opponent) 
--             local location = self.location
--             local player = 0
--             if opponent == 1 then player = 2
--             elseif opponent == 2 then player = 1
--             end
--             if #board.players[opponent].locations[location].card_stack == 1 then
--                 self:change_power(5)
--             end
--         end 
--         card.img = love.graphics.newImage("img/Artemis .png")
--         table.insert(allcards,card)

--         card = Card:constructor("Demeter", 2, 2, "When Revealed: Both players draw a card.")
--         card.ability = function(self, opponent) 
--             if #board.players[1].deck > 0 and #board.players[1].hand.card_stack < 7 then

--                 local c = table.remove(board.players[1].deck, 1)
--                 board.players[1].hand:insert(c)
--                 board:update_position()
--                 board.players[1].hand:open_cards()
--             end

--             if #board.players[2].deck > 0 and #board.players[2].hand.card_stack < 7 then
--                 local c = table.remove(board.players[2].deck, 1)
--                 board.players[2].hand:insert(c)
--                 board:update_position()
--                 board.players[2].hand:close_cards()
--             end
--         end 
--         card.img = love.graphics.newImage("img/Demeter (1).png")
--         table.insert(allcards,card)

--         card = Card:constructor("Hades", 1,1 , "When Revealed: Gain +2 power for each card in your discard pile.")
--         card.ability = function(self, opponent) 
--             local player = 0
--             if opponent == 1 then player = 2
--             elseif opponent == 2 then player = 1
--             end
--             local dead = #board.players[player].discard_pile.card_stack * 2
--             self:change_power(dead)
--         end 
--         card.img = love.graphics.newImage("img/Hades (1).png")
--         table.insert(allcards,card)

--         card = Card:constructor("Hercules", 3, 4, "When Revealed: Doubles its power if its the strongest card here.")
--         card.ability = function(self, opponent) 
--             local player = 0
--             local location = self.location
--             if opponent == 1 then player = 2
--             elseif opponent == 2 then player = 1
--             end
--             for i,card in ipairs(board.players[player].locations[location].card_stack) do
--                 if card.power >= self.power and card.name ~= self.name then 
--                     return
--                 end
--             end
            
--             for i,card in ipairs(board.players[opponent].locations[location].card_stack) do
--                 if card.power >= self.power and card.name ~= self.name then 
--                     return
--                 end
--             end
--             self:change_power(self.power)
--         end 
--         card.img = love.graphics.newImage("img/Hercules.png")
--         table.insert(allcards,card)

--         card = Card:constructor("Dionysus", 2, 1, "When Revealed: Gain +2 power for each of your other cards here.")
--         card.ability = function(self, opponent) 
--             local player = 0
--             local location = self.location
--             if opponent == 1 then player = 2
--             elseif opponent == 2 then player = 1
--             end
--             for i,card in ipairs(board.players[player].locations[location].card_stack) do
--                 if card ~= self then
--                 self:change_power(2)
--                 end
--             end
--         end 
--         table.insert(allcards,card)

--         card = Card:constructor("Midas", 2, 3, "When Revealed: Set ALL cards here to 3 power.")
--         card.ability = function(self, opponent) 
--             local player = 0
--             local location = self.location
--             if opponent == 1 then player = 2
--             elseif opponent == 2 then player = 1
--             end
--             for i,card in ipairs(board.players[player].locations[location].card_stack) do
--                 if card ~= self then
--                     card.power = 3
--                 end
--             end
--             for i,card in ipairs(board.players[opponent].locations[location].card_stack) do
--                 card.power = 3
--             end
--         end 
--         card.img = love.graphics.newImage("img/Midas (1).png")
--         table.insert(allcards,card)

--         card = Card:constructor("Aphrodite", 3, 6, "When Revealed: Lower the power of each enemy card here by 1.")
--         card.ability = function(self, opponent) 
--             local location = self.location
--             for i,card in ipairs(board.players[opponent].locations[location].card_stack) do
--                 card:change_power(-1)
--             end
--         end
--         card.img= love.graphics.newImage("img/Aphrodite.png")
--         table.insert(allcards,card)
--     end
-- end

-- require("card")

-- allcards = {}

-- function create_cards()
--     for i = 1, 2 do 
--         -- Wood Cow
--         local card = Card:constructor("Wood Cow", 1, 1, "Vanilla")
--         card:load_image("img/wood.png")
--         table.insert(allcards, card)
        
--         -- Pegasus
--         card = Card:constructor("Pegasus", 2, 5, "Vanilla")
--         card:load_image("img/Pegasus.png")
--         table.insert(allcards, card)
        
--         -- Minotaur
--         card = Card:constructor("Minotaur", 4, 9, "Vanilla")
--         card:load_image("img/Minotaur.png")
--         table.insert(allcards, card)
        
--         -- Titan
--         card = Card:constructor("Titan", 5, 12, "Vanilla")
--         card:load_image("img/Titan.png")
--         table.insert(allcards, card)

--         -- Zeus
--         card = Card:constructor("Zeus", 2, 6, "Lower the power of each card in your opponent's hand by 1.")
--         card.ability = function(self, opponent) 
--             for i, opp_card in ipairs(board.players[opponent].hand.card_stack) do
--                 print("Zeuses hand")
--                 opp_card:change_power(-1)
--                 if opp_card.power <= 0 then
--                     local dead = board.players[opponent].hand:remove(i, "single")
--                     board.players[opponent].discard_pile:insert(dead)
--                     board:update_position()
--                 end
--             end
--         end 
--         card:load_image("img/Zeus.png")
--         table.insert(allcards, card)

--         -- Ares
--         card = Card:constructor("Ares", 5, 8, "Gain +2 power for each enemy card here.")
--         card.ability = function(self, opponent) 
--             print("activated card turn")
--             local location = self.location
--             print(location)
--             for i, opp_card in ipairs(board.players[opponent].locations[location].card_stack) do
--                 print("detected card")
--                 self:change_power(2)
--             end
--         end 
--         card:load_image("img/Ares.png")
--         table.insert(allcards, card)

--         -- Cyclops
--         card = Card:constructor("Cyclops", 2, 4, "When Revealed: Discard your other cards here, gain +2 power for each discarded.")
--         card.ability = function(self, opponent) 
--             local player = opponent == 1 and 2 or 1
--             local location = self.location
            
--             -- Create a copy of the card stack to iterate safely
--             local cards_to_remove = {}
--             for i, card_obj in ipairs(board.players[player].locations[location].card_stack) do
--                 if card_obj.name ~= "Cyclops" then
--                     table.insert(cards_to_remove, {index = i, card = card_obj})
--                 end
--             end
            
--             -- Remove cards in reverse order to maintain indices
--             for i = #cards_to_remove, 1, -1 do
--                 local dead = board.players[player].locations[location]:remove(cards_to_remove[i].index, "single")
--                 board.players[player].discard_pile:insert(dead)
--                 self:change_power(2)
--             end
--             board:update_position()
--         end 
--         card:load_image("img/Cyclops.png")
--         table.insert(allcards, card)

--         -- Artemis
--         card = Card:constructor("Artemis", 3, 5, "When Revealed: Gain +5 power if there is exactly one enemy card here.")
--         card.ability = function(self, opponent) 
--             local location = self.location
--             if #board.players[opponent].locations[location].card_stack == 1 then
--                 self:change_power(5)
--             end
--         end 
--         card:load_image("img/Artemis .png")
--         table.insert(allcards, card)

--         -- Demeter
--         card = Card:constructor("Demeter", 2, 2, "When Revealed: Both players draw a card.")
--         card.ability = function(self, opponent) 
--             -- Player 1 draws
--             if #board.players[1].deck > 0 and #board.players[1].hand.card_stack < 7 then
--                 local c = table.remove(board.players[1].deck, 1)
--                 board.players[1].hand:insert(c)
--                 board:update_position()
--                 board.players[1].hand:open_cards()
--             end
--             -- Player 2 draws
--             if #board.players[2].deck > 0 and #board.players[2].hand.card_stack < 7 then
--                 local c = table.remove(board.players[2].deck, 1)
--                 board.players[2].hand:insert(c)
--                 board:update_position()
--                 board.players[2].hand:close_cards()
--             end
--         end 
--         card:load_image("img/Demeter (1).png")
--         table.insert(allcards, card)

--         -- Hades
--         card = Card:constructor("Hades", 1, 1, "When Revealed: Gain +2 power for each card in your discard pile.")
--         card.ability = function(self, opponent) 
--             local player = opponent == 1 and 2 or 1
--             local dead = #board.players[player].discard_pile.card_stack * 2
--             self:change_power(dead)
--         end 
--         card:load_image("img/Hades (1).png")
--         table.insert(allcards, card)

--         -- Hercules
--         card = Card:constructor("Hercules", 3, 4, "When Revealed: Doubles its power if its the strongest card here.")
--         card.ability = function(self, opponent) 
--             local player = opponent == 1 and 2 or 1
--             local location = self.location
--             local is_strongest = true
            
--             -- Check player's own cards
--             for i, card_obj in ipairs(board.players[player].locations[location].card_stack) do
--                 if card_obj.power > self.power and card_obj.name ~= self.name then 
--                     is_strongest = false
--                     break
--                 end
--             end
            
--             -- Check opponent's cards
--             if is_strongest then
--                 for i, card_obj in ipairs(board.players[opponent].locations[location].card_stack) do
--                     if card_obj.power > self.power then 
--                         is_strongest = false
--                         break
--                     end
--                 end
--             end
            
--             if is_strongest then
--                 self:change_power(self.power) -- Double the power
--             end
--         end 
--         card:load_image("img/Hercules.png")
--         table.insert(allcards, card)

--         -- Dionysus
--         card = Card:constructor("Dionysus", 2, 1, "When Revealed: Gain +2 power for each of your other cards here.")
--         card.ability = function(self, opponent) 
--             local player = opponent == 1 and 2 or 1
--             local location = self.location
--             for i, card_obj in ipairs(board.players[player].locations[location].card_stack) do
--                 if card_obj ~= self then
--                     self:change_power(2)
--                 end
--             end
--         end 
--         card:load_image("img/Dionysus.png")
--         table.insert(allcards, card)

--         -- Midas
--         card = Card:constructor("Midas", 2, 3, "When Revealed: Set ALL cards here to 3 power.")
--         card.ability = function(self, opponent) 
--             local player = opponent == 1 and 2 or 1
--             local location = self.location
--             -- Set player's cards to 3 power
--             for i, card_obj in ipairs(board.players[player].locations[location].card_stack) do
--                 if card_obj ~= self then
--                     card_obj.power = 3
--                 end
--             end
--             -- Set opponent's cards to 3 power
--             for i, card_obj in ipairs(board.players[opponent].locations[location].card_stack) do
--                 card_obj.power = 3
--             end
--         end 
--         card:load_image("img/Midas (1).png")
--         table.insert(allcards, card)

--         -- Aphrodite
--         card = Card:constructor("Aphrodite", 3, 6, "When Revealed: Lower the power of each enemy card here by 1.")
--         card.ability = function(self, opponent) 
--             local location = self.location
--             for i, card_obj in ipairs(board.players[opponent].locations[location].card_stack) do
--                 card_obj:change_power(-1)
--             end
--         end
--         card:load_image("img/Aphrodite.png")
--         table.insert(allcards, card)
--     end
-- end


require("card")

allcards = {}

-- Function to generate thematic sound effects for card abilities
function generate_card_sound(card_name)
    local sample_rate = 44100
    local duration = 0.8
    local samples = math.floor(sample_rate * duration)
    local sound_data = love.sound.newSoundData(samples, sample_rate, 16, 1)
    
    if card_name == "Zeus" then
        -- Thunder/lightning sound - rapid crackling with low rumble
        for i = 0, samples - 1 do
            local t = i / sample_rate
            local thunder_freq = 60 + math.random() * 40 -- Low rumble
            local lightning_freq = 2000 + math.random() * 1000 -- High crackle
            local amplitude = 0.4 * math.exp(-t * 1.5)
            local thunder = amplitude * 0.7 * math.sin(2 * math.pi * thunder_freq * t)
            local lightning = amplitude * 0.3 * (math.random() - 0.5) * math.exp(-t * 3) -- Crackling noise
            local sample = thunder + lightning
            sound_data:setSample(i, math.max(-1, math.min(1, sample)))
        end
        
    elseif card_name == "Ares" then
        -- War horn/battle cry - strong, martial sound
        for i = 0, samples - 1 do
            local t = i / sample_rate
            local freq1 = 200 -- Deep horn
            local freq2 = 400 -- Overtone
            local amplitude = 0.5 * (1 - t / duration) * math.sin(t * 8) -- Pulsing
            local sample = amplitude * (math.sin(2 * math.pi * freq1 * t) + 0.5 * math.sin(2 * math.pi * freq2 * t))
            sound_data:setSample(i, sample)
        end
        
    elseif card_name == "Cyclops" then
        -- Heavy stone grinding/crushing sound
        for i = 0, samples - 1 do
            local t = i / sample_rate
            local base_freq = 100 + t * 50
            local amplitude = 0.4 * (1 - t / duration)
            local noise = (math.random() - 0.5) * 0.3 -- Stone grinding texture
            local sample = amplitude * (math.sin(2 * math.pi * base_freq * t) + noise)
            sound_data:setSample(i, sample)
        end
        
    elseif card_name == "Artemis" then
        -- Bow string and arrow whistle
        for i = 0, samples - 1 do
            local t = i / sample_rate
            if t < 0.1 then
                -- Bow string snap
                local freq = 800 - t * 3000
                local amplitude = 0.4 * math.exp(-t * 20)
                local sample = amplitude * math.sin(2 * math.pi * freq * t)
                sound_data:setSample(i, sample)
            else
                -- Arrow whistle
                local freq = 1200 + math.sin(t * 20) * 200
                local amplitude = 0.3 * math.exp(-(t - 0.1) * 2)
                local sample = amplitude * math.sin(2 * math.pi * freq * t)
                sound_data:setSample(i, sample)
            end
        end
        
    elseif card_name == "Demeter" then
        -- Nature/growth sound - gentle, nurturing
        for i = 0, samples - 1 do
            local t = i / sample_rate
            local freq1 = 400 + math.sin(t * 5) * 100 -- Flowing melody
            local freq2 = 600 + math.sin(t * 7) * 80  -- Harmony
            local amplitude = 0.3 * math.sin(t * math.pi / duration) -- Bell curve
            local sample = amplitude * (math.sin(2 * math.pi * freq1 * t) + 0.6 * math.sin(2 * math.pi * freq2 * t))
            sound_data:setSample(i, sample)
        end
        
    elseif card_name == "Hades" then
        -- Dark, otherworldly sound from the underworld
        for i = 0, samples - 1 do
            local t = i / sample_rate
            local freq = 150 - t * 30 -- Descending into darkness
            local amplitude = 0.5 * (1 - math.abs(t - duration/2) / (duration/2)) -- Diamond shape
            local sample = amplitude * math.sin(2 * math.pi * freq * t) * (1 + 0.3 * math.sin(2 * math.pi * freq * t * 3))
            sound_data:setSample(i, sample)
        end
        
    elseif card_name == "Hercules" then
        -- Heroic fanfare/power surge
        for i = 0, samples - 1 do
            local t = i / sample_rate
            local freq1 = 523 -- C note
            local freq2 = 659 -- E note  
            local freq3 = 784 -- G note
            local amplitude = 0.4 * math.sin(t * math.pi / duration) -- Rising and falling
            local sample = amplitude * (math.sin(2 * math.pi * freq1 * t) + 
                                      math.sin(2 * math.pi * freq2 * t) + 
                                      math.sin(2 * math.pi * freq3 * t)) / 3
            sound_data:setSample(i, sample)
        end
        
    elseif card_name == "Dionysus" then
        -- Festive, celebratory sound with multiple tones
        for i = 0, samples - 1 do
            local t = i / sample_rate
            local freq = 500 + math.sin(t * 12) * 200 -- Dancing melody
            local amplitude = 0.35 * (1 + 0.5 * math.sin(t * 15)) -- Rhythmic pulsing
            local sample = amplitude * math.sin(2 * math.pi * freq * t)
            sound_data:setSample(i, sample)
        end
        
    elseif card_name == "Midas" then
        -- Golden chime/transformation sound
        for i = 0, samples - 1 do
            local t = i / sample_rate
            local freq1 = 800 -- Golden chime
            local freq2 = 1200 -- Higher chime
            local freq3 = 1600 -- Highest chime
            local amplitude = 0.3 * math.exp(-t * 2) -- Quick decay like metal chime
            local sample = amplitude * (math.sin(2 * math.pi * freq1 * t) + 
                                      0.7 * math.sin(2 * math.pi * freq2 * t) + 
                                      0.5 * math.sin(2 * math.pi * freq3 * t)) / 2.2
            sound_data:setSample(i, sample)
        end
        
    elseif card_name == "Aphrodite" then
        -- Enchanting, mystical sound
        for i = 0, samples - 1 do
            local t = i / sample_rate
            local freq = 700 + math.sin(t * 8) * 150 -- Flowing, seductive melody
            local amplitude = 0.35 * math.sin(t * math.pi / duration) * (1 + 0.2 * math.sin(t * 25))
            local sample = amplitude * math.sin(2 * math.pi * freq * t)
            sound_data:setSample(i, sample)
        end
        
    else
        -- Default ability sound
        for i = 0, samples - 1 do
            local t = i / sample_rate
            local freq = 400 + t * 200
            local amplitude = 0.3 * math.exp(-t * 3)
            local sample = amplitude * math.sin(2 * math.pi * freq * t)
            sound_data:setSample(i, sample)
        end
    end
    
    return love.audio.newSource(sound_data)
end

-- Load card ability sounds
function load_card_sounds()
    if not sounds.card_abilities then
        sounds.card_abilities = {}
    end
    
    local card_names = {"Zeus", "Ares", "Cyclops", "Artemis", "Demeter", "Hades", "Hercules", "Dionysus", "Midas", "Aphrodite"}
    
    for _, name in ipairs(card_names) do
        -- Try to load custom sound first, fallback to generated
        local filepath = "sounds/abilities/" .. name:lower() .. ".wav"
        if love.filesystem.getInfo(filepath) then
            sounds.card_abilities[name] = love.audio.newSource(filepath, "static")
        else
            sounds.card_abilities[name] = generate_card_sound(name)
        end
    end
end

-- Function to play card ability sound
function play_card_ability_sound(card_name)
    if sounds.card_abilities and sounds.card_abilities[card_name] then
        love.audio.stop(sounds.card_abilities[card_name])
        love.audio.play(sounds.card_abilities[card_name])
    end
end

function create_cards()
    -- Load ability sounds when creating cards
    load_card_sounds()
    
    for i = 1, 2 do 
        -- Wood Cow
        local card = Card:constructor("Wood Cow", 1, 1, "Vanilla")
        card:load_image("img/wood.png")
        table.insert(allcards, card)
        
        -- Pegasus
        card = Card:constructor("Pegasus", 2, 5, "Vanilla")
        card:load_image("img/Pegasus.png")
        table.insert(allcards, card)
        
        -- Minotaur
        card = Card:constructor("Minotaur", 4, 9, "Vanilla")
        card:load_image("img/Minotaur.png")
        table.insert(allcards, card)
        
        -- Titan
        card = Card:constructor("Titan", 5, 12, "Vanilla")
        card:load_image("img/Titan.png")
        table.insert(allcards, card)

        -- Zeus
        card = Card:constructor("Zeus", 2, 6, "Lower the power of each card in your opponent's hand by 1.")
        card.ability = function(self, opponent) 
            play_card_ability_sound("Zeus")
            for i, opp_card in ipairs(board.players[opponent].hand.card_stack) do
                print("Zeuses hand")
                opp_card:change_power(-1)
                if opp_card.power <= 0 then
                    local dead = board.players[opponent].hand:remove(i, "single")
                    board.players[opponent].discard_pile:insert(dead)
                    board:update_position()
                end
            end
        end 
        card:load_image("img/Zeus.png")
        table.insert(allcards, card)

        -- Ares
        card = Card:constructor("Ares", 5, 8, "Gain +2 power for each enemy card here.")
        card.ability = function(self, opponent) 
            play_card_ability_sound("Ares")
            print("activated card turn")
            local location = self.location
            print(location)
            for i, opp_card in ipairs(board.players[opponent].locations[location].card_stack) do
                print("detected card")
                self:change_power(2)
            end
        end 
        card:load_image("img/Ares.png")
        table.insert(allcards, card)

        -- Cyclops
        card = Card:constructor("Cyclops", 2, 4, "When Revealed: Discard your other cards here, gain +2 power for each discarded.")
        card.ability = function(self, opponent) 
            play_card_ability_sound("Cyclops")
            local player = opponent == 1 and 2 or 1
            local location = self.location
            
            -- Create a copy of the card stack to iterate safely
            local cards_to_remove = {}
            for i, card_obj in ipairs(board.players[player].locations[location].card_stack) do
                if card_obj.name ~= "Cyclops" then
                    table.insert(cards_to_remove, {index = i, card = card_obj})
                end
            end
            
            -- Remove cards in reverse order to maintain indices
            for i = #cards_to_remove, 1, -1 do
                local dead = board.players[player].locations[location]:remove(cards_to_remove[i].index, "single")
                board.players[player].discard_pile:insert(dead)
                self:change_power(2)
            end
            board:update_position()
        end 
        card:load_image("img/Cyclops.png")
        table.insert(allcards, card)

        -- Artemis
        card = Card:constructor("Artemis", 3, 5, "When Revealed: Gain +5 power if there is exactly one enemy card here.")
        card.ability = function(self, opponent) 
            local location = self.location
            if #board.players[opponent].locations[location].card_stack == 1 then
                play_card_ability_sound("Artemis")
                self:change_power(5)
            end
        end 
        card:load_image("img/Artemis .png")
        table.insert(allcards, card)

        -- Demeter
        card = Card:constructor("Demeter", 2, 2, "When Revealed: Both players draw a card.")
        card.ability = function(self, opponent) 
            play_card_ability_sound("Demeter")
            -- Player 1 draws
            if #board.players[1].deck > 0 and #board.players[1].hand.card_stack < 7 then
                local c = table.remove(board.players[1].deck, 1)
                board.players[1].hand:insert(c)
                board:update_position()
                board.players[1].hand:open_cards()
            end
            -- Player 2 draws
            if #board.players[2].deck > 0 and #board.players[2].hand.card_stack < 7 then
                local c = table.remove(board.players[2].deck, 1)
                board.players[2].hand:insert(c)
                board:update_position()
                board.players[2].hand:close_cards()
            end
        end 
        card:load_image("img/Demeter (1).png")
        table.insert(allcards, card)

        -- Hades
        card = Card:constructor("Hades", 1, 1, "When Revealed: Gain +2 power for each card in your discard pile.")
        card.ability = function(self, opponent) 
            play_card_ability_sound("Hades")
            local player = opponent == 1 and 2 or 1
            local dead = #board.players[player].discard_pile.card_stack * 2
            self:change_power(dead)
        end 
        card:load_image("img/Hades (1).png")
        table.insert(allcards, card)

        -- Hercules
        card = Card:constructor("Hercules", 3, 4, "When Revealed: Doubles its power if its the strongest card here.")
        card.ability = function(self, opponent) 
            local player = opponent == 1 and 2 or 1
            local location = self.location
            local is_strongest = true
            
            -- Check player's own cards
            for i, card_obj in ipairs(board.players[player].locations[location].card_stack) do
                if card_obj.power > self.power and card_obj.name ~= self.name then 
                    is_strongest = false
                    break
                end
            end
            
            -- Check opponent's cards
            if is_strongest then
                for i, card_obj in ipairs(board.players[opponent].locations[location].card_stack) do
                    if card_obj.power > self.power then 
                        is_strongest = false
                        break
                    end
                end
            end
            
            if is_strongest then
                play_card_ability_sound("Hercules")
                self:change_power(self.power) -- Double the power
            end
        end 
        card:load_image("img/Hercules.png")
        table.insert(allcards, card)

        -- Dionysus
        card = Card:constructor("Dionysus", 2, 1, "When Revealed: Gain +2 power for each of your other cards here.")
        card.ability = function(self, opponent) 
            play_card_ability_sound("Dionysus")
            local player = opponent == 1 and 2 or 1
            local location = self.location
            for i, card_obj in ipairs(board.players[player].locations[location].card_stack) do
                if card_obj ~= self then
                    self:change_power(2)
                end
            end
        end 
        card:load_image("img/Dionysus.png")
        table.insert(allcards, card)

        -- Midas
        card = Card:constructor("Midas", 2, 3, "When Revealed: Set ALL cards here to 3 power.")
        card.ability = function(self, opponent) 
            play_card_ability_sound("Midas")
            local player = opponent == 1 and 2 or 1
            local location = self.location
            -- Set player's cards to 3 power
            for i, card_obj in ipairs(board.players[player].locations[location].card_stack) do
                if card_obj ~= self then
                    card_obj.power = 3
                end
            end
            -- Set opponent's cards to 3 power
            for i, card_obj in ipairs(board.players[opponent].locations[location].card_stack) do
                card_obj.power = 3
            end
        end 
        card:load_image("img/Midas (1).png")
        table.insert(allcards, card)

        -- Aphrodite
        card = Card:constructor("Aphrodite", 3, 6, "When Revealed: Lower the power of each enemy card here by 1.")
        card.ability = function(self, opponent) 
            play_card_ability_sound("Aphrodite")
            local location = self.location
            for i, card_obj in ipairs(board.players[opponent].locations[location].card_stack) do
                card_obj:change_power(-1)
            end
        end
        card:load_image("img/Aphrodite.png")
        table.insert(allcards, card)
    end
end