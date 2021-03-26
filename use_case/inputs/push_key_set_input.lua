local HotkeyActionInput = require "use_case.inputs.hotkey_action_input"

local PushKeySet = require "use_case.actions.push_key_set"
local PushKeySetInput = {}

PushKeySetInput.new = function(keySet)
    local obj = HotkeyActionInput.new()

    obj.func = PushKeySet.new(keySet)

    obj.pressedFunc = obj.func
    obj.repeatFunc = obj.func

    return obj
end

return PushKeySetInput
