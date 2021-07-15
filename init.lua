dofile("define.lua")
dofile("mouse.lua")
dofile("keyboard.lua")

-- triggers
for file in io.popen("ls triggers"):lines() do
    dofile("triggers/" .. file)
end
