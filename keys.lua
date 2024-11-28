window = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    refresh = function(self)
        local flags
        self.width, self.height, flags = love.window.getMode()
        self.x, self.y = flags.x, flags.y
    end
}

mouse = { -- note: mb is "mouse button", l m and r is "left" "middle" and "right", t is "temporary", aka "debounce"
    -- pressed is for when it's held, clicked is for the one frame the click starts, frames is the amount of frames it's held down for
    x = 0,
    y = 0,
    lmb = {pressed = false, frames = 0, clicked = false},
    rmb = {pressed = false, frames = 0, clicked = false},
    mmb = {pressed = false, frames = 0, clicked = false},
    mbdb = "",
    refresh = function(self)
        self.mbdb = ""
        self.x, self.y = love.mouse.getPosition()
        self.lmb.pressed = love.mouse.isDown(1)
        self.mmb.pressed = love.mouse.isDown(3)
        self.rmb.pressed = love.mouse.isDown(2)
        self.lmb.clicked = self.lmb.pressed and self.lmb.frames == 0
        self.mmb.clicked = self.mmb.pressed and self.mmb.frames == 0
        self.rmb.clicked = self.rmb.pressed and self.rmb.frames == 0
        self.lmb.frames = (self.lmb.frames + 1) * (self.lmb.pressed and 1 or 0)
        self.mmb.frames = (self.mmb.frames + 1) * (self.mmb.pressed and 1 or 0)
        self.rmb.frames = (self.rmb.frames + 1) * (self.rmb.pressed and 1 or 0)
        if self.lmb.pressed then self.mbdb = self.mbdb.."lmb("..self.lmb.frames.."f), " end
        if self.mmb.pressed then self.mbdb = self.mbdb.."mmb("..self.mmb.frames.."f), " end
        if self.rmb.pressed then self.mbdb = self.mbdb.."rmb("..self.rmb.frames.."f), " end
    end
}

keyboard = {["a"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["b"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["c"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["d"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["e"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["g"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["h"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["i"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["j"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["k"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["l"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["m"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["n"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["o"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["p"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["q"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["r"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["s"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["t"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["u"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["v"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["w"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["x"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["y"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["z"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["0"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["1"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["2"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["3"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["4"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["5"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["6"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["7"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["8"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["9"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["space"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["!"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["\""] = {pressed = false, frames = 0, clicked = false, threshold = false},
["#"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["$"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["&"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["'"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["("] = {pressed = false, frames = 0, clicked = false, threshold = false},
[")"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["*"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["+"] = {pressed = false, frames = 0, clicked = false, threshold = false},
[","] = {pressed = false, frames = 0, clicked = false, threshold = false},
["-"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["."] = {pressed = false, frames = 0, clicked = false, threshold = false},
["/"] = {pressed = false, frames = 0, clicked = false, threshold = false},
[":"] = {pressed = false, frames = 0, clicked = false, threshold = false},
[";"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["<"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["="] = {pressed = false, frames = 0, clicked = false, threshold = false},
[">"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["?"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["@"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["["] = {pressed = false, frames = 0, clicked = false, threshold = false},
["\\"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["]"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["^"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["_"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["`"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp0"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp1"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp2"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp3"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp4"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp5"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp6"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp7"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp8"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp9"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp."] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp,"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp/"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp*"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp-"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp+"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kpenter"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["kp="] = {pressed = false, frames = 0, clicked = false, threshold = false},
["up"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["down"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["right"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["left"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["home"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["end"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["pageup"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["pagedown"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["insert"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["backspace"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["tab"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["clear"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["return"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["delete"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f1"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f2"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f3"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f4"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f5"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f6"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f7"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f8"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f9"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f10"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f11"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f12"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f13"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f14"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f15"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f16"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f17"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["f18"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["numlock"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["capslock"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["scrolllock"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["rshift"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["lshift"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["rctrl"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["lctrl"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["ralt"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["lalt"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["rgui"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["lgui"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["escape"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["help"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["printscreen"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["sysreq"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["menu"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["application"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["power"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["currencyunit"] = {pressed = false, frames = 0, clicked = false, threshold = false},
["undo"] = {pressed = false, frames = 0, clicked = false, threshold = false},
clicked = {},
pressed = {},
presseddb = "",
threshold = {wait = 24, debounce = 5},
keybinds = {new = function(self, name, ...)
    self[name] = {pressed = false, frames = 0, clicked = false, threshold = false, candidates = {...}}
end},
refresh = function(self)
    self.clicked   = {}
    self.pressed   = {}
    self.presseddb = ""
    self.clickeddb = ""
    for i,v in pairs(self) do
        if type(v) == "table" and v.frames then
            self[i].pressed = love.keyboard.isDown(i)
            self[i].clicked = self[i].pressed and v.frames == 0
            self[i].frames = (v.frames + 1) * (self[i].pressed and 1 or 0)
            self[i].threshold = self[i].clicked or (self[i].frames >= self.threshold.wait and self[i].frames % self.threshold.debounce == 0)
            if self[i].pressed then self.presseddb = self.presseddb..i.."("..self[i].frames.."f), " self.pressed[i] = self[i] end
        end
    end
    for i,b in pairs(self.keybinds) do
        if type(b) == "table" and b.frames then
            local v = self.keybinds[i]
            local any = false
            for _,n in pairs(v.candidates) do if love.keyboard.isDown(n) then any = true break end end
            v.pressed = any
            v.clicked = v.pressed and v.frames == 0
            v.frames = (v.frames + 1) * (v.pressed and 1 or 0)
            v.threshold = v.clicked or (v.frames >= self.threshold.wait and v.frames % self.threshold.debounce == 0)
        end
    end
end,
pressing = function(self, ...)
    for _,v in pairs({...}) do
        if self.pressed[v] == nil then
            return false
        end
    end

    return true
end,
clicking = function(self, ...)
    for _,v in pairs({...}) do
        if self.clicked[v] == nil then
            return false
        end
    end

    return true
end,
}