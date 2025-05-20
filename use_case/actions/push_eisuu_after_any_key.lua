-- 指定されたキーを押した後に英数キーを押すアクション
-- 主に日本語入力中に特定のキーを押した後に英数入力に切り替えたい場合に使用
local PushEisuuAfterAnyKey = {}

PushEisuuAfterAnyKey.new = function(key)
    local func = function()
        -- デバッグ用のアラート表示
        hs.alert.show(string.upper(key) .. " & ENG")
        -- 指定されたキーを押す
        hs.eventtap.event.newKeyEvent({}, string.lower(key), true):post()
        -- 英数キーを押す
        hs.eventtap.event.newKeyEvent({}, "eisu", true):post()
    end
    return func
end

return PushEisuuAfterAnyKey
