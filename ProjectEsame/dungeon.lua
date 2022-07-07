physics = require("physics")
physics.start()
physics.setGravity(0,0)
physics.setDrawMode("hybrid")

local tiled = require "com.ponywolf.ponytiled"
local json = require ("json")
local mapData = json.decodeFile(system.pathForFile("Maptiles/Map2.json",system.ResourceDirectory))
local map = tiled.new(mapData, "Maptiles")
local scaleFactor = 3.5

local dragable = require "com.ponywolf.plugins.dragable"
map = dragable.new(map)

--local heroLib=require("herolib")

-- create group for non fixed obj (camera) and for fixed obj(control)
local camera= display.newGroup()
local control = display.newGroup()

map:scale(scaleFactor,scaleFactor)
map.x=50
camera:insert(map)


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

----------------- FIND & GIVE BODY/ANIMATION TO THE HERO ---------------------

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

local enemy= map:listTypes("enemy")
for i = 1,#enemy do
	physics.addBody(enemy[i],"dynamic")
end


local function moveAnimation()
	for i=2,5 do
		--idle.isVisible=false
		hero[i].x=idle.x
		hero[i].y=idle.y
	end 
end

local function chooseAnim(n)
	local i
	for i=1,5 do
		if n~=i then
			hero[i].isVisible=false
		end
	end
	hero[n].isVisible=true
end

-------------------- MOVE THE HERO ---------------------

local function movePg(event)
	local arrow=event.target
	
--[[]]	if event.phase == "began" then
        if arrow.name == "left" then
			--hero[5].isVisible=true --rende visibile sprite left
			chooseAnim(5)
			idle:setLinearVelocity(-50, 0)
			 
			--hero:play()

		elseif arrow.name == "right" then
        	--hero[4].isVisible=true
			chooseAnim(4)
			idle:setLinearVelocity(50, 0)
			 
			
            --hero:setSequence("Right")
			--hero:play()

        elseif arrow.name == "up" then
        	--hero[2].isVisible=true
			chooseAnim(2)
			idle:setLinearVelocity(0,-50)
			 
			
            --hero:setSequence("Back")
			--hero:play()

        elseif arrow.name == "down" then
        	--hero[3].isVisible=true
			chooseAnim(3)
			idle:setLinearVelocity(0, 50)
			 
			
			--hero:setSequence("Front")
			--hero:play()

	   end
    elseif event.phase == "moved" then
		if arrow.name == "left" then
			chooseAnim(5)
			idle:setLinearVelocity(-50, 0)
			 
	    	 
		elseif arrow.name == "right" then
			chooseAnim(4)
			idle:setLinearVelocity(50, 0)
			 
            
        elseif arrow.name == "up" then
			chooseAnim(2)
			idle:setLinearVelocity(0,-50)
			 
            
        elseif arrow.name == "down" then
			chooseAnim(3)
			idle:setLinearVelocity(0, 50)
			 
	   end
	
	elseif event.phase == "ended" then
		local i
		for i=2,5 do
			hero[i].isVisible=false
		end
			idle:setLinearVelocity(0,0)
			hero[1].isVisible = true
			idle.isVisible=true
		
	end
 	   	 
 	return true
end

local function movePg_arrows(event)
	local arrowKey=event.keyName
	
	if event.phase == "began" then
        if arrowKey == "left" then
			--hero[5].isVisible=true --rende visibile sprite left
			chooseAnim(5)
			idle:setLinearVelocity(-50, 0)
			moveAnimation()
			--hero:play()

		elseif arrowKey == "right" then
        	--hero[4].isVisible=true
			chooseAnim(4)
			idle:setLinearVelocity(50, 0)
			moveAnimation()
			
            --hero:setSequence("Right")
			--hero:play()

        elseif arrowKey == "up" then
        	--hero[2].isVisible=true
			chooseAnim(2)
			idle:setLinearVelocity(0,-50)
			moveAnimation()
			
            --hero:setSequence("Back")
			--hero:play()

        elseif arrowKey == "down" then
        	--hero[3].isVisible=true
			chooseAnim(3)
			idle:setLinearVelocity(0, 50)
			moveAnimation()
	   end
    end
 	return true
end

--------------------- MOVE THE CAMERA --------------------------------

local preX = idle.x
local preY = idle.y

local function moveCamera2(event)
	--calcola la diff di pos della camera (*3.5 che è lo scaling)
	local diffX = (preX - idle.x)*scaleFactor
	local diffY = (preY - idle.y)*scaleFactor
	--aggiorna il posizionamento della camera
	camera.x = camera.x + diffX
	camera.y = camera.y + diffY
	preX = idle.x 
	preY = idle.y

	return true
end

local ladder=map:listTypes("ladder")

local function teleport(event)
	print(event.target)
	if event.target.name == "ladder1" then
		idle.x= ladder[2].x +100
		idle.y=ladder[2].y
		
	else 
		idle.x=ladder[1].x
		idle.y=ladder[1].y -25
	end
end


---------------------------------- COLLISION -------------------------------------

local function waitNTeleport(event)
	timer.performWithDelay(1500, teleport)
end

local function testColl(event)
	if event.other == ladder[1] then
		print("a")
	elseif event.other == ladder[2] then
		print("b")
	end
end
-- add event to arrows and button

------------VERSIONE 2 --------------
--[[
local function onCollision(self,event)
	local collidedObj = event.other
	local collidedObjTop= collidedObj.y-collidedObj.height/2
	local heroBottom=hero.y+16


	--when a collision between hero and another objects starts...
	if event.phase=="began" then
		print("CollidedObj start:"..collidedObj.type)
		-- Collision hero-cat
		if collidedObj.name == "ladder1" then
			
			idel.x= 
		end	
		-- Collision hero-door
		if collidedObj.name == "door" then
			--BEGIN INSERT CODE
			-- 1) pause the background music
			audio.pause(audioData.bgMusic)
			-- 2) play the exit sound fx
			audio.play(audioData.soundTable.exit)
			-- 3) pause the hero sprite animation
			hero:pause()
			-- 4) remove the tapListener controlHero (used to control the hero movements)
			Runtime:removeEventListener("tap", controlHero)
			-- 5) pause the physics
			physics.pause()
			--END INSERT CODE
		end	 
		-- Collision hero-egg
		if collidedObj.name == "egg" then
			--BEGIN INSERT CODE
			-- 1) make the collided egg invisible
			self.isVisible=false
			-- 2) play the bonus sound fx
			audio.play(audioData.soundTable.bonus)
			--END INSERT CODE
		end		
		-- Collision hero-ladderStart 	 
		if collidedObj.type=="ladderStart" then
			--BEGIN INSERT CODE
			--1) set isOnLadder field of self to true (i.e. the hero is on the ladder)
			self.isOnLadder=true
			--2) set the hero animation sequence to climbUp 
			self:setSequence("Back")
			--3) play the animation sequence
			self:play()
			--4) stop the hero by setting to 0 its linear velocity
			self:setLinearVelocity(0,0)
			--5) move the hero up through the ladder using the following transition
			transition.moveTo(self,{y=self.y-(32*collidedObj.ladderLength),time=800})
			--6) play the ladder soundFx
			audio.play(audioData.soundTable.ladder)
			--END INSERT CODE 	
		end
		-- Collision hero-barrier
		if (collidedObj.type=="barrier") then 
		  --START INSERT CODE
		  -- 1) Invert the hero speedDir direction 
		  self.speedDir=-self.speedDir
		  --END INSERT CODE
		  --set the new penguin speed
		  self:setLinearVelocity(self.speedDir*self.speed,0)
		  -- horizontally flip the penguin sprite 
			self.xScale = self.speedDir
		  -- play the wall soundfx
		  audio.play(audioData.soundTable.wall)
		end  
		-- Collision hero-platform
		if collidedObj.type=="platform" then
			if event.contact.isTouching == true and heroBottom<=collidedObjTop then
				--BEGIN INSERT CODE
				--1) set jumpAllowed field of self to true
				hero.jumpAllowed=true
				--2) set the hero animation sequence to walk
				hero:setSequence('Right')
				--3) play the animation sequence
				hero:play()
				--4) set the hero linear velocity to (self.speedDir*self.speed,0)
				hero:setLinearVelocity(self.speedDir*self.speed,0)
				--END INSERT CODE
			end	
		end		
	 end
	 -- when the collision between hero and the end of the ladder ends, hero starts walking again
	 -- and jumps are forbidden
	 if event.phase=="ended" then
		 print("CollidedObj end:"..collidedObj.type)
		 if collidedObj.name=="ladderEnd" then
			 hero.isOnLadder = false
			 self.jumpAllowed = false
			 self:setSequence("Left")
			 self:play()
			 self:setLinearVelocity(self.speedDir*self.speed,0)	 
	 -- when collision between hero and platform ends, hero is jumping or falling,
	 -- hence we disable jumps. 	 
		 elseif collidedObj.type == "platform" then
				 self.jumpAllowed = false	 	
	 -- when collision hero-egg terminates, we remove the egg object from the memory, if any.		 
		 elseif collidedObj.name == "egg" then
			 if collidedObj~= nil then
				display.remove(collidedObj)
				collidedObj=nil
			 end	
		end		 
	 end	 
end
]]

createHero()
arrowLeft:addEventListener("touch", movePg)
arrowRight:addEventListener("touch", movePg)
arrowDown:addEventListener("touch", movePg)
arrowUp:addEventListener("touch", movePg)

--fromVeeko says: ho provato a scommentare il movecamera ma tanto non funge
Runtime:addEventListener("enterFrame",moveCamera2)
Runtime:addEventListener("enterFrame", moveAnimation)
--Runtime:addEventListener("key", movePg_arrows)


--ladder[1]:addEventListener("collision",waitNTeleport)
--ladder[2]:addEventListener("collision",waitNTeleport)

idle.collision = waitNTeleport
idle:addEventListener("collision", idle)

--[[
SE DIMINUISCO VELOCITà PG DIMINUISCE ANCHE LA VELOCITà DEL MOVIMENTO DELLA MAPPA 
MENTRE SE TOLGO LA SCALE *3.5 ALLA MAPPA PG E MAPPA SI SPOSTANO ALLA STESSA VELOCITà 
PERCHè???????
]]--