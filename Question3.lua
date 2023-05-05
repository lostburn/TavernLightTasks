
-- A more descriptive name for this function would be removePlayerFromParty since we are searching through the party and calling party:removeMember
function removePlayerFromParty(playerId, memberName) -- I also fixed some inconsistency with the naming convention you are providing lowerUpper (membername to memberName)
    local player = Player(playerId) -- I added local because this variable is only used in this scope
    
    if player ~= nil then -- I added a safety check here to be consistent with my previous answers. 
        local party = player:getParty()
        local partyMemberFound = false -- We might encounter some unexpected code if we try to remove a player that is not in the party anymore

        for _, member in pairs(party:getMembers()) do 
            if member == Player(memberName) then 
                party:removeMember(Player(memberName))
                partyMemberFound = true
                break -- I also added this early return in case we don't need to iterate over every members
            end
        end
        
        if not partyMemberFound then
            print (memberName, "was not found in the party list") -- I'm assuming memberName is a string
            return
        end

    else
        -- I'm assuming playerId is a number so we could get more information of what went wrong
        print("PlayerID: ", playerId, " is not valid")
    end
end