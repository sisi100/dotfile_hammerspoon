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
        hs.eventtap.event.newKeyEvent({}, "eisu", true):post() -- 英数に戻す
        hs.execute("open -a " .. appName)
    end
end

-- 修飾キーを2回押したときのアクション
Actions.doubleTapModifier = function(modifierKey, action)
    local standby = false

    local function cancel()
        standby = false
    end

    return function(event)
        local keyCode = hs.keycodes.map[event:getKeyCode()]
        local flags = event:getFlags()
        local fixKey = string.gsub(modifierKey.modifier, "right", "")

        if event:getType() == hs.eventtap.event.types.flagsChanged then
            if flags[fixKey] then
                if keyCode ~= modifierKey.modifier then
                    cancel()
                    return
                end

                if (not standby) then
                    standby = true
                    hs.timer.doAfter(0.5, cancel)
                    return
                end

                cancel()
                action()
            end
        end
    end
end

return Actions
