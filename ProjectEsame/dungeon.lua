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

local BG = audio.loadStream("RisorseAudio/BG.mp3")
local GO = audio.loadStream("RisorseAudio/GO.mp3")
audio.setVolume(0.05,{channel=1})
audio.setVolume(0.08,{channel=2})
audio.setVolume(0.23,{channel=3})
audio.setVolume(0.2,{channel=4})
-- local BGmusicChannel = audio.play(BG, {channel=1, loops=-1, fadein=5000})

local passi = audio.loadSound("RisorseAudio/footstep04.ogg")
local danno = audio.loadSound("RisorseAudio/dannopreso.mp3")
local aprichest = audio.loadSound("RisorseAudio/aprichest.mp3")
-- create group for non fixed obj (camera) and for fixed obj(control)
local camera= display.newGroup()
local control = display.newGroup()

local fontDir = "risorseGrafiche/font/fontpixel.ttf"
local fontCustom = native.newFont(fontDir, 12)

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

for i=1, 4 do
	hearts[i] = display.newImageRect(control,"risorseGrafiche/PG/heart.png",128,128)
	hearts[i].x = i * 100
	hearts[i].y = 50
	hearts[i]:scale(0.5, 0.5)
	life:insert(hearts[i])
end
--togliamo il cuore bonus che troverà poi nella stanza segreta
hearts[4].isVisible = false
table.remove(hearts, #hearts)
-------- OBJECTS IN CHESTS ---------
local key = display.newImageRect(control,"risorseGrafiche/PG/key.png",128,128)
key.x = display.contentWidth - 130
key.y = 70
key.isVisible =false

----------------- FIND & GIVE BODY/ANIMATION TO THE HERO ---------------------

--local button = display.newImageRect(control, "risorseGrafiche/risorseTmp_perTest/arrows/redButton.png",80,80)
--button.x = display.contentCenterX
--button.y = display.contentCenterY
--button.name = "button"
local hero = map:listTypes("hero")
local idle=map:findObject("idle")
local bodyShape={-5,-5, -5,5, 5,5, 5,-5}
local bossShape={-10,-10, -10,10, 10,10, 10,-10}
local bulletShape={-3,-3, -3,3, 3,3, 3,-3}
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
	
	if event.phase == "began" then
		local suonopassi = audio.play(passi,  {channel =2,loops=-1})
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
	audio.stop({channel=2})	
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

local function movePg_noAnim(event)
	local arrow=event.target
	
	if event.phase == "began" then
        if arrow.name == "left" then
			idle:setLinearVelocity(-50, 0)
		elseif arrow.name == "right" then
			idle:setLinearVelocity(50, 0)		
        elseif arrow.name == "up" then
			idle:setLinearVelocity(0,-50)			 
        elseif arrow.name == "down" then
			idle:setLinearVelocity(0, 50)
	   end
    elseif event.phase == "moved" then
		if arrow.name == "left" then
			idle:setLinearVelocity(-50, 0)	    	 
		elseif arrow.name == "right" then
			idle:setLinearVelocity(50, 0)            
        elseif arrow.name == "up" then
			idle:setLinearVelocity(0,-50)            
        elseif arrow.name == "down" then
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
end

local function movePg_arrows(event)
	local arrowKey=event.keyName
	if event.phase == "down" then
		audio.play(passi,  {channel=2,loops=-1})
        if arrowKey == "a" or arrowKey == "left" then
			chooseAnim(5)
			idle:setLinearVelocity(-50, 0)
			
		elseif arrowKey == "d" or arrowKey == "right" then
			chooseAnim(4)
			idle:setLinearVelocity(50, 0)
			
        elseif arrowKey == "w" or arrowKey == "up" then
			chooseAnim(2)
			idle:setLinearVelocity(0,-50)
			 
        elseif arrowKey == "s" or arrowKey == "down" then
			chooseAnim(3)
			idle:setLinearVelocity(0, 50)
			 
	   end

    elseif event.phase == "up" then
		audio.stop({channel=2})
		local i
		for i=2,5 do
			hero[i].isVisible=false
		end
			idle:setLinearVelocity(0,0)
			idle.isVisible=true
			 
	end
 	return true
end

local function movePg_arrows_noAnim(event)
	local arrowKey=event.keyName
	if event.phase == "down" then
        if arrowKey == "a" or arrowKey == "left" then
			idle:setLinearVelocity(-50, 0)
		elseif arrowKey == "d" or arrowKey == "right" then
			idle:setLinearVelocity(50, 0)
        elseif arrowKey == "w" or arrowKey == "up" then
			idle:setLinearVelocity(0,-50)
        elseif arrowKey == "s" or arrowKey == "down" then
			idle:setLinearVelocity(0, 50)
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
		
	elseif event.other == ladder[2] then
		
	end
end

createHero()
-- muovi il pg
 arrowLeft:addEventListener("touch",    movePg_noAnim)
arrowRight:addEventListener("touch",   movePg_noAnim)
 arrowDown:addEventListener("touch",   movePg_noAnim)
   arrowUp:addEventListener("touch",   movePg_noAnim)
   Runtime:addEventListener("key",     movePg_arrows_noAnim)


Runtime:addEventListener("enterFrame",moveCamera)
Runtime:addEventListener("enterFrame", moveAnimation)

ladder[1].collision = waitNTeleport
ladder[2].collision = waitNTeleport
ladder[1]:addEventListener("collision",ladder[1])
ladder[2]:addEventListener("collision",ladder[2])


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
---aaa
local function activateBat()
	local bats = map:listTypes("bat")
	local values = {4, 2, 6, 1}
	for i=1,#bats do
		--local velX = 0.7 * math.sin(values[i]*math.pi*math.random(0.3, 0.5)) + 0.75
		--local velY = 0.6 * math.cos(values[((i+1)%4) +1]*math.pi*math.random(0.3, 0.5)) + 0.75
		local velY = math.random(0.75,1)*0.01 +0.1
		local velX = math.random(0.75, 1)*0.01 +0.1
		bats[i]:scale(0.75, 0.75)
		physics.addBody(bats[i],"dynamic", {shape=bodyShape,bounce = 1})
		bats[i].isFixedRotation = true
		bats[i].collision = collisionEnemy
		bats[i].preCollision = preCollisionEnemy
		bats[i]:addEventListener("collision", bats[i])
		bats[i]:addEventListener("preCollision", bats[i])
		bats[i]:applyForce(velX, velY, bats[i].x, bats[i].y)
	end
end

local function activateSkeleton()
	local skeletons = map:listTypes("skeleton")

	for i=1,#skeletons do


	--local velX = math.random(0.5, 1)*0.02
	local velY = math.random(0.75,1)*0.004 -- se cambio qualcosa alcuni nemici smettono di muoversi e altri che prima non si muovevano si muovono



		physics.addBody(skeletons[i],"dynamic", {shape=bodyShape,bounce = 1})
		skeletons[i].isFixedRotation = true
		skeletons[i]:applyLinearImpulse(0, velY)
	end
end

local function activateDemons()
	local demons = map:listTypes("demon")

	for i=1,#demons do

		local velX = math.random(0.75, 1)*0.005
		--local velY = math.random(0.5,1)*0.02


		physics.addBody(demons[i],"dynamic", {shape=bodyShape,bounce = 1})
		demons[i].isFixedRotation = true
		demons[i]:applyLinearImpulse(velX, 0)
	end
end

local boss = map:findObject("boss")
--local bullet =map:findObject("bullet")
--physics.addBody(bullet,"dynamic", {shape=bulletShape,bounce = 1})
--bullet.isFixedRotation = true
--physics.addBody(bullet,"dynamic", {shape=bulletShape,bounce = 1})
--bullet.isFixedRotation = true

local function bossCollisionAvoidance(self, event)
	print(event.other.name)
	if event.other.name == "bullet" then
		event.contact.isEnabled = false
	end
	return true
end

local function launchBullet()
	print("lancio")
	--local boss = boss[1]
	local velX = 0.00006 * math.cos(boss.x - idle.x)
	local velY = 0.00005 * math.sin(boss.y - idle.y)

	
	if(idle.x > boss.x) then
		bullet.x = boss.x + 10
	else
		bullet.x = boss.x - 10
	end
	if(idle.y > boss.y) then
		bullet.y = boss.y + 10
	else
		bullet.y = boss.y - 10
	end

	bullet:applyLinearImpulse(velX, velY)
	return true
end

local function bulletCollision(self, event)
	print("collided")
	timer.performWithDelay(
		1000,
		launchBullet()
	)
end

local function bulletPrecollision(self, event)
	if event.other.name == "boss" then
		event.contact.isEnabled = false
	end
end

--bullet.preCollision = bulletPrecollision
--bullet.collision = bulletCollision
--bullet:addEventListener("collision", bullet)
--bullet:addEventListener("preCollision", bullet)
local function bossDash()
	local distXFromPg = boss.x - idle.x
	local distYFromPg = boss.y - idle.y
	local dist = 100
	--print("x:" .. distXFromPg .. " y:" .. distYFromPg)
	if((distXFromPg < dist and distXFromPg > -dist) and (distYFromPg > -dist and distYFromPg < dist)) then
		timer.performWithDelay(
			2000, 
			function()
				distXFromPg = boss.x - idle.x
				distYFromPg = boss.y - idle.y
				print("attack")
				boss:setLinearVelocity(-distXFromPg, -distYFromPg)
				timer.performWithDelay(
					1000, 
					function()
						print("rest")
						boss:setLinearVelocity(0,0)
					end
				)
			end
		)
	end
end
local function activateBoss()
	--lavorato con un ciclo perché se cercato con map:findObject('boss') non sappiamo perché la fisica ritorna errori
	--boss = boss[1]
	print("ciao")
	local velX = math.random(0.75, 1)*0.005
	local velY = math.random(0.5,1)*0.02
	physics.addBody(boss,"dynamic", {shape=bossShape,bounce = 0})
	boss.isFixedRotation = true
	--boss.preCollision = bulletBossCollisionAvoidance
	--boss:addEventListener("preCollision", boss)
	Runtime:addEventListener("enterFrame", bossDash)	
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
activateBoss()

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

local function activateAnimation(self, event)
	 arrowLeft:removeEventListener("touch",    movePg_noAnim)
	arrowRight:removeEventListener("touch",   movePg_noAnim)
	 arrowDown:removeEventListener("touch",   movePg_noAnim)
	   arrowUp:removeEventListener("touch",   movePg_noAnim)
	   Runtime:removeEventListener("key",     movePg_arrows_noAnim)
	arrowLeft:addEventListener("touch", movePg)
	arrowRight:addEventListener("touch", movePg)
	arrowDown:addEventListener("touch", movePg)
	arrowUp:addEventListener("touch", movePg)
	Runtime:addEventListener("key", movePg_arrows)
end


local function addHeart()
	if openChest[4].isVisible == false then
		table.insert(hearts, display.newImageRect(control,"risorseGrafiche/PG/heart.png",128,128))
		hearts[#hearts].x = #hearts * 100
		hearts[#hearts].y = 50
		hearts[#hearts]:scale(0.5, 0.5)
		print("Ti è stata donata una nuova vita! Ora hai: " .. #hearts .. "vite")
	end
end

------- BOX TEXT ---------

local box
local chestText
 
local function createText(case)
	box=display.newImageRect("risorseGrafiche/boxmessaggi.png",display.contentHeight+300,display.contentWidth/2)
	box.x=display.contentCenterX/2-50
	box.y=display.contentCenterY -80
	box.anchorX=0
	box.anchorY=0
	box.alpha=0
	transition.fadeIn( box, { time=500 })
	
	local quote

	if case == 1 then
		quote = "???: Giovane Padawan, ora sei finalmente pronto per \n muovere i tuoi primi passi. XD"
			
	elseif case == 2 then
		quote = "???: Sei stato fortunato,\n prendi questa vita extra ma non sarà facile \n uscire da questa montagna."
	elseif case == 3 then
		quote = "???: Hai trovato una chiave misteriosa. \n Chissà a cosa servirà..." 
	elseif case == 4 then
		if key.isVisible == false then
			quote = "???: Prova ad uscire se ci riesci, \n ritorna quando sarai degno."
		else
			quote = "Mr. B: Hai trovato la chiave. Posso finalmente dirti chi \n sono. \n Esci dalla montagna per scoprirlo."
		end
	elseif case == 5 then
		if key.isVisible == false then
			quote = "Idle: La porta è chiusa a chiave..."
		else
			quote = "Idle: La chiave funziona! Posso finalmente uscire."
		end
	end

	chestText = display.newText({text="",fontSize=25, font = fontDir})
	chestText:setFillColor(0,0,0)
	chestText.text = quote
	chestText.anchorX = 0
	chestText.anchorY = 0
	chestText.x = display.contentCenterX/2+80
	chestText.y = 550
	chestText.font = fontDir
end

------- OPEN THE CHEST ------
local function chestCollision(self, event)
	if event.phase == "began" and event.other.name == "idle" then
		audio.play(aprichest,{channel=4})
		if event.target.isChest ~= nil then
			
			if self.name == "chest1" then
				openChest[1].isVisible=true
				activateAnimation()
				createText(1)
				
			elseif self.name == "chest2" then
				openChest[2].isVisible=true
				key.isVisible = true
				createText(3)
				
			elseif self.name == "chest3" then
				openChest[3].isVisible=true
				createText(4)
			elseif self.name == "chest4" then
				addHeart()
				openChest[4].isVisible=true	
				createText(2)
			end
				
			
		end
	elseif event.phase == "ended" then
		transition.fadeOut( box, { time=500 })
		transition.fadeOut( chestText, { time=500 })
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
local function exit(self, event)
	if event.phase == "began" and event.other == idle then
		local other = event.other.name
		createText(5)
	elseif event.phase == "ended" and event.other == idle then
		transition.fadeOut( box, { time=500 })
		transition.fadeOut( chestText, { time=500 })
	end	
end

exitDoor.collision = exit
exitDoor:addEventListener("collision", exitDoor)


------- GESTIONE VITE -------
local countGO = 0 --TODO: usare un sistema migliore
local function gameOver()
	if #hearts == 0 then
		if countGO == 0 then
			local go = display.newImageRect("risorseGrafiche/PG/GameOver.png",412,78)
			go.x = display.contentCenterX
			go.y = -40
			go.alpha = 0
			local move_down = transition.to(go,{delay=420, time = 600,
                                    			y = display.contentCenterY,
								   				alpha = 1})
			countGO = countGO + 1
			audio.stop(BGmusicChannel)
			audio.stop({channel=2})
			audio.stop({channel=3})
			audio.play(GO, {channel=4,loops=0, 
			duration=2800
		})
			arrowLeft:removeEventListener("touch", movePg)
			arrowRight:removeEventListener("touch", movePg)
			arrowDown:removeEventListener("touch", movePg)
			arrowUp:removeEventListener("touch", movePg)
			Runtime:removeEventListener("key", movePg_arrows)
		end
	end
end

local function damage(self, event)
	
	if event.other.isEnemy ~= nil then
		
		display.remove(hearts[#hearts])
		hearts[#hearts] = nil
		print("The remaining lifes are: " .. #hearts)
		audio.play(danno,{channel=3})
	end
	Runtime:addEventListener("enterFrame", gameOver)
end

idle.postCollision = damage
idle:addEventListener("postCollision", idle)




Runtime:addEventListener("enterFrame", gameOver)

