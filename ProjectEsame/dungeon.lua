physics = require("physics")
physics.start()
physics.setGravity(0,0)

local tiled = require "com.ponywolf.ponytiled"
local json = require ("json")
local mapData = json.decodeFile(system.pathForFile("Maptiles/Map1.json"))
local map = tiled.new(mapData, "Maptiles/")

-- create group for non fixed obj (camera) and for fixed obj(control)
local camera= display.newGroup()
local control = display.newGroup()

-- create obj arrows and button for interaction
local arrowLeft = display.newImageRect(control,"/risorseGrafiche/risorseTmp_perTest/arrows/arrowLeft.png",80,80)
arrowLeft.x = 100
arrowLeft.y = display.contentHeight-150
arrowLeft.name = "left"

local arrowRight = display.newImageRect(control,"/risorseGrafiche/risorseTmp_perTest/arrows/arrowRight.png",80,80)
arrowRight.x = 260
arrowRight.y = display.contentHeight-150
arrowRight.name = "right"

local arrowUp = display.newImageRect(control,"/risorseGrafiche/risorseTmp_perTest/arrows/arrowUp.png",80,80)
arrowUp.x = 180
arrowUp.y = display.contentHeight-200
arrowUp.name = "up"

local arrowDown = display.newImageRect(control,"/risorseGrafiche/risorseTmp_perTest/arrows/arrowDown.png",80,80)
arrowDown.x = 180
arrowDown.y = display.contentHeight-100
arrowDown.name = "down"

--local button = display.newImageRect(control, "/risorseGrafiche/risorseTmp_perTest/arrows/redButton.png",80,80)
--button.x = display.contentCenterX
--button.y = display.contentCenterY
--button.name = "button"

local pg = display.newImageRect(camera, "/risorseGrafiche/risorseTmp_perTest/alienYellow.png", 124,108 )
pg.x= display.contentCenterX
pg.y= display.contentCenterY
pg.name= "pg"
physics.addBody(pg, "dynamic")

local function movePg(event)
	local arrow=event.target
	
	if event.phase == "began" then
        if arrow.name == "left" then
			pg:setLinearVelocity(-200, 0)
	    	 
		elseif arrow.name == "right" then
        	pg:setLinearVelocity(200,0)
            
        elseif arrow.name == "up" then
        	pg:setLinearVelocity(0,-200)
            
        elseif arrow.name == "down" then
        	pg:setLinearVelocity(0,200)    
	   end
    elseif event.phase == "moved" then
		if arrow.name == "left" then
			pg:setLinearVelocity(-200, 0)
	    	 
		elseif arrow.name == "right" then
        	pg:setLinearVelocity(200,0)
            
        elseif arrow.name == "up" then
        	pg:setLinearVelocity(0,-200)
            
        elseif arrow.name == "down" then
        	pg:setLinearVelocity(0,200)    
	   end
	
	elseif event.phase == "ended" then
			pg:setLinearVelocity(0,0)
	end
 	   	 
 	return true
end

-- add event to arrows and button
arrowLeft:addEventListener("touch", movePg)
arrowRight:addEventListener("touch", movePg)
arrowDown:addEventListener("touch", movePg)
arrowUp:addEventListener("touch", movePg)
