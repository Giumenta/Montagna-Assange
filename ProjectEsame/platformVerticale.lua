local tiled = require "com.ponywolf.ponytiled"
local json = require ("json")
local mapData = json.decodeFile(system.pathForFile("maps/livello3/mappaPlatformVerticale.json",system.ResourceDirectory))
local map = tiled.new(mapData, "maps/livello3")

--provo a caricare
map:scale(2,2)
--dimensioni display (utili in vari momenti)
dispWidth = display.contentWidth
dispHeight = display.contentHeight
--aggancio il fondo mappa
--428*16 = 6848
map.y = -6848+dispHeight