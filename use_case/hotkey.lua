local Hotkey = {}

Hotkey.set = function(keySet, action)
    -- keySet: KeySet
    -- action: HotkeyActionBase
    
    hs.hotkey.bind(
        keySet.modifiers,
        keySet.key,
        action.pressedFunc,
        action.releasedFunc,
        action.repeatFunc
    )
end

return Hotkey
