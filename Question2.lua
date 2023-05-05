function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"

    -- I wasn't sure what sure about this line, so after some searching I found that this line was only
    -- retrieving and storing the results form the query, so I believe a more descriptive name is queryResult
    local queryResult = db.storeQuery(string.format(selectGuildQuery, memberCount))

    -- -- So, now that we have the result, we only print the name of all guild with the previous params if we the result found something
    if queryResult ~= nil then        
        while queryResult.next() do
            local guildName = queryResult.getString("name")
            print(guildName)
        end
    else
        print("No results found")
    end
end