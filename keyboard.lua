local kf = require "keyboard_func"

-- アプリケーションウィンドウ起動時の選択
for i = 1, 9 do
    kf.remapKey({"option"}, tostring(i), kf.moveAppWindow(i))
end
