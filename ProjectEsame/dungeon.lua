physics = require("physics")
physics.start()
physics.setGravity(0,0)
physics.setDrawMode("hybrid")

local tiled = require "com.ponywolf.ponytiled"
local json = require ("json")
local mapData = json.decodeFile(system.pathForFile("Maptiles/Map2.json",system.ResourceDirectory))
local map = tiled.new(mapData, "Maptiles")

local dragable = require "com.ponywolf.plugins.dragable"
map = dragable.new(map)

--local heroLib=require("herolib")

-- create group for non fixed obj (camera) and for fixed obj(control)
local camera= display.newGroup()
local control = display.newGroup()

map:scale(3.5,3.5)
map.x =-150
map.y=-100
camera:insert(map)
print(camera.x)
print(camera.y)

local mapBorderLeft = 0
local mapBorderRight = 1280
local mapBorderTop = 0
local mapBorderBottom = 720

-- create obj arrows and button for interaction
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

--local button = display.newImageRect(control, "risorseGrafiche/risorseTmp_perTest/arrows/redButton.png",80,80)
--button.x = display.contentCenterX
--button.y = display.contentCenterY
--button.name = "button"


local hero = map:findObject("pg")
--hero:toFront()
--local hero=heroLib.new()

--per debug metto l'eroe direttamente qua
--[[
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
--local hero = display.newSprite(heroSheet,heroSeqs)
--local heroShape={-6,0,6,0,-6,16,6,16}
--physics.addBody(hero, "dynamic", heroShape)
--hero:scale(2,2)

--hero.x = display.contentCenterX
--hero.y = display.contentCenterY
--print(hero.x)
--print(hero.y)
]]--
--hero.x= display.contentCenterX
--hero.y= display.contentCenterY
--hero.name= "hero"
physics.addBody(hero, "dynamic")
hero.isFixedRotation=true

--heroLib.init(hero,640,360,false)
--heroLib.activate(hero)

local boxUp = map:findObject("boxUp")
--boxUp:toFront()


local function movePg(event)
	local arrow=event.target
	
	if event.phase == "began" then
        if arrow.name == "left" then
			--hero:setLinearVelocity(-100, 0)
			--hero:setSequence("Left")
			--hero:play()

		elseif arrow.name == "right" then
        	hero:setLinearVelocity(100,0)
            --hero:setSequence("Right")
			--hero:play()

        elseif arrow.name == "up" then
        	hero:setLinearVelocity(0,-100)
            --hero:setSequence("Back")
			--hero:play()

        elseif arrow.name == "down" then
        	hero:setLinearVelocity(0,100)
			--hero:setSequence("Front")
			--hero:play()

	   end
    elseif event.phase == "moved" then
		if arrow.name == "left" then
			hero:setLinearVelocity(-100, 0)
			--hero:pause()
			--hero:setSequence("Left")
			--hero:play()
			print(hero.x)
			print(hero.y)
	    	 
		elseif arrow.name == "right" then
        	hero:setLinearVelocity(100,0)
			--hero:pause()
            --hero:setSequence("Right")
			--hero:play()
            
        elseif arrow.name == "up" then
        	hero:setLinearVelocity(0,-100)
			--hero:pause()
            --hero:setSequence("Back")
			--hero:play()
            
        elseif arrow.name == "down" then
        	hero:setLinearVelocity(0,100)
			--hero:pause()
			--hero:setSequence("Front")
			--hero:play() 
	   end
	
	elseif event.phase == "ended" then
			hero:setLinearVelocity(0,0)
			--hero:pause()
	end
 	   	 
 	return true
end
------- FUNZIONE PER MOVIMENTO CAMERA DA METTERE A POSTO -------
local function moveCamera(event)

	
	local offsetX = 70
	local offsetY = 70
	
	local displayLeft = -camera.x
	local displayTop = -camera.y
	
	local nonScrollingWidth =  display.contentWidth- 140
	local nonScrollingHeight = display.contentHeight- 140
	
	
	if hero.x >= mapBorderLeft+offsetX and hero.x <= mapBorderRight - offsetX then
		  
		  if hero.x>displayLeft+nonScrollingWidth then
	        	    camera.x = -hero.x + nonScrollingWidth
	      elseif hero.x < displayLeft+offsetX then
	            	camera.x = -hero.x + offsetX	
	      end
	end
    
 	if hero.y >= mapBorderTop+offsetY 
 	   and hero.y <= mapBorderBottom - offsetY then
	    
	    if hero.y>displayTop+nonScrollingHeight then
		    camera.y = -hero.y + nonScrollingHeight
		elseif hero.y < displayTop+offsetY then
		  camera.y = -hero.y + offsetY	
	    end	 
	end	 
	
	camera.x = hero.x
	camera.y = hero.y	
	return true	
end
--[[
local function moveMap(event)
	local arrow=event.target
	
	if event.phase == "began" then
        if arrow.name == "left" then
			camera.x = camera.x + 100
			hero.x = hero.x - 100
			hero:setSequence("Left")
			hero:play()

		elseif arrow.name == "right" then
        	camera.x = camera.x - 100
			hero.x = hero.x + 100
            hero:setSequence("Right")
			hero:play()

        elseif arrow.name == "up" then
        	camera.y = camera.y + 100
			hero.y = hero.y - 100
            hero:setSequence("Back")
			hero:play()

        elseif arrow.name == "down" then
        	camera.y = camera.y - 100
			hero.y = hero.y + 100
			hero:setSequence("Front")
			hero:play()

	   end
    elseif event.phase == "moved" then
		if arrow.name == "left" then
			camera.x = camera.x + 100
			hero.x = hero.x - 100
			hero:pause()
			hero:setSequence("Left")
			hero:play()
			print(hero.x)
			print(hero.y)
	    	 
		elseif arrow.name == "right" then
        	camera.x = camera.x - 100
			hero.x = hero.x + 100
			hero:pause()
            hero:setSequence("Right")
			hero:play()
            
        elseif arrow.name == "up" then
        	camera.y = camera.y + 100
			hero.y = hero.y - 100
			hero:pause()
            hero:setSequence("Back")
			hero:play()
            
        elseif arrow.name == "down" then
        	camera.y = camera.y - 100
			hero.y = hero.y + 100
			hero:pause()
			hero:setSequence("Front")
			hero:play() 
	   end
	
	elseif event.phase == "ended" then
			hero:setLinearVelocity(0,0)
			hero:pause()
	end
 	   	 
 	return true
end
--]]

-- add event to arrows and button
arrowLeft:addEventListener("touch", movePg)
arrowRight:addEventListener("touch", movePg)
arrowDown:addEventListener("touch", movePg)
arrowUp:addEventListener("touch", movePg)

--arrowLeft:addEventListener("touch", moveMap)
--arrowRight:addEventListener("touch", moveMap)
--arrowDown:addEventListener("touch", moveMap)
--arrowUp:addEventListener("touch", moveMap)
--fromVeeko says: ho provato a scommentare il movecamera ma tanto non funge
--Runtime:addEventListener("enterFrame",moveCamera)

