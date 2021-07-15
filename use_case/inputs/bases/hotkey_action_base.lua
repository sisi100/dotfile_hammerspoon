local HotkeyActionBase = {}

HotkeyActionBase.new = function()
    local obj = {}

    -- キーボードを押したときの処理
    obj.pressedFunc = nil

    -- キーボードを離したときの処理
    obj.releasedFunc = nil

    -- キーボードを押しっぱなしのときの処理
    obj.repeatFunc = nil

    return obj
end

return HotkeyActionBase
