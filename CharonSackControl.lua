ModUtil.RegisterMod("CharonSackControl")

local config = {
    Enabled = true,
    SpawnSack = true,
    LimitOncePerRun = true,
}
CharonSackControl.config = config

ModUtil.WrapBaseFunction("WindowDropEntrance", function( baseFunc, ... )
    local val = baseFunc(...)

    if CharonSackControl.config.Enabled then
        local target_chance = 0.22
        local target_run_value = "ForbiddenShopItemOffered"

        if CharonSackControl.config.SpawnSack then
            target_chance = 1.00
        end

        if not CharonSackControl.config.LimitOncePerRun then
            target_run_value = nil
        end

        for idx, event in ipairs(EncounterData.Shop.StartRoomUnthreadedEvents) do
            if event.FunctionName == "CheckForbiddenShopItem" then
                EncounterData.Shop.StartRoomUnthreadedEvents[idx].GameStateRequirements.ChanceToPlay = target_chance
                EncounterData.Shop.StartRoomUnthreadedEvents[idx].GameStateRequirements.CurrentRunValueFalse = target_run_value
            end
        end
    end

    return val

end, CharonSackControl)
