function isType(obj, typename)
    local mt = getmetatable(obj)
    return mt and mt.__type == typename
end

-- Stack class ---------------------------------------
Stack = {}
Stack.__index = Stack

function Stack:constructor(x, y, spread, type)
    local self = {}
    self.card_stack = {}
    self.data = {}
    self.data.x = x
    self.data.y = y
    self.data.x_interval = 55
    self.data.type = type or "normal"
    self.data.display = spread
    self.cap = Bounds:constructor(type)
    setmetatable(self, Stack)
    return self
end

-- Access functions---------------------------------------------
function Stack:num_cards()
    return #self.card_stack
end

function Stack:get_bounds()
    return self.cap
end

function Stack:get_last()
    -- if self:num_cards() == 0 then return nil end
    return self.card_stack[self:num_cards()]
end

function Stack:get_cap()
    return self.cap
end

function Stack:get_display()
    return self.data.display
end

function Stack:get_type()
    return self.data.type
end


-- Methods----------------------------------------------------

function Stack:drag_move(active_card, x, y)
    enable_move = false
    count = 1
    for i, card in ipairs(self.card_stack) do
        if (active_card == card) then enable_move = true end
        if (enable_move == true) then 
            card:drag_move(x,y + (self.data.x_interval * count))
            count = count + 1
        end
    end
end

function Stack:set_offset(x,y)
    for i, card in ipairs(self.card_stack) do
        card:set_offset(x,y)
    end
end

function Stack:insert(item)
    if isType(item, "Card") then
    -- Is card
        table.insert(self.card_stack, item)
    elseif type(item) == "table" then
    -- Is list
        for i=1, #item do
            table.insert(self.card_stack, item[i])
        end
    else
        error("Stack:insert expected a Card or list of Cards, got " .. tostring(item))
    end
end

function Stack:remove(item_index, mode)
    -- Single
    if mode == "single" then
        return table.remove(self.card_stack, item_index)
    -- Mult
    elseif mode == "mult" then
        local cards = {}
        for i=item_index, self:num_cards() do
            local card = table.remove(self.card_stack, item_index)
            table.insert(cards, card)
        end
        return cards
    end
end

function Stack:insert2(item_list)
    for i, item in ipairs(item_list) do
        table.insert(self.card_stack, item)
    end
end

function Stack:open_top_card()
    if self:num_cards() > 0 then
        local card = self.card_stack[self:num_cards()]
        card:change_state("idle")
    end
end

function Stack:close_cards()
    for i=1, self:num_cards() do 
        self.card_stack[i]:change_state("closed")
    end 
end

function Stack:open_cards()
    for i=1, self:num_cards() do 
        self.card_stack[i]:change_state("idle")
    end 
end

function Stack:find_card(x,y)
    for i=1,self:num_cards() do
        local card = self.card_stack[i]
        if (card:is_valid(x,y)) then
            return card, i
        end
    end
        print("Couldnt find card")
        return nil, nil
end

function Stack:update_position()
    if self.data.display == "spread" then 
        for i=1, self:num_cards() do 
            self.card_stack[i]:move(self.data.x + (self.data.x_interval* (i-1)), self.data.y)
        end
        self.cap:move(self.data.x, self.data.y)
    else 
        for i=1, self:num_cards() do 
            self.card_stack[i]:move(self.data.x, self.data.y)
        end 
        self.cap:move(self.data.x, self.data.y)
    end
end

function Stack:draw()
    self.cap:draw()
    for i=1, self:num_cards() do 
        local card = self.card_stack[i]
        card:draw()
    end
end

function Stack:total_power()
    local num = 0
    for i, card in ipairs(self.card_stack) do
        num = num + card.power
    end
    return num
end