-- マウス関連の機能を管理するモジュール
local Mouse = {}

-- 設定
local deferred = false
local oldmousepos = {}
local scrollmult = -4

-- マウスモジュールの初期化
function Mouse.init()
    -- イベントリスナーの開始
    Mouse.overrideRightMouseDown:start()
    Mouse.overrideRightMouseUp:start()
    Mouse.dragRightToScroll:start()
end

-- 右クリックボタンダウンイベント
Mouse.overrideRightMouseDown = hs.eventtap.new(
    {hs.eventtap.event.types.rightMouseDown},
    function(e)
        hs.alert.show("down")
        deferred = true
        return true
    end
)

-- 右クリックボタンアップイベント
Mouse.overrideRightMouseUp = hs.eventtap.new(
    {hs.eventtap.event.types.rightMouseUp},
    function(e)
        hs.alert.show("up")
        if (deferred) then
            Mouse.overrideRightMouseDown:stop()
            Mouse.overrideRightMouseUp:stop()
            hs.eventtap.rightClick(e:location())
            Mouse.overrideRightMouseDown:start()
            Mouse.overrideRightMouseUp:start()
            return true
        end
        return false
    end
)

-- 右クリックドラッグでスクロールイベント
Mouse.dragRightToScroll = hs.eventtap.new(
    {hs.eventtap.event.types.rightMouseDragged},
    function(e)
        deferred = false
        oldmousepos = hs.mouse.absolutePosition()
        local dx = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaX"])
        local dy = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaY"])
        local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult}, {}, "pixel")
        hs.mouse.absolutePosition(oldmousepos)
        return true, {scroll}
    end
)

return Mouse
