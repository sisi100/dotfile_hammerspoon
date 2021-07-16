-- key
local KeySet = require "entities.key_set"
local ModifierKey = require "entities.modifier_key"

local ctrl_z = KeySet.new({"ctrl"}, "z")
local ctrl_j = KeySet.new({"ctrl"}, "j")
local ctrl_n = KeySet.new({"ctrl"}, "n")
local ctrl_p = KeySet.new({"ctrl"}, "p")
local ctrl_m = KeySet.new({"ctrl"}, "m")
local option_space = KeySet.new({"rightalt"}, "space")
local up = KeySet.new({}, "up")
local down = KeySet.new({}, "down")
local righOption = ModifierKey.new("rightalt")
local righCommand = ModifierKey.new("rightcmd")

-- Actionの定義
local HelloInput = require "use_case.inputs.hello_input"
local PushEisuuAfterAnyKeyInput = require "use_case.inputs.push_eisuu_after_any_key_input"
local PushKeyInput = require "use_case.inputs.push_key_set_input"
local WindowMaximSizeInput = require "use_case.inputs.window_maxim_size_input"
local ExecuteCommandInput = require "use_case.inputs.execute_command_input"

local showHelloWorld = HelloInput.new("Hello World !!")
local pushEisuuAndEscape = PushEisuuAfterAnyKeyInput.new("escape")
local pushUp = PushKeyInput.new(up)
local pushDown = PushKeyInput.new(down)
local windowMaximSize = WindowMaximSizeInput.new()
local openLaunchpad = ExecuteCommandInput.new("open -a launchpad")
local openTerminal = ExecuteCommandInput.new("open -a terminal")
local openMissionControl = ExecuteCommandInput.new("open -a 'Mission Control'")

-- ホットキーに設定
local Hotkey = require "use_case.hotkey"

Hotkey.set(ctrl_z, showHelloWorld) -- 動作テスト
Hotkey.set(ctrl_j, pushEisuuAndEscape)
Hotkey.set(ctrl_p, pushUp)
Hotkey.set(ctrl_n, pushDown)
Hotkey.set(ctrl_m, windowMaximSize)
Hotkey.setPressed(option_space, openMissionControl)

-- イベントの設定
local EventtapDoublePush = require "use_case.eventtap_double_push"

EventtapDoublePush.set(righOption, openLaunchpad)
EventtapDoublePush.set(righCommand, openTerminal)
