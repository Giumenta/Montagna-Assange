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
local mapHeight = 6848
map.y = -6848 + dispHeight

--creo i gruppi
local camera = display.newGroup() --gruppo dove metto dentro tutta la roba che debe essere sempre visibile
local control = display.newGroup() --gruppo per le freccette
--carico le risorse grafiche
local opt = { width = 32, height = 32, numFrames = 12}
local heroSheet = graphics.newImageSheet("risorseGrafiche/PG/sprite-sheet.png",opt)

   local heroSeqs ={
	{
		name = "Front",
		frames={1,2,3},
		time = 1000,
		loopCount = 0,
		loopDirection ="forward"
   	},
   	{
		name = "Left",
		frames={4,5,6},
		time = 1000,
		loopCount = 0,
		loopDirection ="forward"
   	},
	{
		name = "Right",
		frames={7,8,9},
		time = 1000,
		loopCount = 0,
		loopDirection ="forward"
	},
	{
		name = "Back",
		frames={10,11,12},
		time = 1000,
		loopCount = 0,
		loopDirection ="forward"
	}
}
local hero = display.newSprite(heroSheet,heroSeqs)
local heroShape={-6,0,6,0,-6,16,6,16}
physics.addBody(hero, "dynamic", heroShape)
hero:scale(2,2)
hero.isFixedRotation=true
hero.x = (display.dispWidth) / 2
hero.y = -mapHeight + 200
