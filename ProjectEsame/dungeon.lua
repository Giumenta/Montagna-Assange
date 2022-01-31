physics = require("physics")
physics.start()
physics.setGravity(0,0)
physics.setDrawMode("hybrid")

local tiled = require "com.ponywolf.ponytiled"
local json = require ("json")
local mapData = json.decodeFile(system.pathForFile("Maptiles/Map1.json",system.ResourceDirectory))
local map = tiled.new(mapData, "Maptiles")

-- create group for non fixed obj (camera) and for fixed obj(control)
local camera= display.newGroup()
local control = display.newGroup()

map:scale(3.5,3.5)
map.x =-150
map.y=-100
camera:insert(map)

--local mapBorderLeft = 0
--local mapBorderRight = 1280
--local mapBorderTop = 0
--local mapBorderBottom = 720

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

--local hero = display.newImageRect(camera, "risorseGrafiche/risorseTmp_perTest/alienYellow.png", 124,108 )
local hero = map:findObject("pg")
hero:toFront()
hero.isFixedRotation=true
print(hero.x)
print(hero.y)
--hero.x= display.contentCenterX
--hero.y= display.contentCenterY
--hero.name= "hero"
--physics.addBody(hero, "dynamic")

local function movePg(event)
	local arrow=event.target
	
	if event.phase == "began" then
        if arrow.name == "left" then
			hero:setLinearVelocity(-75, 0)
	    	 
		elseif arrow.name == "right" then
        	hero:setLinearVelocity(75,0)
            
        elseif arrow.name == "up" then
        	hero:setLinearVelocity(0,-75)
            
        elseif arrow.name == "down" then
        	hero:setLinearVelocity(0,75)    
	   end
    elseif event.phase == "moved" then
		if arrow.name == "left" then
			hero:setLinearVelocity(-75, 0)
	    	 
		elseif arrow.name == "right" then
        	hero:setLinearVelocity(75,0)
            
        elseif arrow.name == "up" then
        	hero:setLinearVelocity(0,-75)
            
        elseif arrow.name == "down" then
        	hero:setLinearVelocity(0,75)    
	   end
	
	elseif event.phase == "ended" then
			hero:setLinearVelocity(0,0)
	end
 	   	 
 	return true
end
------- FUNZIONE PER MOVIMENTO CAMERA DA METTERE A POSTO -------



-- add event to arrows and button
arrowLeft:addEventListener("touch", movePg)
arrowRight:addEventListener("touch", movePg)
arrowDown:addEventListener("touch", movePg)
arrowUp:addEventListener("touch", movePg)

--Runtime:addEventListener("enterFrame",moveCamera)


--local dragable = require "com.ponywolf.plugins.dragable"
--map = dragable.new(map)