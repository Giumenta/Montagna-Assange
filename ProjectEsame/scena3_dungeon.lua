
local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
local background  -- variable that stores the background image 
local tiled      --  da tenere?
local json  -- da tenere?
local mapData -- da tenere?
local map    --da tenere?
local scaleFactor -- da tenere?
local dragable -- da tenere?
local GO --game over
local passi
local danno
local aprichest
local camera
local control
local fontDir 
local fontCustom
local mapBorderLeft 
local mapBorderRight 
local mapBorderTop 
local mapBorderBottom 
local arrowLeft
local arrowRight
local arrowUp
local arrowDown
local life
local hearts
local key
local hero
local idle
local bodyShape
local closedChest
local openChest
local chest1
local chest2
local chest3
local chest4
local preX
local preY 
local ladder
local room1_wallUp
local room1_wallLeft
local room1_wallRight
local room1_wallBottom
local invisibleWall_batRoom
local box
local chestText
local exitDoor
local countGO
--funzioni

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

local function movePg(event)
	local arrow=event.target
	
	if event.phase == "began" then
        if arrow.name == "left" then
			chooseAnim(5)
			idle:setLinearVelocity(-50, 0)
			audio.play(passi,  {loops=-1})
		elseif arrow.name == "right" then
			chooseAnim(4)
			idle:setLinearVelocity(50, 0)
			audio.play(passi,  {loops=-1})
		
        elseif arrow.name == "up" then
			chooseAnim(2)
			idle:setLinearVelocity(0,-50)
			audio.play(passi,  {loops=-1})
			 
        elseif arrow.name == "down" then
			chooseAnim(3)
			idle:setLinearVelocity(0, 50)
			audio.play(passi,  {loops=-1})
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
		audio.pause(passi)	 
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
        if arrowKey == "a" or arrowKey == "left" then
			chooseAnim(5)
			idle:setLinearVelocity(-50, 0)
			audio.play(passi,  {loops=-1})
			
		elseif arrowKey == "d" or arrowKey == "right" then
			chooseAnim(4)
			idle:setLinearVelocity(50, 0)
			audio.play(passi,  {loops=-1})
			
        elseif arrowKey == "w" or arrowKey == "up" then
			chooseAnim(2)
			idle:setLinearVelocity(0,-50)
			audio.play(passi,  {loops=-1})
			 
        elseif arrowKey == "s" or arrowKey == "down" then
			chooseAnim(3)
			idle:setLinearVelocity(0, 50)
			audio.play(passi,  {loops=-1})
			 
	   end

    elseif event.phase == "up" then
		local i
		for i=2,5 do
			hero[i].isVisible=false
		end
			idle:setLinearVelocity(0,0)
			idle.isVisible=true
		audio.pause(passi)	 
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

local function activateBat()
	local bats = map:listTypes("bat")
	local values = {4, 2, 6, 1}
	for i=1,#bats do
		--local velX = 0.7 * math.sin(values[i]*math.pi*math.random(0.3, 0.5)) + 0.75
		--local velY = 0.6 * math.cos(values[((i+1)%4) +1]*math.pi*math.random(0.3, 0.5)) + 0.75
		local velY = math.random(0.75,1)*0.01 +0.15
		local velX = math.random(0.75, 1)*0.01 +0.15
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

local function isInTheRoom(objX, objY, wallTop, wallRight, wallBottom, wallLeft)
	if(objX < wallLeft.x or objX > wallRight.x) then
		return false
	end
	if(objY < wallTop.y or objY > wallBottom.y) then
		return false
	end
	return true 
end

local function invisibleWallPreCollision(self, event)
	if event.other.name == "idle" then
		event.contact.isEnabled = false
	end
	return true
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
	if event.phase == "began" then
		audio.play(aprichest)
		if event.target.isChest ~= nil then
			if event.other.name == "idle" then
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
		end
	elseif event.phase == "ended" then
		transition.fadeOut( box, { time=500 })
		transition.fadeOut( chestText, { time=500 })
	end
end

--local exitDoor = map:findObject("doorExit")
local function exit(self, event)
	if event.phase == "began" then
		local other = event.other.name
		createText(5)
	elseif event.phase == "ended" then
		transition.fadeOut( box, { time=500 })
		transition.fadeOut( chestText, { time=500 })
	end	
end

local function gameOver()
	composer.removeScene("scena3_gameoverDungeon")
	composer.gotoScene("scena3_gameoverDungeon")
	if #hearts == 0 then
		--[[
		if countGO == 0 then
			local move_down = transition.to(go,{delay=420, time = 600,
                                    			y = display.contentCenterY,
								   				alpha = 1})
			countGO = countGO + 1
			-- audio.stop(BGmusicChannel)
			audio.play(GO, {loops=0, 
			duration=2500
			})
		end]]
	end
end

local function damage(self, event)
	
	if event.other.isEnemy ~= nil then
		audio.play(danno)
		display.remove(hearts[#hearts])
		hearts[#hearts] = nil
		print("The remaining lifes are: " .. #hearts)
	end
	Runtime:addEventListener("enterFrame", gameOver)
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    control = display.newGroup()
	
	physics = require("physics")
	physics.start()
	physics.setGravity(0,0)
	physics.setDrawMode("hybrid")

	tiled = require "com.ponywolf.ponytiled"
	json = require ("json")
	mapData = json.decodeFile(system.pathForFile("Maptiles/Map2.json",system.ResourceDirectory))
	map = tiled.new(mapData, "Maptiles")
	scaleFactor = 3.5

	GO = audio.loadStream("RisorseAudio/GO.mp3")

	passi = audio.loadSound("RisorseAudio/footstep04.ogg")
	danno = audio.loadSound("RisorseAudio/dannopreso.mp3")
	aprichest = audio.loadSound("RisorseAudio/aprichest.mp3")
	audio.setVolume( 0.05)
	 camera= display.newGroup()
	 control = display.newGroup()

	 fontDir = "risorseGrafiche/font/fontpixel.ttf"
	 fontCustom = native.newFont(fontDir, 12)

	map:scale(scaleFactor,scaleFactor)
	map.x=50
	camera:insert(map)

	mapBorderLeft = 0
	mapBorderRight = 4480
	mapBorderTop = 0
	mapBorderBottom = 2520

	life=display.newGroup()
	hearts = {}

	for i=1, 4 do
		hearts[i] = display.newImageRect(control,"risorseGrafiche/PG/heart.png",128,128)
		hearts[i].x = i * 100
		hearts[i].y = 50
		hearts[i]:scale(0.5, 0.5)
		life:insert(hearts[i])
	end

	hearts[4].isVisible = false
	table.remove(hearts, #hearts)

	key = display.newImageRect(control,"risorseGrafiche/PG/key.png",128,128)
	key.x = display.contentWidth - 130
	key.y = 70
	key.isVisible =false

	hero = map:listTypes("hero")
	idle=map:findObject("idle")
	bodyShape={-5,-5, -5,5, 5,5, 5,-5}

	closedChest=map:listTypes("chest")
	openChest=map:listTypes("openChest")

	chest1 = map:findObject("chest1")
	chest2 = map:findObject("chest2")
	chest3 = map:findObject("chest3")
	chest4 = map:findObject("chest4")

	for i= 1,#openChest do
		local name = "chest" .. i
		local chest=map:findObject(name)
		openChest[i].x = chest.x
		openChest[i].y = chest.y
		openChest[i].isVisible=false
	end

	preX = idle.x
	preY = idle.y

	ladder=map:listTypes("ladder")

	createHero()

	room1_wallUp = map:findObject("wallUp1")
	room1_wallLeft = map:findObject("wallLeft1")
	room1_wallRight = map:findObject("wallRight1")
	room1_wallBottom = map:findObject("wallBottom1")

	activateBat()
	activateSkeleton()
	activateDemons()

	invisibleWall_batRoom = map:listTypes("invisibleWall")

	exitDoor = map:findObject("doorExit")

	countGO = 0

	ladder[1].collision = waitNTeleport
	ladder[2].collision = waitNTeleport
	chest1.collision = chestCollision
	chest2.collision = chestCollision
	chest3.collision = chestCollision
	chest4.collision = chestCollision
	exitDoor.collision = exit
	idle.postCollision = damage

	arrowLeft = display.newImageRect(control,"risorseGrafiche/risorseTmp_perTest/arrows/arrowLeft.png",80,80)    
    arrowLeft.name = "left"    
    arrowRight = display.newImageRect(control,"risorseGrafiche/risorseTmp_perTest/arrows/arrowRight.png",80,80)    
    arrowRight.name = "right"    
    arrowUp = display.newImageRect(control,"risorseGrafiche/risorseTmp_perTest/arrows/arrowUp.png",80,80)    
    arrowUp.name = "up"   
    arrowDown = display.newImageRect(control,"risorseGrafiche/risorseTmp_perTest/arrows/arrowDown.png",80,80)
    arrowDown.name = "down"
	sceneGroup:insert(camera)
	sceneGroup:insert(control)
end
 

local function restart()
	-- go to the game scene
	composer.removeScene("scena3_dungeon")
	composer.gotoScene("scena3_dungeon", {effect = "zoomInOutFade",	time = 1000})
	return true
end
	 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
		arrowLeft.x = 100
		arrowLeft.y = display.contentHeight-150
		arrowRight.x = 260
		arrowRight.y = display.contentHeight-150
		arrowUp.x = 180
		arrowUp.y = display.contentHeight-200
		arrowDown.x = 180
		arrowDown.y = display.contentHeight-100
    elseif ( phase == "did" ) then
        -- activate the tap listener 
        arrowLeft:addEventListener("touch",    movePg_noAnim)
        arrowRight:addEventListener("touch",   movePg_noAnim)
        arrowDown:addEventListener("touch",   movePg_noAnim)
        arrowUp:addEventListener("touch",   movePg_noAnim)
        Runtime:addEventListener("key",     movePg_arrows_noAnim)
        Runtime:addEventListener("enterFrame",moveCamera)
        Runtime:addEventListener("enterFrame", moveAnimation)
        ladder[1]:addEventListener("collision",ladder[1])
        ladder[2]:addEventListener("collision",ladder[2])
                    --bats[i]:addEventListener("collision", bats[i])
                    --bats[i]:addEventListener("preCollision", bats[i])
                    --invisibleWall_batRoom[i]:addEventListener("preCollision", invisibleWall_batRoom[i])
                    --arrowLeft:addEventListener("touch", movePg)
                    --arrowRight:addEventListener("touch", movePg)
                    --arrowDown:addEventListener("touch", movePg)
                    --arrowUp:addEventListener("touch", movePg)
                    --Runtime:addEventListener("key", movePg_arrows)
        chest1:addEventListener("collision",chest1)
        chest2:addEventListener("collision",chest2)
        chest3:addEventListener("collision",chest3)
        chest4:addEventListener("collision",chest4)
                    --Runtime:addEventListener("enterFrame", gameOver)
        idle:addEventListener("postCollision", idle)
		for i=1,#invisibleWall_batRoom do
			invisibleWall_batRoom[i].preCollision = invisibleWallPreCollision
			invisibleWall_batRoom[i]:addEventListener("preCollision", invisibleWall_batRoom[i])
		end
        Runtime:addEventListener("enterFrame", gameOver)
		end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
		-- Remove the tap listener associated with the retry button
		arrowLeft:removeEventListener("touch",    movePg_noAnim)
        arrowRight:removeEventListener("touch",   movePg_noAnim)
        arrowDown:removeEventListener("touch",   movePg_noAnim)
        arrowUp:removeEventListener("touch",   movePg_noAnim)
        Runtime:removeEventListener("key",     movePg_arrows_noAnim)
        Runtime:removeEventListener("enterFrame",moveCamera)
        Runtime:removeEventListener("enterFrame", moveAnimation)
        ladder[1]:removeEventListener("collision",ladder[1])
        ladder[2]:removeEventListener("collision",ladder[2])
                    --bats[i]:removeEventListener("collision", bats[i])
                    --bats[i]:removeEventListener("preCollision", bats[i])
                    --invisibleWall_batRoom[i]:removeEventListener("preCollision", invisibleWall_batRoom[i])
                    --arrowLeft:removeEventListener("touch", movePg)
                    --arrowRight:removeEventListener("touch", movePg)
                    --arrowDown:removeEventListener("touch", movePg)
                    --arrowUp:removeEventListener("touch", movePg)
                    --Runtime:removeEventListener("key", movePg_arrows)
        chest1:removeEventListener("collision",chest1)
        chest2:removeEventListener("collision",chest2)
        chest3:removeEventListener("collision",chest3)
        chest4:removeEventListener("collision",chest4)
                    --Runtime:removeEventListener("enterFrame", gameOver)
        idle:removeEventListener("postCollision", idle)
		
        Runtime:removeEventListener("enterFrame", gameOver)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene

	
		
		 
