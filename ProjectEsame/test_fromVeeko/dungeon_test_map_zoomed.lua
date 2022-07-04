physics = require('physics')
physics.start()
physics.setGravity(0,0) --almeno possiamo lavorare in 'verticale' nel dungeon 
physics.setDrawMode("hybrid")

--robe varie della mappa
local tiled = require "com.ponywolf.ponytiled"
local json = require ("json")
local mapData = json.decodeFile(system.pathForFile("maps/Dungeon/Map_Zoom.json",system.ResourceDirectory))
local map = tiled.new(mapData, "maps/Dungeon")
local dragable = require "com.ponywolf.plugins.dragable"
map = dragable.new(map)
--map.isZoomEnabled = true
local scaleFactor = 1
local mapWidth = 5120
local mapHeight = 2880

--creo giusto un gruppo
local control = display.newGroup()
local camera= display.newGroup()

--sistemo robe per il POV
camera:insert(map)

local walls = map:listTypes('wall')

--for i = 1, #walls do
--	local w = walls[i].width
--	local h = walls[i].height
--	physics.removeBody(walls[i])
--	local shape = {-w/2, h2, w/2, h2, w/2, -h/2, -w/2, -h/2}
--	physics.addBody(walls[i], 'static', {outline=shape})
--	camera:insert(walls[i])
--end

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

control:toFront()

-- preparo per la creazione dello sheet dell' eroe
local opt = { width = 32, height = 32, numFrames = 12}
local heroSheet = graphics.newImageSheet("risorseGrafiche/PG/sprite-sheet.png", opt); 
local heroSeqs = {
	{
		name = "front",
		frames={1,2,3},
		time = 1000,
		loopCount = 0,
		loopDirection ="forward"
   	},
   	{
		name = "left",
		frames={4,5,6},
		time = 1000,
		loopCount = 0,
		loopDirection ="forward"
   	},
	{
		name = "right",
		frames={7,8,9},
		time = 1000,
		loopCount = 0,
		loopDirection ="forward"
	},
	{
		name = "back",
		frames={10,11,12},
		time = 1000,
		loopCount = 0,
		loopDirection ="forward"
	}
}

local hero = display.newSprite(heroSheet,heroSeqs)

local heroShape= {-2, 0, 2, 0, -2, 5, 2, 5}
physics.addBody(hero, "dynamic", heroShape)
hero.isFixedRotation = true
hero:scale(2,2)
hero.x = display.contentCenterX
hero.y = display.contentCenterY

----[[
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
	elseif event.phase == "ended" then
		hero:setLinearVelocity(0,0)
		hero:pause()
	end
	return true
end


local preX = hero.x
local preY = hero.y

local function moveCamera(event)
	local diffX = preX - hero.x
	local diffY = preY - hero.y

	if diffX > 0 then
		camera.x = camera.x - diffX
	else
		camera.x = camera.x + diffX
	end
	if diffY > 0 then
		camera.y = camera.y - diffY
	else
		camera.y = camera.y + diffY
	end
	preX = hero.x 
	preY = hero.y

	return true
end


local heroRadius=50
local mapBorderLeft = 0
local mapBorderRight = 4480
local mapBorderTop = 0
local mapBorderBottom = 2520
---- FARE IN QUALCHE MODO UN FOREACH CHE PRENDA TUTTI GLI ELEMENTI IN WALLS E LI SPOSTI CON setLinearVelocity ------

local function moveMap(event)
	local arrow = event.target
	local ciao = 'ciao'

	if event.phase == "began" then
		if arrow.name == "up" then
			 walls:setLinearVelocity(0, -150)
			hero:play()		
		elseif arrow.name == "left" then
			hero:setSequence("left")
			hero:play()
		elseif arrow.name == "right" then
			hero:setSequence("right") 
			hero:play()
		else --arrow.name == down
			hero:setSequence("front")
			hero:play()
		end
	elseif event.phase == "moved" then
		if arrow.name == "up" then
			hero:setSequence("back")
			hero:play()
		elseif arrow.name == "left" then
			hero:setSequence("left")
			hero:play()
		elseif arrow.name == "right" then 
			hero:setSequence("right") 
			hero:play()
		else --arrow.name == down
			hero:setSequence("front")
			hero:play()
		end
	elseif event.phase == "ended" then
		hero:setLinearVelocity(0,0)
		hero:pause()
	end
	return true
end

local function onColl(event)
	print(hero.x .. " : " .. hero.y)
end

arrowLeft:addEventListener("touch", movePg)
arrowRight:addEventListener("touch", movePg)
arrowDown:addEventListener("touch", movePg)
arrowUp:addEventListener("touch", movePg)
Runtime:addEventListener("enterFrame", moveCamera)
-- Runtime:addEventListener("enterFrame", moveMap)
hero:addEventListener("collision", onColl)
