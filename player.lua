-- PLAYER CLASS ---------------------------------------
Player = {}
Player.__index = Player
Player.__type = "Player"

function Player:constructor(name)
    local self = {}
    setmetatable(self, Card)
    name = name
    score = 0
    mana = 1
    hand = {}
    deck = {}
    discard = {}
    locations = {{}, {}, {}} -- 3 locations, each can hold 4 cards
    return self
end