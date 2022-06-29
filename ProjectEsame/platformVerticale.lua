local physics = require("physics")
physics.start()
physics.setGravity(0, 9)
physics.setDrawMode("hybrid")
-- physics.pause()

--robe varie della mappa
local tiled = require "com.ponywolf.ponytiled"
local json = require ("json")
local mapData = json.decodeFile(system.pathForFile("maps/livello3/mappaPlatformVerticale.json",system.ResourceDirectory))
local map = tiled.new(mapData, "maps/livello3")

local dragable = require "com.ponywolf.plugins.dragable"
map = dragable.new(map)

--provo a caricare
--map:scale(2,2)
--dimensioni display (utili in vari momenti)
local dispWidth = display.contentWidth
local dispHeight = display.contentHeight
--aggancio il fondo mappa
--428*16 = 6848
local mapHeight = 6848/2
map.y =  -mapHeight+dispHeight

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

--preparazione frecce
local arrowLeft = display.newImageRect(control,"risorseGrafiche/risorseTmp_perTest/arrows/arrowLeft.png",80,80)
arrowLeft.x = 100
arrowLeft.y = display.contentHeight-150
arrowLeft.name = "left"

local arrowRight = display.newImageRect(control,"risorseGrafiche/risorseTmp_perTest/arrows/arrowRight.png",80,80)
arrowRight.x = 260
arrowRight.y = display.contentHeight-150
arrowRight.name = "right"

local arrowUp = display.newImageRect(control,"risorseGrafiche/risorseTmp_perTest/arrows/arrowUp.png",80,80)
arrowUp.x = 180
arrowUp.y = display.contentHeight-200
arrowUp.name = "up"

local arrowDown = display.newImageRect(control,"risorseGrafiche/risorseTmp_perTest/arrows/arrowDown.png",80,80)
arrowDown.x = 180
arrowDown.y = display.contentHeight-100
arrowDown.name = "down"

local hero = display.newSprite(heroSheet,heroSeqs)
local heroShape={-6,0,6,0,-6,16,6,16}
physics.addBody(hero, "dynamic", heroShape)
-- hero:scale(2,2)
hero.isFixedRotation=true
hero.x = display.contentCenterX - 50
hero.y = display.contentCenterY

if hero.y < display.contentHeight*2 then
	hero.y = 0
end

print(hero.x)
print(hero.y)

local function movePg(event)
	local arrow = event.target
	local ciao = 'ciao'

	if event.phase == "began" then
		if arrow.name == "up" then
			hero:setSequence("back")
			hero:play()
			hero:setLinearVelocity(0, -150)			
		elseif arrow.name == "left" then
			hero:setSequence("left")
			hero:play()
			hero:setLinearVelocity(-150, 0)
		elseif arrow.name == "right" then
			hero:setSequence("right") 
			hero:play()
			hero:setLinearVelocity(150, 0)
		else --arrow.name == down
			hero:setSequence("front")
			hero:play()
			hero:setLinearVelocity(0, 150)
		end
	elseif event.phase == "moved" then
		if arrow.name == "up" then
			hero:setLinearVelocity(0, -150)
		elseif arrow.name == "left" then
			hero:setLinearVelocity(-150, 0)
		elseif arrow.name == "right" then 
			hero:setLinearVelocity(150, 0)
		else --arrow.name == down
			hero:setLinearVelocity(0, 150)
		end
	elseif event.phase == "ended" then
		hero:setLinearVelocity(0,0)
		hero:pause()
	end

	return true
end


arrowLeft:addEventListener("touch", movePg)
arrowRight:addEventListener("touch", movePg)
arrowDown:addEventListener("touch", movePg)
arrowUp:addEventListener("touch", movePg)