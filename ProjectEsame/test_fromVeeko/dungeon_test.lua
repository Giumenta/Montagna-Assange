physics = require('physics')
physics.start()
physics.setGravity(0,0) --almeno possiamo lavorare in 'verticale' nel dungeon 
physics.setDrawMode("hybrid")

--creo giusto un gruppo
local control = display.newGroup()
local camera= display.newGroup()

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
local heroShape={-6,0,6,0,-6,16,6,16}
physics.addBody(hero, "dynamic", heroShape)
hero:scale(2,2)
hero.x = display.contentCenterX
hero.y = display.contentCenterY

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
			hero:setLinearVelocity(0, -150)
		elseif arrow.name == "left" then
			hero:setLinearVelocity(-150, 0)
		elseif arrow.name == "right" then 
			hero:setLinearVelocity(150, 0)
		else --arrow.name == down
			hero:setLinearVelocity(0, 150)
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