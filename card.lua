-- CARD CLASS ---------------------------------------
Card = {}
Card.__index = Card
Card.__type = "Card"

function Card:constructor(name,cost,power,text)
    local self = {}
    setmetatable(self, Card)
    self.x = 0
    self.y = 0
    self.w = 250 * 0.2
    self.h = 350 * 0.2
    self.state = "closed"
    self.offsetX = 0
    self.offsetY = 0 
    self.name = name
    self.cost = cost
    self.power = power
    self.location = 0
    self.ability = nil
    self.text = text
    return self
end

function Card:drag_move(x, y)
    self.x = x - self.offsetX
    self.y = y - self.offsetY
end


function Card:set_offset(x,y)
    self.offsetX = x - self.x
    self.offsetY = y - self.y
end

function Card:move(x, y)
    self.x = x
    self.y = y
end

function Card:is_valid(x,y)
    if (self:is_idle()) and (self:in_bounds(x,y)) then 
        return true
    else 
        return false
    end
end

function Card:is_idle()
    return self.state == "idle"
end

function Card:in_bounds(x, y)
    print("in bounds", (x > self.x and x < self.x + self.w) and (y > self.y and y < self.y + self.h))
    return (x > self.x and x < self.x + self.w) and (y > self.y and y < self.y + self.h)
end

function Card:add_data(name,power,cost,ability)
    self.name = name
    self.power = power
    self.cost = cost
    self.ability = ability
end

function Card:change_state(state)
    self.state = state
end

function Card:draw()
    if (self.state == "idle") then
        -- Idle card
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h, 10, 10)
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, 10, 10)
        -- Text
        love.graphics.setColor(self.color == "red" and 1 or 0,0,0)
        love.graphics.print(self.name, self.x, self.y, center)
        love.graphics.print("Cost:" .. self.cost, self.x, self.y + 10, center)
        love.graphics.print("Pow:" .. self.power, self.x, self.y + 20, center)

    else 
        -- Closed Card
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h, 10, 10)
        love.graphics.setColor(0.25,0.25,0.9)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, 10, 10)
    end
end

function Card:act(opponent)
        print("BOWLLL")
    if self.ability ~= nil then
        print('GIRLLL')
        self.ability(self, opponent)
    end
end

function Card:change_power(num)
    self.power = self.power + num
end

-- BOUNDS OBJECT------------------------------------
Bounds = {}
Bounds.__index = Bounds

function Bounds:constructor(type)
    local self = {}
    setmetatable(self, Bounds)
    self.x = 0
    self.y = 0
    if type == "location" then 
        self.w = 150
        self.h = 350 * 0.2
    else
        self.w = 250 * 0.2
        self.h = 350 * 0.2
    end
    return self
end

function Bounds:draw()
    love.graphics.setColor(0,1,0,0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, 20, 20)
end

-- Using Axis-Aligned Bounding Box (AABB) collision detection:
function Bounds:isOverlapping(b)
    return self.x < b.x + b.w and
           self.x + self.w > b.x and
           self.y < b.y + b.h and
           self.y + self.h > b.y
end

function Bounds:move(x, y)
    self.x = x
    self.y = y
end