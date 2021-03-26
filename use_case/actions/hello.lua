local Hello = {}

Hello.new =function(showMassage)
    -- showMassage: string
    local func = function()
        hs.alert.show(showMassage)
        print(showMassage)
    end
    return func
end

return Hello


