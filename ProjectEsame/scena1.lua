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

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
	
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
		}
	}
	
	-- Load the background image
	background = display.newImageRect(sfondo, "risorseGrafiche/scenaIntro/sfondoScenaIntro.jpg", display.contentWidth, display.contentHeight)
	--load hero sprite
	hero =  display.newSprite(heroSheet,heroSeqs)
	cloud = display.newImageRect(pp,"risorseGrafiche/scenaIntro/nuvolaVoce.png", 0, display.width - 100)
	dialogueBox = display.newImageRect(pp, "risorseGrafiche/boxmessaggi.png", display.height - 300, display.contentCenterX)
	sceneGroup:insert(sfondo)
	sceneGroup:insert(pp)	  
end
 
 
local function movePg()
	hero.x = -20
	hero.y = display.contentHeight - 2*hero.height
	transition.to(go,{delay=0, time = 600,
                      x = display.contentCenterX,
					  alpha = 1})
end

local function moveCloud()
	cloud.x = display.contentWidth
	cloud.y = -30
	transition.to(go,{delay=0, time = 600,
                      x = display.contentWidth,
					  y= -60
					  alpha = 1})
	end
end

 
local function createText(self, event)
	box.x=0
	box.y=display.contentCenterY -80
	box.anchorX=0
	box.anchorY=0
	box.alpha=0
	transition.fadeIn( box, { time=500 })
	
	local quote

	--da implementare un sistema che sul touch passa al testo dopo

	chestText = display.newText({text="",fontSize=30, font = fontDir})
	chestText:setFillColor(0,0,0)
	chestText.text = quote
	chestText.anchorX = 0
	chestText.anchorY = 0
	chestText.x = display.contentCenterX/2/2
	chestText.y = 550
	chestText.font = fontDir
end

-- show()
function scene:show( event ) 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then        
		sfondo.x = display.contentCenterX
		sfondo.y = display.contentCenterY
		textN = 0
		movePg()
		moveCloud()
		createText(text)
 
    elseif ( phase == "did" ) then
        -- activate the tap listener 
		textN.tap = createText
		textN:addEventListener
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
		-- Remove the tap listener associated with the retry button
		retry:removeEventListener("tap",replay)
		
 
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

	