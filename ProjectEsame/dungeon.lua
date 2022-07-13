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

---------- CREATE LIFES CONTROL ---------
local life=display.newGroup()
local hearts = {}

for i=1, 3 do
	hearts[i] = display.newImageRect(control,"risorseGrafiche/PG/heart.png",128,128)
	hearts[i].x = i * 100
	hearts[i].y = 50
	life:insert(hearts[i])
end

table.insert(hearts, shield)
print("number of life:".. #hearts)
-------- OBJECTS IN CHESTS ---------

local shield = display.newImageRect(control,"risorseGrafiche/PG/shield.png",128,128)
shield.isVisible=false

local key = display.newImageRect(control,"risorseGrafiche/PG/key.png",128,128)
key.x = display.contentWidth - 100
key.y = display.contentHeight - 100
key.isVisible =false

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
		hero[i].isVisible=false
		hero[i].x=idle.x
		hero[i].y=idle.y
	end
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


-----------CHEST---------
local closedChest=map:listTypes("chest")
local openChest=map:listTypes("openChest")

local chest1 = map:findObject("chest1")
local chest2 = map:findObject("chest2")
local chest3 = map:findObject("chest3")
local chest4 = map:findObject("chest4")

for i= 1,#openChest do
	local name = "chest" .. i
	local chest=map:findObject(name)
	openChest[i].x = chest.x
	openChest[i].y = chest.y
	openChest[i].isVisible=false
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
	if event.phase == "down" then
        if arrowKey == "a" or arrowKey == "left" then
			chooseAnim(5)
			idle:setLinearVelocity(-50, 0)
			moveAnimation()
		elseif arrowKey == "d" or arrowKey == "right" then
			chooseAnim(4)
			idle:setLinearVelocity(50, 0)
			moveAnimation()
        elseif arrowKey == "w" or arrowKey == "up" then
			chooseAnim(2)
			idle:setLinearVelocity(0,-50)
			moveAnimation()
        elseif arrowKey == "s" or arrowKey == "down" then
			chooseAnim(3)
			idle:setLinearVelocity(0, 50)
			moveAnimation()
	   end
    elseif event.phase == "up" then
		local i
		for i=2,5 do
			hero[i].isVisible=false
		end
			idle:setLinearVelocity(0,0)
			idle.isVisible=true
	end
 	return true
end

--------------------- MOVE THE CAMERA --------------------------------

local preX = idle.x
local preY = idle.y

local function moveCamera(event)
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




---------------------------------- COLLISION -------------------------------------
-- Usiamo .performWithDelay in quanto è l'unico modo per modificare i valori x e y di un oggetto per una limitazione di box2D
-- abbiamo notato che definendo la funzione 'teleport' e richiamandola in .performWithDelay solar3D ci dava 
--come errore "ERROR: Cannot translate an object before collision is resolved." mentre scrivendola direttamente 
--come parametro di .performWithDelay l'esercizio funziona


local function waitNTeleport(self, event)
	local target = event.target.name
	local other = event.other.name
	print("target: " .. target .. " | other: " .. other)
	if event.phase == "began" then 
		if other == "idle" then
			timer.performWithDelay(
				500, 
				function()
					 if target == "ladder1" then
						idle.x= ladder[2].x +25
						idle.y=ladder[2].y				
					else 
						idle.x=ladder[1].x
						idle.y=ladder[1].y -25
					end
				end, 
				1)
		end
	end
end

local function testColl(event)
	if event.other == ladder[1] then
		print("a")
	elseif event.other == ladder[2] then
		print("b")
	end
end

createHero()
-- muovi il pg
arrowLeft:addEventListener("touch", movePg)
arrowRight:addEventListener("touch", movePg)
arrowDown:addEventListener("touch", movePg)
arrowUp:addEventListener("touch", movePg)
Runtime:addEventListener("key", movePg_arrows)

Runtime:addEventListener("enterFrame",moveCamera)
Runtime:addEventListener("enterFrame", moveAnimation)

ladder[1].collision = waitNTeleport
ladder[2].collision = waitNTeleport
ladder[1]:addEventListener("collision",ladder[1])
ladder[2]:addEventListener("collision",ladder[2])

--idle.collision = waitNTeleport
--idle:addEventListener("collision", idle)

--[[
SE DIMINUISCO VELOCITà PG DIMINUISCE ANCHE LA VELOCITà DEL MOVIMENTO DELLA MAPPA 
MENTRE SE TOLGO LA SCALE *3.5 ALLA MAPPA PG E MAPPA SI SPOSTANO ALLA STESSA VELOCITà 
PERCHè???????
]]--

--mi memorizzo i confini della stanza 1 (pipistrelli)

local room1_wallUp = map:findObject("wallUp1")
local room1_wallLeft = map:findObject("wallLeft1")
local room1_wallRight = map:findObject("wallRight1")
local room1_wallBottom = map:findObject("wallBottom1")

local function activateBat()
	local bats = map:listTypes("bat")

	for i=1,#bats do
		local velX = math.random(0.5, 1)*0.02
		local velY = math.random(0.5,1)*0.02

		physics.addBody(bats[i],"dynamic", {bounce = 1})
		bats[i].isFixedRotation = true
		-- bats[i]:applyLinearImpulse(velX, velY)
	end
end

local function activateSkeleton()
	local skeletons = map:listTypes("skeleton")

	for i=1,#skeletons do
		--local velX = math.random(0.5, 1)*0.02
		local velY = math.random(0.5,1)*0.01

		physics.addBody(skeletons[i],"dynamic", {bounce = 1})
		skeletons[i].isFixedRotation = true
		skeletons[i]:applyLinearImpulse(0, velY)
	end
end

local function activateDemons()
	local demons = map:listTypes("demon")

	for i=1,#demons do
		local velX = math.random(0.5, 1)*0.01
		--local velY = math.random(0.5,1)*0.02

		physics.addBody(demons[i],"dynamic", {bounce = 1})
		demons[i].isFixedRotation = true
		demons[i]:applyLinearImpulse(velX, 0)
	end
end

local function isInTheRoom(objX, objY, wallTop, wallRight, wallBottom, wallLeft)
	if(objX < wallLeft.x or objX > wallRight.x) then
		return false
	end
	if(objY < wallTop.y or objY > wallBottom.y) then
		return false
	end
	return true 
end

activateBat()
activateSkeleton()
activateDemons()
--aggancio i muri invisibili della stanza dei pipistrelli

local invisibleWall_batRoom = map:listTypes("invisibleWall")

local function invisibleWallPreCollision(self, event)
	if event.other.name == "idle" then
		event.contact.isEnabled = false
	end
	return true
end

for i=1,#invisibleWall_batRoom do
	invisibleWall_batRoom[i].preCollision = invisibleWallPreCollision
	invisibleWall_batRoom[i]:addEventListener("preCollision", invisibleWall_batRoom[i])
end


------- OPEN THE CHEST ------
local function chestCollision(self, event)
	print("The trigger of the chest is: " .. event.other.name)
	
	if event.target.isChest ~= nil then
		if event.other.name == "idle" then
				if self.name == "chest1" then
					openChest[1].isVisible=true

				elseif self.name == "chest2" then
					openChest[2].isVisible=true
					print("YOU FIND A KEY")
					key.isVisible = true

				elseif self.name == "chest3" then
					openChest[3].isVisible=true

				elseif self.name == "chest4" then
					openChest[4].isVisible=true
					--table.insert(hearts, shield)
					--shield.isVisible=true
					--print(#hearts)
				end
			
		end
	end
end

 chest1.collision = chestCollision
 chest2.collision = chestCollision
 chest3.collision = chestCollision
 chest4.collision = chestCollision
 chest1:addEventListener("collision",chest1)
 chest2:addEventListener("collision",chest2)
 chest3:addEventListener("collision",chest3)
 chest4:addEventListener("collision",chest4)
 

---------- EXIT THE DUNGEON -------
local exitDoor = map:findObject("doorExit")
print(exitDoor)
local function exit(self, event)
	--local target = event.target.name
	local other = event.other.name
	if other == "idle" then
		if key.isVisible == true then
			print("YOU WIN")
		else
			print("IT'S LOCKED, FIND THE KEY")
		end
	end 
end

exitDoor.collision = exit
exitDoor:addEventListener("collision", exitDoor)

------- GESTIONE VITE -------
local countGO = 0 --TODO: usare un sistema migliore
local function gameOver()
	if #hearts == 0 then
		if countGO == 0 then
			print("GAME OVER")
		--hearts:removeSelf()
		--hearts = nil
			local go = display.newImageRect("risorseGrafiche/PG/GameOver.png",412,78)
			go.x = display.contentCenterX
			go.y = -40
			go.alpha = 0
			local move_down = transition.to(go,{delay=420, time = 600,
                                    			y = display.contentCenterY,
								   				alpha = 1})
			countGO = countGO + 1
		end
	end
end

local function damage(self, event)
	-- print("test")
	print("Idle collided with: " .. event.other.name)
	
	if event.other.isEnemy ~= nil then
		
		display.remove(hearts[#hearts])
		hearts[#hearts] = nil
		print("The remaining lifes are: " .. #hearts)
		--table.remove(hearts, #hearts)
		--hearts[#hearts].isVisible = false
	end
	Runtime:addEventListener("enterFrame", gameOver)
end

idle.postCollision = damage
idle:addEventListener("postCollision", idle)




Runtime:addEventListener("enterFrame", gameOver)


-- aggiungere scudo quando si apre il forziere nascosto, in modo che venga aggiunto solo quando lo si apre la prima volta,
-- aggiungerlo a tabella hearts (???)
-- 