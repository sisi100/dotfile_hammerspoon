local kf = {}

-- キーバインドと関数を紐付ける
kf.remapKey = function(modifiers, key, keyCode)
    hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

-- アプリケーションウィンドウ向け（暫定）

-- アプリケーションウィンドウ起動時に左からｘ個目を指定する
-- ※ただしいつでも叩けるので注意
kf.moveAppWindow = function(number)
    return function()
        hs.alert.show("MOVE:" .. number)

        -- 一度左に行ってから右に戻ると、経験則で左上へ移動する
        hs.eventtap.event.newKeyEvent({}, string.lower("left"), true):post()
        for i = 1, number do
            hs.eventtap.event.newKeyEvent({}, string.lower("right"), true):post()
        end
        hs.eventtap.event.newKeyEvent({}, string.lower("return"), true):post()
    end
end

return kf
