local EventtapDoublePush = {}
-- 修飾キーを２回連続で押したときのイベントを設定する

local actions = {}


local function newEvent(modifierKey, action)
	-- 修飾キーを２連続で押した場合に処理をするという関数を返す

	-- modifierKey:ModifierKey 修飾キー
	-- action:void

	local standby = false

	local function cancel()
		standby = false
	end

	local function tapAction(event)
		-- 処理本体

		-- event: hsから渡されるevent

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
	return tapAction
end

EventtapDoublePush.set = function(modifierKey, action)
	-- 修飾キーを２回連続叩いた場合に実行するactionを追加する
	-- Note: `hs.eventtap`に複数関数を渡すと挙動が怪しくなったので１つの関数にまとめた

	-- modifierKey:ModifierKey 修飾キー
	-- action:void

	local eventAction = newEvent(modifierKey, action)
	table.insert(actions, eventAction)

	local tapActions = function (event)
		-- 配列にあるアクションを統合して１つの関数にする

		-- event: hsから渡される

		for i, actionFunc in ipairs(actions) do
			actionFunc(event)
		end
	end

	event = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, tapActions)
	event:start()
end



return EventtapDoublePush
