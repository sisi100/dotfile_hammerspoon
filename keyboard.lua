local kf = require "keyboard_func"


kf.remapKey({'ctrl'}, 'j', kf.methodForceEngAndKey('escape'))
kf.remapKey({'ctrl'}, 'm', kf.methodForceEngAndKey('return'))

-- カーソル移動
kf.remapKey({'ctrl'}, 'n', kf.keyCode('down'))
kf.remapKey({'ctrl'}, 'p', kf.keyCode('up'))

-- アプリケーションウィンドウ時の選択
for i = 1, 9 do
    kf.remapKey({'option'}, tostring(i), kf.moveAppWindow(i))
end
