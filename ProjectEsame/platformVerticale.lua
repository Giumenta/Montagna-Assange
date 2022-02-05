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
map.y = -6848 + dispHeight

--creo i gruppi
local camera = display.newGroup() --gruppo dove metto dentro tutta la roba che debe essere sempre visibile
local control = display.newGroup() --gruppo per le freccette
--carico le risorse grafiche
local opt = {width = 32, height = 32, numFrames = 3}
local hero = graphics.newImageSheet("risorseGrafiche/PG/sprite-sheet.png", opt)
local seqs = {
	{
		name = "static" 
		start = 1 --ma inizia con indice 0 o 1?
		count 
	}
	{
		
		name = "runLeft",
		start = 1
	}
}
