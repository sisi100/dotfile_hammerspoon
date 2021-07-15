local HotkeyActionBase = require "use_case.inputs.bases.hotkey_action_base"

local Hello = require "use_case.actions.hello"
local HelloInput = {}

HelloInput.new = function(showMassage)
    local obj = HotkeyActionBase.new()

    obj.pressedFunc = Hello.new("[Press]" .. showMassage)
    obj.releasedFunc = Hello.new("[Release]" .. showMassage)
    obj.repeatFunc = Hello.new("[Repeat]" .. showMassage)

    return obj
end

return HelloInput
