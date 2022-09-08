local composer = require( "composer" )
 
local scene = composer.newScene()
 
local sfondo = display.newGroup()
local pp = display.newGroup() 
local background  -- variable that stores the background image 
local hero
local dialogueBox
local textN
local textTable
local fontDir
local fontCustom
local box
local dialogue
local BG
local BGmusicChannel



local function createText(self, event)
	if textN <= #textTable then
		
		dialogue:setFillColor(0,0,0)
		dialogue.text = textTable[textN]
		dialogue.anchorX = 0
		dialogue.anchorY = 0
		dialogue.x = display.contentCenterX/4
		dialogue.y = display.contentHeight - 120
		dialogue.font = fontDir
		textN = textN + 1 --passa al testo successivo
	else
		audio.stop({channel=1})	
		composer.removeScene("scena3_dungeon")
		composer.gotoScene("scena3_dungeon", {effect = "zoomInOutFade",	time = 1000}) 
	end
end

-- create()
function scene:create( event )
	
    local sceneGroup = self.view
	textTable = {
		"???: Complimenti, hai superato la prova",
		"???: Ora puoi entrare ed esplorare il cuore della montagna",
		"???: Evita tutti i pericoli e \n trova la via d'uscita"
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
			name = "freeze",
			frames={2},
			time = 1000,
			loopCount = 0,
			loopDirection ="forward"
		}
	}
	
	-- Load the background image
	background = display.newImageRect(sfondo, "risorseGrafiche/PG/holyCrapAmIInHeaven.png", display.contentWidth, display.contentHeight)
	--load hero sprite
	hero =  display.newSprite(heroSheet,heroSeqs)
	dialogueBox = display.newImageRect(pp, "risorseGrafiche/boxmessaggi.png", display.contentWidth +100, display.contentHeight/1.5)
	local fontDir = "risorseGrafiche/font/fontpixel.ttf"
	local fontCustom = native.newFont(fontDir, 12)
	dialogue = display.newText({text="",fontSize=25, font = fontDir})
	sceneGroup:insert(sfondo)
	sceneGroup:insert(pp)	  
	sceneGroup:insert(hero)
	sceneGroup:insert(dialogue)
end

-- show()
function scene:show( event ) 
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then 
		    
		sfondo.x = display.contentCenterX
		sfondo.y = display.contentCenterY - 100
		sfondo:scale(0.3, 0.3)
		textN = 0
		hero.x = display.contentCenterX
		hero.y = display.contentCenterY - 100
		-- dialogue.anchorX = 0
		-- dialogue.anchorY = 0
		dialogue.x = display.contentCenterX
		dialogue.y = display.contentCenterY
		dialogueBox.x = display.contentCenterX
		dialogueBox.y = display.contentHeight - dialogueBox.height/2 + 160
		hero:scale(3,3)
    elseif ( phase == "did" ) then
		
		hero:setSequence("freeze")
		createText(text)
        -- activate the tap listener 
		Runtime:addEventListener("tap", createText)
    end
	BG = audio.loadStream("RisorseAudio/BG2.mp3")

	audio.setVolume(0.025,{channel=1})

	BGmusicChannel = audio.play(BG, {channel=1, loops=-1, fadein=5000})
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
		Runtime:removeEventListener("tap", createText)
 
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

	