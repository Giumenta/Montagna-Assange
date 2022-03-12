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

camera:insert(map)
map.x =200
map.y=100
print(camera.x)
print(camera.y)

local mapBorderLeft = 0
local mapBorderRight = 4480
local mapBorderTop = 0
local mapBorderBottom = 2520

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
local hero = map:listTypes("hero")
local idle=map:findObject("idle")
function createHero()
	physics.addBody(idle,"dynamic",{bounce=0})
	idle.isFixedRotation=true
	local i
	for i=2,5 do 
		--lettura lista type hero da destra a sinistra quindi primo elemento è numero
		
		hero[i].isVisible=false
		hero[i].x=idle.x
		hero[i].y=idle.y
	end
end




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


--heroLib.init(hero,640,360,false)
--heroLib.activate(hero)

local function moveAnimation()
	for i=2,5 do
		idle.isVisible=false
		hero[i].x=idle.x
		hero[i].y=idle.y
	end 
end
local function chooseAnim(n)
	local i
	for i=2,5 do
		if n~=i then
			hero[i].isVisible=false
		end
	end
	hero[n].isVisible=true
end

local function movePg(event)
	local arrow=event.target
	
--[[]]	if event.phase == "began" then
        if arrow.name == "left" then
			--hero[5].isVisible=true --rende visibile sprite left
			chooseAnim(5)
			idle:setLinearVelocity(-50, 0)
			moveAnimation()
			--hero:play()

		elseif arrow.name == "right" then
        	--hero[4].isVisible=true
			chooseAnim(4)
			idle:setLinearVelocity(50, 0)
			moveAnimation()
			
            --hero:setSequence("Right")
			--hero:play()

        elseif arrow.name == "up" then
        	--hero[2].isVisible=true
			chooseAnim(2)
			idle:setLinearVelocity(0,-50)
			moveAnimation()
			
            --hero:setSequence("Back")
			--hero:play()

        elseif arrow.name == "down" then
        	--hero[3].isVisible=true
			chooseAnim(3)
			idle:setLinearVelocity(0, 50)
			moveAnimation()
			
			--hero:setSequence("Front")
			--hero:play()

	   end
    elseif event.phase == "moved" then
		if arrow.name == "left" then
			--hero[5].isVisible=true --rende visibile sprite left
			chooseAnim(5)
			idle:setLinearVelocity(-50, 0)
			moveAnimation()
			--hero:pause()
			--hero:setSequence("Left")
			--hero:play()
			print(hero.x)
			print(hero.y)
	    	 
		elseif arrow.name == "right" then
        	--hero[4].isVisible=true
			chooseAnim(4)
			idle:setLinearVelocity(50, 0)
			moveAnimation()
			--hero:pause()
            --hero:setSequence("Right")
			--hero:play()
            
        elseif arrow.name == "up" then
        	--hero[2].isVisible=true
			chooseAnim(2)
			idle:setLinearVelocity(0,-50)
			moveAnimation()
			--hero:pause()
            --hero:setSequence("Back")
			--hero:play()
            
        elseif arrow.name == "down" then
        	--hero[3].isVisible=true
			chooseAnim(3)
			idle:setLinearVelocity(0, 50)
			moveAnimation()
			--hero:pause()
			--hero:setSequence("Front")
			--hero:play() 
	   end
	
	elseif event.phase == "ended" then
		local i
		for i=2,5 do
			hero[i].isVisible=false
			--hero[i].x=idle.x
			--hero[i].y=idle.y
		end
			idle:setLinearVelocity(0,0)
			idle.isVisible=true
		
	end
 	   	 
 	return true
end
------- FUNZIONE PER MOVIMENTO CAMERA DA METTERE A POSTO -------
local function moveCamera(event)

	
	local offsetX = 100
	local offsetY = 100
	
	local displayLeft = -camera.x
	local displayTop = -camera.y
	
	local nonScrollingWidth =  display.contentWidth- 100
	local nonScrollingHeight = display.contentHeight- 100
	
	
	if idle.x >= mapBorderLeft+offsetX and idle.x <= mapBorderRight - offsetX then
		  
		  if idle.x>displayLeft+nonScrollingWidth then
	        	    camera.x = -idle.x + nonScrollingWidth
	      elseif idle.x < displayLeft+offsetX then
	            	camera.x = -idle.x + offsetX	
	      end
	end
    
 	if idle.y >= mapBorderTop+offsetY and idle.y <= mapBorderBottom - offsetY then
	    
	    if idle.y>displayTop+nonScrollingHeight then
		    camera.y = -idle.y + nonScrollingHeight
		elseif idle.y < displayTop+offsetY then
		  camera.y = -idle.y + offsetY	
	    end	 
	end	 
	
	camera.x = -idle.x
	camera.y = -idle.y	
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

createHero()
arrowLeft:addEventListener("touch", movePg)
arrowRight:addEventListener("touch", movePg)
arrowDown:addEventListener("touch", movePg)
arrowUp:addEventListener("touch", movePg)

--arrowLeft:addEventListener("touch", moveMap)
--arrowRight:addEventListener("touch", moveMap)
--arrowDown:addEventListener("touch", moveMap)
--arrowUp:addEventListener("touch", moveMap)
--fromVeeko says: ho provato a scommentare il movecamera ma tanto non funge
Runtime:addEventListener("enterFrame",moveCamera)



--[[
SE DIMINUISCO VELOCITà PG DIMINUISCE ANCHE LA VELOCITà DEL MOVIMENTO DELLA MAPPA 
MENTRE SE TOLGO LA SCALE *3.5 ALLA MAPPA PG E MAPPA SI SPOSTANO ALLA STESSA VELOCITà 
PERCHè???????
]]--