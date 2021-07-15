local WindowMaximSize = {}

WindowMaximSize.new =function()
    local func = function()
        hs.grid.maximizeWindow()
    end
    return func
end

return WindowMaximSize
