-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Import libraries
local http = require("socket.http")
local json = require("json")

display.setStatusBar(display.DefaultStatusBar);


local function handleResponse( event )

    if not event.isError then
        local response = json.decode( event.response )
        print( event.response )
    else
        print( "Error!" )
    end

    return
end

-- REST API Function to get latest prices from coinmarketcap
local json = require("json")

function command(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
        s = string.gsub(s, '^%s+', '')
        s = string.gsub(s, '%s+$', '')
        s = string.gsub(s, '[\n\r]+', ' ')
    return s
end

function format_int(number)

  local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
  -- reverse the int-string and append a comma to all blocks of 3 digits
  int = int:reverse():gsub("(%d%d%d)", "%1,")
  -- reverse the int-string back remove an optional comma and put the
  return minus .. int:reverse():gsub("^,", "") .. fraction
end

-- get api
local results = command("curl -s 'https://api.coinmarketcap.com/v1/ticker/?limit=3'")
local output = json.decode(results)

-- Capture the 3rd json payload - xrp
local eth = output[3]
local xrpCoinPrice = eth['price_usd']

-- change to the number of tokens you have
totalXrpTokens = 50000
-- total tokens multiplied by coin price based on coinmarketcap
totalXrpValue = xrpCoinPrice * totalXrpTokens
print(totalXrpValue)

-- convert string to float
x = string.format("US$%6.2f", totalXrpValue)
cleanXrpValue = format_int(x)
print(format_int(totalXrpValue))

-- Prints token name and price
print(eth["name"], eth["price_usd"])

local printcoin = eth["name"]

-- paint labels onScreen
local label1 = display.newText("Speed Racer", 160, 90, native.systemFont, 26);
local label2 = display.newText(printcoin, 160, 120, native.systemFont, 26);
local label2 = display.newText("USD: " .. xrpCoinPrice .. " Per XRP", 160, 180, native.systemFont, 16);
local label2 = display.newText("\nTotal Value:\n" .. "US$" ..cleanXrpValue, 160, 220, native.systemFont, 26);
