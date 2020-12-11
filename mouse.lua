-- ######################
-- # ボールスクロール
-- ######################
local deferred = false
local oldmousepos = {}
local scrollmult = -4

-- 右クリックを話したときの処理
overrideRightMouseDown = hs.eventtap.new(
    {hs.eventtap.event.types.rightMouseDown},
    function(e)
        hs.alert.show("down")
        deferred = true
        return true
    end
)

-- 右クリックを押しっぱなしの処理
overrideRightMouseUp = hs.eventtap.new(
    {hs.eventtap.event.types.rightMouseUp},
    function(e)
        hs.alert.show("up")
        if (deferred) then
            overrideRightMouseDown:stop()
            overrideRightMouseUp:stop()
            hs.eventtap.rightClick(e:location())
            overrideRightMouseDown:start()
            overrideRightMouseUp:start()
            return true
        end
        return false
    end
)

-- スクロール処理
dragRightToScroll = hs.eventtap.new(
    {hs.eventtap.event.types.rightMouseDragged},
    function(e)
        deferred = false
        oldmousepos = hs.mouse.getAbsolutePosition()
        local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
        local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
        local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult},{},'pixel')
        hs.mouse.setAbsolutePosition(oldmousepos)
        return true, {scroll}
    end
)

overrideRightMouseDown:start()
overrideRightMouseUp:start()
dragRightToScroll:start()