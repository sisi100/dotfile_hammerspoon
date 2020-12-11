local KEY_CODE_JIS_EISUU = 102


local kf = {}


-- キーバインドと関数を紐付ける
kf.remapKey = function(modifiers, key, keyCode)
    hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

-- 任意のキーの後に半角英数をタイプ
kf.methodForceEngAndKey = function(key)
    return function()
        hs.alert.show(string.upper(key).." & ENG")
        hs.eventtap.event.newKeyEvent({}, string.lower(key), true):post()
        hs.eventtap.event.newKeyEvent({}, KEY_CODE_JIS_EISUU, true):post()
    end
end

-- モディファイアとキーの同時タイプ
kf.keyCode = function(key, modifiers)
    modifiers = modifiers or {}
    return function()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
    end
end


-- アプリケーションウィンドウ向け

-- アプリケーションウィンドウ起動時に左からｘ個目を指定する
-- ※ただしいつでも叩けるので注意
kf.moveAppWindow = function(number)
    return function()
        hs.alert.show("MOVE:"..number)

        -- 一度左に行ってから右に戻ると、経験則で左上へ移動する
        hs.eventtap.event.newKeyEvent({}, string.lower('left'), true):post()
        for i = 1, number do
            hs.eventtap.event.newKeyEvent({}, string.lower('right'), true):post()
        end
        hs.eventtap.event.newKeyEvent({}, string.lower('return'), true):post()
    end
end


return kf
