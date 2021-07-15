local HotkeyActionBase = require "use_case.inputs.hotkey_action_base"

local PushEisuuAfterAnyKey = require "use_case.actions.push_eisuu_after_any_key"
local PushEisuuAfterAnyKeyInput = {}

PushEisuuAfterAnyKeyInput.new = function(key)
    local obj = HotkeyActionBase.new()

    obj.func = PushEisuuAfterAnyKey.new(key)

    obj.pressedFunc = obj.func
    obj.repeatFunc = obj.func

    return obj
end

return PushEisuuAfterAnyKeyInput
