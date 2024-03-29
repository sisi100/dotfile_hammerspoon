local HotkeyActionBase = require "use_case.inputs.bases.hotkey_action_base"

local Hotkey = {}

Hotkey.set = function(keySet, action)
    -- keySet: KeySet
    -- action: HotkeyActionBase

    hs.hotkey.bind(keySet.modifiers, keySet.key, action.pressedFunc, action.releasedFunc, action.repeatFunc)
end

Hotkey.setPressed = function(keySet, action)
    -- キーをプッシュしたときのみアクションをする
    -- Inputをいちいち作るのが面倒になったので実装！

    -- keySet: KeySet
    -- action: void

    local obj = HotkeyActionBase.new()
    obj.pressedFunc = action
    Hotkey.set(keySet, obj)
end

return Hotkey
