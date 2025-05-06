# FiveM OX-Lib Callbacks

A lightweight resource that replaces traditional FiveM events with OX-Lib callbacks for improved client-server communication.

## Features

- **Secure Communication**: Enhanced security compared to standard events
- **Response Feedback**: Get success/error responses from server operations
- **Easy Integration**: Simple to implement in existing scripts
- **Notification System**: Built-in notification handling
- **Better Error Handling**: Catch and manage errors effectively
- **Cleaner Code**: More structured approach to client-server communication

## Installation

1. Download or clone this repository
2. Place the folder in your FiveM resources directory
3. Add `ensure ox_lib` and `ensure ox_callbacks` to your server.cfg
4. Restart your server

## Dependencies

- [ox_lib](https://github.com/overextended/ox_lib)
- [es_extended](https://github.com/esx-framework/esx-legacy)

## Usage Examples

### Item Delivery System

**Server-side**
```lua
-- Register the callback on server
lib.callback.register('blackmarket:giveItems', function(source, deliveryData)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if deliveryData and deliveryData.items then
        for _, item in ipairs(deliveryData.items) do
            if item.name and item.count then
                xPlayer.addInventoryItem(item.name, item.count)
            else
                return false
            end
        end
        return true
    else
        return false
    end
end)
```

**Client-side**
```lua
-- Call from client with notification handling
lib.callback('blackmarket:giveItems', false, function(success)
    if success then
        lib.notify({
            title = 'Delivery',
            description = 'Package successfully delivered!',
            type = 'success'
        })
    else
        lib.notify({
            title = 'Delivery',
            description = 'Something went wrong with the delivery!',
            type = 'error'
        })
    end
end, { items = transformedItems })
```

### Money System

**Server-side**
```lua
-- Money addition callback
lib.callback.register('flyer_job:addMoney', function(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        xPlayer.addMoney(amount)
        return true
    end
    
    return false
end)
```

**Client-side**
```lua
-- Basic usage without response handling
lib.callback('flyer_job:addMoney', false, nil, payment)

-- With response handling
lib.callback('flyer_job:addMoney', false, function(success)
    if success then
        lib.notify({
            title = 'Payment',
            description = 'You received $' .. payment,
            type = 'success'
        })
    end
end, payment)
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributors

- Brozovec

---

Made with ❤️ for the FiveM community
