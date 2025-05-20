-- 指定されたキーを押した後に英数キーを押す入力ハンドラ
-- HotkeyActionBaseを継承して、キー入力時の動作を定義する
local HotkeyActionBase = require "use_case.inputs.bases.hotkey_action_base"

local PushEisuuAfterAnyKey = require "use_case.actions.push_eisuu_after_any_key"
local PushEisuuAfterAnyKeyInput = {}

PushEisuuAfterAnyKeyInput.new = function(key)
    -- HotkeyActionBaseのインスタンスを作成
    local obj = HotkeyActionBase.new()

    -- PushEisuuAfterAnyKeyアクションを設定
    obj.func = PushEisuuAfterAnyKey.new(key)

    -- キーを押した時と押し続けた時の動作を設定
    obj.pressedFunc = obj.func
    obj.repeatFunc = obj.func

    return obj
end

return PushEisuuAfterAnyKeyInput
