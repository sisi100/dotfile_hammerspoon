local EventtapDoublePush = {}

EventtapDoublePush.set = function(modifierKey, action)
	local standby = false

	local function cancel()
		standby = false
	end

	local function tapAction(event)
		local keyCode = hs.keycodes.map[event:getKeyCode()]
		local flags = event:getFlags()
		local fixKey = string.gsub(modifierKey.modifier, "right", "") -- `right`系はフラグがないので`right`を外す

		if event:getType() == hs.eventtap.event.types.flagsChanged then
			if flags[fixKey] then
				if keyCode ~= modifierKey.modifier then
					cancel()
					return
				end

				if (not standby) then
					standby = true
					hs.timer.doAfter(
						0.5,
						function()
							cancel()
						end
					)
					return
				end

				cancel()
				action()
			end
		end
	end

	event = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, tapAction)
	event:start()
end

return EventtapDoublePush
