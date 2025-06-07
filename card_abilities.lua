require("card")

------------------------------------------------------

allcards  = {}

function create_cards()
    for i = 1, 2 do 
        card = Card:constructor("Wooden Cow", 1, 1, "Vanilla")
        table.insert(allcards,card)
         card = Card:constructor("Pegasus", 2, 5, "Vanilla")
        table.insert(allcards,card)
         card = Card:constructor("Minotaur", 4, 9, "Vanilla")
        table.insert(allcards,card)
         card = Card:constructor("Titan", 5, 12, "Vanilla")
        table.insert(allcards,card)

        card = Card:constructor("Zeus", 2, 6, "Lower the power of each card in your opponent's hand by 1.")
        card.ability = function(self, opponent) 
            for i,opp_card in ipairs(board.players[opponent].hand.card_stack) do
                print("Zeuses hand")
                opp_card:change_power(-1)
                if opp_card.power == 0 then
                local dead = board.players[opponent].hand:remove(i, "single")
                board.players[opponent].discard_pile:insert(dead)
                board:update_position()
                end
            end
        end 
        table.insert(allcards,card)

        card = Card:constructor("Ares", 5 , 8, "Gain +2 power for each enemy card here.")
        card.ability = function(self, opponent) 
            print("activated card turn")
            local location = self.location
            print(location)
            for i, opp_card in ipairs(board.players[opponent].locations[location].card_stack) do
                print(inspect(board.players[opponent].locations[location].card_stack))
                print("detected card")
                self:change_power(2)
            end
        end 
        table.insert(allcards,card)


        card = Card:constructor("Cyclops", 2, 4, "When Revealed: Discard your other cards here, gain +2 power for each discarded.")
        card.ability = function(self, opponent) 
            local player = 0
            local location = self.location
            if opponent == 1 then player = 2
            elseif opponent == 2 then player = 1
            end
            for i,card in ipairs(board.players[player].locations[location].card_stack) do
                if card.name ~= "Cyclops" then
                    print("Discarding card")
                    local dead = board.players[player].locations[location]:remove(i, "single")
                    board.players[player].discard_pile:insert(dead)
                    self:change_power(2)
                    board:update_position()
                end
            end
        end 
        table.insert(allcards,card)

        card = Card:constructor("Artemis", 3, 5, "When Revealed: Gain +5 power if there is exactly one enemy card here.")
        card.ability = function(self, opponent) 
            local location = self.location
            local player = 0
            if opponent == 1 then player = 2
            elseif opponent == 2 then player = 1
            end
            if #board.players[opponent].locations[location].card_stack == 1 then
                self:change_power(5)
            end
        end 
        table.insert(allcards,card)

        card = Card:constructor("Demeter", 2, 2, "When Revealed: Both players draw a card.")
        card.ability = function(self, opponent) 
            if #board.players[1].deck > 0 and #board.players[1].hand.card_stack < 7 then

                local c = table.remove(board.players[1].deck, 1)
                board.players[1].hand:insert(c)
                board:update_position()
                board.players[1].hand:open_cards()
            end

            if #board.players[2].deck > 0 and #board.players[2].hand.card_stack < 7 then
                local c = table.remove(board.players[2].deck, 1)
                board.players[2].hand:insert(c)
                board:update_position()
                board.players[2].hand:close_cards()
            end
        end 
        table.insert(allcards,card)

        card = Card:constructor("Hades", 1,1 , "When Revealed: Gain +2 power for each card in your discard pile.")
        card.ability = function(self, opponent) 
            local player = 0
            if opponent == 1 then player = 2
            elseif opponent == 2 then player = 1
            end
            local dead = #board.players[player].discard_pile.card_stack * 2
            self:change_power(dead)
        end 
        table.insert(allcards,card)

        card = Card:constructor("Hercules", 3, 4, "When Revealed: Doubles its power if its the strongest card here.")
        card.ability = function(self, opponent) 
            local player = 0
            local location = self.location
            if opponent == 1 then player = 2
            elseif opponent == 2 then player = 1
            end
            for i,card in ipairs(board.players[player].locations[location].card_stack) do
                if card.power >= self.power and card.name ~= self.name then 
                    return
                end
            end
            
            for i,card in ipairs(board.players[opponent].locations[location].card_stack) do
                if card.power >= self.power and card.name ~= self.name then 
                    return
                end
            end
            self:change_power(self.power)
        end 
        table.insert(allcards,card)

        card = Card:constructor("Dionysus", 2, 1, "When Revealed: Gain +2 power for each of your other cards here.")
        card.ability = function(self, opponent) 
            local player = 0
            local location = self.location
            if opponent == 1 then player = 2
            elseif opponent == 2 then player = 1
            end
            for i,card in ipairs(board.players[player].locations[location].card_stack) do
                if card ~= self then
                self:change_power(2)
                end
            end
        end 
        table.insert(allcards,card)

        card = Card:constructor("Midas", 2, 3, "When Revealed: Set ALL cards here to 3 power.")
        card.ability = function(self, opponent) 
            local player = 0
            local location = self.location
            if opponent == 1 then player = 2
            elseif opponent == 2 then player = 1
            end
            for i,card in ipairs(board.players[player].locations[location].card_stack) do
                if card ~= self then
                    card.power = 3
                end
            end
            for i,card in ipairs(board.players[opponent].locations[location].card_stack) do
                card.power = 3
            end
        end 
        table.insert(allcards,card)

        card = Card:constructor("Aphrodite", 3, 6, "When Revealed: Lower the power of each enemy card here by 1.")
        card.ability = function(self, opponent) 
            local location = self.location
            for i,card in ipairs(board.players[opponent].locations[location].card_stack) do
                card:change_power(-1)
            end
        end
        table.insert(allcards,card)
    end
end