-- アクションの定義
-- キーバインドに紐づく各種アクションを管理する
local Actions = {}

-- 指定されたキーを押した後に英数キーを押すアクション
Actions.pushEisuuAfterKey = function(key)
    return function()
        hs.alert.show(string.upper(key) .. " & ENG")
        hs.eventtap.event.newKeyEvent({}, string.lower(key), true):post()
        hs.eventtap.event.newKeyEvent({}, "eisu", true):post()
    end
end

-- 指定されたキーを押すアクション
Actions.pushKey = function(keySet)
    return function()
        hs.eventtap.event.newKeyEvent(keySet.modifiers, string.lower(keySet.key), true):post()
    end
end

-- ウィンドウを最大化するアクション
Actions.maximizeWindow = function()
    return function()
        hs.grid.maximizeWindow()
    end
end

-- アプリケーションを起動するアクション
Actions.openApplication = function(appName)
    return function()
        -- 英数入力に切り替え
        hs.eventtap.event.newKeyEvent({}, "eisu", true):post()
        -- アプリケーションを起動
        hs.execute("open -a " .. appName)
    end
end

-- 修飾キーを2回押したときのアクション
Actions.doubleTapModifier = function(modifierKey, action)
    local isStandby = false
    local DOUBLE_TAP_TIMEOUT = 0.5  -- ダブルタップの判定時間（秒）

    -- スタンバイ状態を解除
    local function cancelStandby()
        isStandby = false
    end

    return function(event)
        local keyCode = hs.keycodes.map[event:getKeyCode()]
        local flags = event:getFlags()
        local fixKey = string.gsub(modifierKey.modifier, "right", "")

        if event:getType() == hs.eventtap.event.types.flagsChanged then
            if flags[fixKey] then
                -- 修飾キーが正しくない場合はキャンセル
                if keyCode ~= modifierKey.modifier then
                    cancelStandby()
                    return
                end

                -- 初回タップの場合
                if not isStandby then
                    isStandby = true
                    hs.timer.doAfter(DOUBLE_TAP_TIMEOUT, cancelStandby)
                    return
                end

                -- ダブルタップの実行
                cancelStandby()
                action()
            end
        end
    end
end

return Actions
