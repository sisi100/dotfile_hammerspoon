local HotkeyActionInput = require "use_case.inputs.hotkey_action_input"

local PushEisuuAfterAnyKey = require "use_case.actions.push_eisuu_after_any_key"
local PushEisuuAfterAnyKeyInput = {}

PushEisuuAfterAnyKeyInput.new = function(key)
    local obj = HotkeyActionInput.new()

    obj.func = PushEisuuAfterAnyKey.new(key)

    obj.pressedFunc = obj.func
    obj.repeatFunc = obj.func

    return obj
end

return PushEisuuAfterAnyKeyInput
