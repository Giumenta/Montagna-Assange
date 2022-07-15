-----------------------------------------------------------------------------------------
--
-- replay.lua   defines the  replay scene
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local sfondo = display.newGroup()
local pp = display.newGroup() 
local background  -- variable that stores the background image 
local retry       -- variable that stores the retry image button SERVE? 
local hero
local cloud
local dialogueBox
local textN
local textTable
local fontDir
local fontCustom
local box
local dialogue

-- create()
function scene:create( event )
	print("Scena 1, create")
    local sceneGroup = self.view
	textTable = {
		"Ciao sono ???",
		"Prova di fuoco",
		"STM \n è un bel corso", 
		"e così via"
	}
	--hero sequence e sheet
	local opt = { width = 32, height = 32, numFrames = 12}
	local heroSheet = graphics.newImageSheet("risorseGrafiche/PG/sprite-sheet.png", opt)
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
		},
		{
			name = "freeze",
			frames={2},
			time = 1000,
			loopCount = 0,
			loopDirection ="forward"
		}
	}
	
	-- Load the background image
	background = display.newImageRect(sfondo, "risorseGrafiche/scenaIntro/sfondoScenaIntro.jpg", display.contentWidth, display.contentHeight)
	--load hero sprite
	hero =  display.newSprite(heroSheet,heroSeqs)
	cloud = display.newImageRect(pp,"risorseGrafiche/scenaIntro/nuvolaVoce.png", 400, 200)
	dialogueBox = display.newImageRect(pp, "risorseGrafiche/boxmessaggi.png", display.contentWidth + 200, display.contentHeight/3 + 50)
	local fontDir = "risorseGrafiche/font/minecraft/minecraft.ttf"
	local fontCustom = native.newFont(fontDir, 12)
	dialogue = display.newText({text="",fontSize=30, font = fontDir})
	sceneGroup:insert(sfondo)
	sceneGroup:insert(pp)	  
end
 
 
local function movePg()
	transition.to(hero,{delay=0, time = 6000,
						x = display.contentCenterX,
						y = display.contentHeight*3/4,
					  	alpha = 1})
end

local function moveCloud()
	print("move cloud")
	cloud.x = display.contentWidth
	cloud.y = -30
	transition.to(cloud,{delay=0, time = 6000,
						x = display.contentCenterX*4/3,
						y = 100,
					  alpha = 1})
	
end

 
local function createText(self, event)
	if textN < #textTable then
		
		dialogue:setFillColor(0,0,0)
		dialogue.text = textTable[textN]
		dialogue.anchorX = 0
		dialogue.anchorY = 0
		dialogue.x = display.contentCenterX/4
		dialogue.y = display.contentHeight - 75
		dialogue.font = fontDir
		textN = textN + 1 --passa al testo successivo
	else
		composer.removeScene("scena2_gioco15")
		composer.gotoScene("scena2_gioco15", {effect = "zoomInOutFade",	time = 1000}) 
	end
end

-- show()
function scene:show( event ) 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then 
		print("scena1, show- will")    
		sfondo.x = display.contentCenterX
		sfondo.y = display.contentCenterY - 100
		textN = 0
		hero.x = 0
		hero.y = display.contentCenterY
		-- dialogue.anchorX = 0
		-- dialogue.anchorY = 0
		dialogue.x = display.contentCenterX/2
		dialogue.y = display.contentCenterY
		dialogueBox.x = display.contentCenterX
		dialogueBox.y = display.contentHeight - dialogueBox.height/2 + 95
		hero:scale(3,3)
		hero:setSequence("right") 
    elseif ( phase == "did" ) then
		print("scena1, show-did")
		movePg()
		hero:setSequence("freeze")
		
		moveCloud()
		createText(text)
        -- activate the tap listener 
		Runtime:addEventListener("tap", createText)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
		Runtime:removeEventListener("tap", textN)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    
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

	