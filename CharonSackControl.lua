ModUtil.RegisterMod("CharonSackControl")

local config = {
    Enabled = true,
    SpawnSack = true,
    LimitOncePerRun = false,
}
CharonSackControl.config = config

ModUtil.WrapBaseFunction("WindowDropEntrance", function( baseFunc, ... )
    local val = baseFunc(...)
    if CharonSackControl.config.Enabled and CharonSackControl.config.SpawnSack then
        ModUtil.MapSetTable(EncounterData.Shop.StartRoomUnthreadedEvents, {
            ChanceToPlay = 1.00
        })
    else
        ModUtil.MapSetTable(EncounterData.Shop.StartRoomUnthreadedEvents, {
            ChanceToPlay = 0.22
        })
    end
    if CharonSackControl.config.Enabled and not CharonSackControl.config.LimitOncePerRun then
        ModUtil.MapNilTable(EncounterData.Shop.StartRoomUnthreadedEvents, {
            CurrentRunValueFalse = true
        })
    else
        ModUtil.MapSetTable(EncounterData.Shop.StartRoomUnthreadedEvents, {
            CurrentRunValueFalse = "ForbiddenShopItemOffered"
        })
    end

    return val

end, CharonSackControl)
