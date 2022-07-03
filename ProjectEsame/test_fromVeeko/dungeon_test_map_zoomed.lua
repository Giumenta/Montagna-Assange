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

--map:scale(scaleFactor, scaleFactor) --<-sballa tutto il goddamn di fisica dei muri

--questo è temp, ma non ho cassi ora di andare a modificare la mappa
-- quindi faccio hide di tutti i babici presenti sulla mappa
--[[local toHide = map:listTypes("hero")
for i=1,5 do
	toHide[i].isVisible = false
end

--sistemiamo sta dannata fisica
local walls = map:listTypes('wall')
for i=1, #walls do
	--print(el)
	local el = walls[i]
	local h = el.height*scaleFactor
	local w = el.width*scaleFactor
	physics.removeBody(el)
	local wallShape = {-w/2, -h/2, w/2, -h/2, w/2, h/2, -w/2, -h/2}
	physics.addBody(el, "static", wallShape)
end
]]

--creo giusto un gruppo
local control = display.newGroup()
local camera= display.newGroup()

--sistemo robe per il POV
camera:insert(map)
-- map.x = 0
-- map.y = 0
-- camera:scale(1.2, 1.2)

--figura troppo complessa shiiiit
-- PoC con una parte di mappa
--[[
local walls_q1_Outline = graphics.newOutline(1, "maps/Dungeon/wallZoom_q1.png")
local walls_q1 = display.newImage("maps/Dungeon/wallZoom_q1.png", mapWidth, mapHeight)
walls_q1.anchorX = 0
walls_q1.anchorY = 0
walls_q1.x=0
walls_q1.y=0
physics.addBody(walls_q1, "static", {outline = walls_q1_Outline})
]]

local walls = map:listTypes('wall')

for i = 1, #walls do
	local w = walls[i].width
	local h = walls[i].height
	physics.removeBody(walls[i])
	local shape = {-w/2, h2, w/2, h2, w/2, -h/2, -w/2, -h/2}
	physics.addBody(walls[i], 'static', {outline=shape})
	camera:insert(walls[i])
end
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

--[[
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
]]

local function movePg(event)
	local arrow = event.target
	local ciao = 'ciao'

	if event.phase == "began" then
		if arrow.name == "up" then
			hero:setLinearVelocity(0, -150)	
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


local preX = hero.x
local preY = hero.y

--[[local function moveCamera(event)
	local diffX = preX - hero.x
	local diffY = preY - hero.y

	if diffX > 0 then
		camera:moveTo({diffX, 0}, 0.2)
	else
		camera:moveTo({-diffX, 0}, 0.2)
	end

	if diffY > 0 then
		camera:moveTo(0, diffY)
	else
		camera:moveTo(0, -diffY)
	end

	preX = hero.x 
	preY = hero.y

	return true
end
]]--

local heroRadius=50
local mapBorderLeft = 0
local mapBorderRight = 4480
local mapBorderTop = 0
local mapBorderBottom = 2520
---- FARE IN QUALCHE MODO UN FOREACH CHE PRENDA TUTTI GLI ELEMENTI IN WALLS E LI SPOSTI CON setLinearVelocity ------
local walls=listTypes("wall")

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

arrowLeft:addEventListener("touch", movePg)
arrowRight:addEventListener("touch", movePg)
arrowDown:addEventListener("touch", movePg)
arrowUp:addEventListener("touch", movePg)
--Runtime:addEventListener("enterFrame", moveCamera)
Runtime:addEventListener("enterFrame", moveMap)
