local HotkeyActionBase = require "use_case.inputs.hotkey_action_base"

local WindowMaximSize = require "use_case.actions.window_maxim_size"
local WindowMaximSizeInput = {}

WindowMaximSizeInput.new = function()
    local obj = HotkeyActionBase.new()

    obj.pressedFunc = WindowMaximSize.new()

    return obj
end

return WindowMaximSizeInput
