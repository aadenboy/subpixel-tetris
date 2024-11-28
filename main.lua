require "keys"
math.randomseed(os.time())

local shapes = {
    l = {
        --[[
              #
            #x#

            #
            x
            ##

            #x#
            #

            ##
             x
             #
        ]]
        {-1,  0,  0,  0,  1,  0,  1,  1},
        { 0,  1,  0,  0,  0, -1,  1, -1},
        {-1, -1, -1,  0,  0,  0,  1,  0},
        {-1,  1,  0,  1,  0,  0,  0, -1},
    },
    s = {
        --[[
             ##
            #x

            #
            x#
             #

             x#
            ##

            #
            #x
             #
        ]]
        {-1,  0,  0,  0,  0,  1,  1,  1},
        { 0,  1,  0,  0,  1,  0,  1, -1},
        {-1, -1,  0, -1,  0,  0,  1,  0},
        {-1,  1, -1,  0,  0,  0,  0, -1},
    },
    j = {
        --[[
            #
            #x#

            ##
            x
            #

            #x#
              #

             #
             x
            ##
        ]]
        {-1,  1, -1,  0,  0,  0,  1,  0},
        { 1,  1,  0,  1,  0,  0,  0, -1},
        {-1,  0,  0,  0,  1,  0,  1, -1},
        {-1, -1,  0, -1,  0,  0,  0,  1},
    },
    i = {
        --[[
            #x##

            #
            x
            #
            #

            ##x#

            #
            #
            x
            #
        ]]
        {-1,  0,  0,  0,  1,  0,  2,  0},
        { 0,  1,  0,  0,  0, -1,  0, -2},
        {-2,  0, -1,  0,  0,  0,  1,  0},
        { 0,  2,  0,  1,  0,  0,  0, -1},
    },
    t = {
        --[[
             #
            #x#

            #
            x#
            #

            #x#
             #

             #
            #x
             #
        ]]
        {-1,  0,  0,  0,  0,  1,  1,  0},
        { 0,  1,  0,  0,  1,  0,  0, -1},
        {-1,  0,  0,  0,  1,  0,  0, -1},
        { 0,  1, -1,  0,  0,  0,  0, -1},
    },
    z = {
        --[[
            ##
             x#

             #
            x#
            #

            #x
             ##

             #
            #x
            #
        ]]
        {-1,  1,  0,  1,  0,  0,  1,  0},
        { 1,  1,  1,  0,  0,  0,  0, -1},
        {-1,  0,  0,  0,  0, -1,  1, -1},
        { 0,  1, -1,  0,  0,  0, -1, -1},
    },
    o = {
        --[[
            ##
            x#

            x#
            ##

            #x
            ##

            ##
            #x
        ]]
        { 0,  0,  0,  1,  1,  0,  1,  1},
        { 0,  0,  1,  0,  0, -1,  1, -1},
        {-1,  0,  0,  0, -1, -1,  0, -1},
        {-1,  1,  0,  1, -1,  0,  0,  0},
    }
}

local tests = {
    {0, 0, -1, 0, -1, 1, 0, -2, -1, -2},
    {0, 0, 1, 0, 1, -1, 0, 2, 1, 2},
    {0, 0, 1, 0, 1, 1, 0, -2, 1, -2},
    {0, 0, -1, 0, -1, -1, 0, 2, -1, 2},
}
local offsets = {
    all = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, -1, 0, 2, 1, 2},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, -1, 0, -1, -1, 0, 2, -1, 2},
    },
    i = {
        {0, 0, -1, 0, 2, 0, -1, 0, 2, 0},
        {-1, 0, 0, 0, 0, 0, 0, 1, 0, -2},
        {-1, 1, 1, 1, -2, 1, 1, 0, -2, 0},
        {0, 1, 0, 1, 0, 1, 0, -1, 0, 2},
    },
    o = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, -1, 0, -1, 0, -1, 0, -1, 0, -1},
        {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
        {-1, 0, -1, 0, -1, 0, -1, 0, -1, 0},
    }
}

function dump(table, nest, delim, newline, visited)
    visited = visited or {}
    visited[table] = true
    if type(table) == "table" then -- you can change "table" here to also include other values, like "table,vector2"
        local s = ""
        nest = nest or 0
        delim = delim or "\t"
        newline = newline or "\n"

        for i,v in pairs(table) do
            if type(i) == "string" and i:match("^[%a_][%d%a_]*$") then s = s..delim:rep(nest)..i.." = "
                                                                    else s = s..delim:rep(nest).."["..(type(i) == "string" and "\"" or "")..tostring(i)..(type(i) == "string" and "\"" or "").."] = " end

            if type(v) == "table" then 
                local has = false for _ in pairs(v) do has = true break end

                if has and not visited[table] then
                    s = s.."{"..newline..dump(v, nest + 1, delim, newline, visited)..newline..delim:rep(nest).."},"
                elseif not has then
                    s = s.."{},"
                else
                    s = s.."{...},"
                end
            elseif type(v) == "string" then
                s = s.."\""..v.."\","
            else
                s = s..tostring(v)..","
            end

            s = s..newline
        end

        return s:sub(1, -3)
    else
        return tostring(table)
    end
end

local canvas = love.graphics.newCanvas()
local apply  = love.graphics.newCanvas()
local shader = love.graphics.newShader([[
    vec4 effect(vec4 color, Image tex, vec2 tpos, vec2 spos) {
        vec2 npos = tpos * vec2(3.0, 1.0);
        vec4 r = Texel(tex, npos);
        vec4 g = Texel(tex, npos + vec2(1.0/700.0, 0));
        vec4 b = Texel(tex, npos + vec2(2.0/700.0, 0));
        return r + g + b;
    }
]])
local split = love.graphics.newShader([[
    vec4 effect(vec4 color, Image tex, vec2 tpos, vec2 spos) {
        vec4 tcolor = Texel(tex, tpos);
        int  modVal = int(mod(spos.x - 1, 3.0));
        
             if (modVal == 0) return vec4(tcolor.r, 0.0, 0.0, 1.0);
        else if (modVal == 1) return vec4(0.0, tcolor.g, 0.0, 1.0);
        else                  return vec4(0.0, 0.0, tcolor.b, 1.0);
    }    
]])
canvas:setFilter("nearest", "nearest")
apply:setFilter("nearest", "nearest")

local level = 0
local t, ldt, f = 0, 0, 0
local hit = 0

keyboard.threshold.wait = 1
keyboard.threshold.debounce = 5
keyboard.keybinds:new("fall",   "down",  "s")
keyboard.keybinds:new("left",   "left",  "a")
keyboard.keybinds:new("right",  "right", "d")
keyboard.keybinds:new("drop",   "up",    "w")
keyboard.keybinds:new("rotcw",  "e", "'", "rshift", "rctrl", "ralt", "m", "x", ".")
keyboard.keybinds:new("rotccw", "q", ";", "lshift", "lctrl", "lalt", "z", ",")
keyboard.keybinds:new("hold",   "space", "tab", "return", "backspace", "r", "h")

local board = {}
local next  = ""
local hold  = ""
local has   = {"", 1, 0, 0}

function key(x, y)
    if type(x) == "table" then x, y = x[1], x[2] end
    return x + y * 10 -- lmao
end
function pos(n)
    return n % 10, math.floor(n / 10)
end

local held = false
function valid(shape, pos)
    for i=1, #shape, 2 do
        local new = {pos[1] + shape[i], pos[2] + shape[i+1]}
        if board[key(new)] or new[2] < 0 or new[1] < 0 or new[1] > 9 then
            return false
        end 
    end
    return true
end

function newset()
    local s = "ljsztoi"
    for i=1, 7 do
        local a = math.random(1, #s)
        next = next..s:sub(a, a)
        s = s:sub(0, a-1)..s:sub(a+1, -1)
    end
end
newset()
newset()
function offone()
    if not valid(shapes[next:sub(1, 1)][1], {5, 19}) then
        love.window.showMessageBox("game over", "smh")
        board = {}
        held = false
        hold = ""
        next = ""
        newset()
        newset()
        offone()
        t, ldt, f = 0, 0, 0
        return
    end
    has  = {next:sub(1, 1), 1, 5, 19}
    next = next:sub(2, -1)
    if #next == 7 then newset() end
end
offone()

function build(shape, pos)
    for i=1, #shape, 2 do
        local new = {pos[1] + shape[i], pos[2] + shape[i+1]}
        board[key(new)] = true
    end
    offone()
    held = false

    local off = 0
    for i=0, 190, 10 do
        local clear = true
        l = i - off
        for j=l, l+9 do
            if not board[j] then
                clear = false
                break
            end
        end

        if clear then
            off = off + 10
            for k=0, 200 do
                if k >= l+10 then board[k-10] = board[k] end
                if k >= l    then board[k]    = nil      end
            end
        end
    end
end

function love.update(dt)
    keyboard:refresh()

    t = t + dt
    ldt = dt
    f = f + 1

    local shape = shapes[has[1]][has[2]]

    if (t - hit >= 2^level and not keyboard.keybinds.fall.pressed)
    or (keyboard.keybinds.fall.threshold) then
        hit = t

        if valid(shape, {has[3], has[4] - 1}) then
            has[4] = has[4] - 1
        else
            build(shape, {has[3], has[4]})
        end
    end
    if keyboard.keybinds.drop.clicked then
        for i=1, 20 do
            if not valid(shape, {has[3], has[4] - i}) then
                build(shape, {has[3], has[4] - i + 1})
                break
            end
        end
    end
    if keyboard.keybinds.left.threshold then
        if valid(shape, {has[3] - 1, has[4]}) then has[3] = has[3] - 1 end
    end
    if keyboard.keybinds.right.threshold then
        if valid(shape, {has[3] + 1, has[4]}) then has[3] = has[3] + 1 end
    end
    if keyboard.keybinds.rotcw.clicked or keyboard.keybinds.rotccw.clicked then
        local nrot   = keyboard.keybinds.rotcw.clicked and (has[2] % 4 + 1) or ((has[2] - 2) % 4 + 1)
        local nshape = shapes[has[1]][nrot]
        
        local fset = (offsets[has[1]] or offsets.all)[has[2]]
        local nset = (offsets[has[1]] or offsets.all)[nrot]
        for i=1, 9, 2 do
            if valid(nshape, {has[3] + (fset[i] - nset[i]), has[4] + (fset[i+1] - nset[i+1])}) then
                has[2] = nrot
                has[3] = has[3] + (fset[i] - nset[i])
                has[4] = has[4] + (fset[i+1] - nset[i+1])
                break
            end
        end
    end
    if keyboard.keybinds.hold.clicked and not held then
        held = true
        if hold == "" then
            hold = has[1]
            offone()
        else
            hold, has[1] = has[1], hold
            has[3] = 5
            has[4] = 19
        end
    end
end

function drawpiece(shape, pos)
    for i=1, #shape, 2 do
        local new = {pos[1] + shape[i], pos[2] + shape[i+1]}
        love.graphics.rectangle("fill", new[1] + 11, 21 - new[2], 1, 1)
    end
end

function love.draw()
    -- initial
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    love.graphics.setShader(split)

    -- borders
    love.graphics.rectangle("fill", 10,  2,  1, 20)
    love.graphics.rectangle("fill", 21,  2,  1, 20)
    love.graphics.rectangle("fill", 10, 22, 12,  1)

    -- pieces (board)
    for i in pairs(board) do
        love.graphics.rectangle("fill", i % 10 + 11, 21 - math.floor(i / 10), 1, 1)
    end

    -- pieces (pieces)
    drawpiece(shapes[has[1]][has[2]], {has[3], has[4]})
    drawpiece(shapes[next:sub(1, 1)][1], {13, 17})
    drawpiece(shapes[next:sub(2, 2)][1], {13, 13})
    drawpiece(shapes[next:sub(3, 3)][1], {13, 9})
    drawpiece(shapes[next:sub(4, 4)][1], {13, 5})
    drawpiece(shapes[next:sub(5, 5)][1], {13, 1})
    if hold ~= "" then drawpiece(shapes[hold][1], {-5, 17}) end

    -- end
    love.graphics.setShader()
    love.graphics.setCanvas(apply)
    love.graphics.clear()
    love.graphics.setShader(shader)
    love.graphics.draw(canvas)
    love.graphics.setShader()

    -- scale
    love.graphics.setCanvas()
    love.graphics.draw(apply, 150, 200)
    love.graphics.draw(apply,  350, 200, 0, 6, 6, 2, 11)
    love.graphics.draw(canvas, 500, 200, 0, 2, 6, 6, 11)
    --love.graphics.print(dump(has).."\n"..next)
end