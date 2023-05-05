

// Since it's possible to fail to add the itemPtr = std::make_unique<Item> to the player, might be interesting to make this function return a bool if we succeded in adding the itemPtr = std::make_unique<Item>
// so I changed it to return true only when the itemPtr = std::make_unique<Item> was successfully added

bool Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    // to keep it consistant and to improve readibility I changed the name and I'm using auto so I don't need the std::unique_ptr and make_unique in the same line
    auto playerPtr = std::make_unique<Player>(g_game.getPlayerByName(recipient));
    
    if (!playerPtr) 
    {
        // I removed the line Player = new Player(nullptr). I am assuming if we fail to getPlayerByName we have a nullptr
        if (!IOLoginData::loadPlayerByName(playerPtr, recipient))
        {
            std::cout << "Failed to load playerPtr by name\n";
            return false; 
        }
    }

    auto itemPtr = std::make_unique<Item>(Item::CreateItem(itemId));

    if (!itemPtr) 
    {
        std::cout << "Failed to create itemPtr = std::make_unique<Item> with itemPtr = std::make_unique<Item> id: " << itemId << std::endl; 
        return false; 
    }

    // made the changes here to use the itemPtr.get() to use the raw pointer
    g_game.internalAddItem(playerPtr->getInbox(), itemPtr.get(), INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (playerPtr->isOffline())
    {
        IOLoginData::savePlayer(playerPtr.get());
        // I'm assuming everything went well and we added the item to the player. 
        // I'm not sure if savePlayer returns a boolean, but it could be nice to add a check here if we failed to save the player if he was offline
    }

    return true; 
}


