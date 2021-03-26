local HotkeyActionInput = require "use_case.inputs.hotkey_action_input"

local Hello = require "use_case.actions.hello"
local HelloInput = {}

HelloInput.new = function(showMassage)
    local obj = HotkeyActionInput.new()

    obj.pressedFunc = Hello.new("[Press]"..showMassage)
    obj.releasedFunc = Hello.new("[Release]"..showMassage)
    obj.repeatFunc = Hello.new("[Repeat]"..showMassage)

    return obj
end

return HelloInput
