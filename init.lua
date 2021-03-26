dofile("define.lua")
dofile("mouse.lua")
dofile("keyboard.lua")

-- triggers
for file in io.popen("ls triggers"):lines() do
    dofile("triggers/"..file)
end


local kf = require "keyboard_func"

-- [option]を2回叩くとlaunchpadを開く&英字
-- TODO: 整理する
firstAlt = false
secondAlt = false

local function cancelAlt()
    firstAlt = false
    secondAlt = false
end

local function changeTerminal(event)
    local c = event:getKeyCode()
    local f = event:getFlags()
    if event:getType() == hs.eventtap.event.types.flagsChanged then
        if f["alt"] then
            if c == 58 or c == 61 then
                if firstAlt then
                    secondAlt = true
                end
                firstAlt = true
                hs.timer.doAfter(
                    0.5,
                    function()
                        cancelAlt()
                    end
                )
                if firstAlt and secondAlt then
                    cancelAlt()
                    hs.eventtap.event.newKeyEvent({}, KEY_CODE_JIS_EISUU, true):post()
                    hs.execute("open -a launchpad")
                end
            else
                cancelAlt()
            end
        end
    end
end
opop = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, changeTerminal)
opop:start()
