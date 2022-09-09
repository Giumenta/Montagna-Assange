-- Load the composer library 
local composer = require( "composer" )

--variabili varie
local scene = composer.newScene()

local sfondo = display.newGroup()
local pp = display.newGroup() 
local background
local mrb
local dialogueBox
local cloud

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

 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
    local sceneGroup = self.view
	textTable = {
		"Mr B.: Complimenti, hai superato la prova",
		"Mr B.: Ora puoi entrare ed esplorare il cuore della montagna",
		"Mr B.: Evita tutti i nemici e trova la via d'uscita"
	}

    background = display.newImageRect(sfondo, "risorseGrafiche/PG/holyCrapAmIInHeaven.png", display.contentWidth, display.contentHeight)
    mrb = display.newImageRect(pp, "risorseGrafiche/RaccoltaDiRoba/b.png", 300, 300)
    cloud = display.newImageRect(pp,"risorseGrafiche/scenaIntro/nuvolaVoce.png", 400, 200)
    dialogueBox = display.newImageRect(pp, "risorseGrafiche/boxmessaggi.png", display.contentWidth +100, display.contentHeight/1.5)
	local fontDir = "risorseGrafiche/font/fontpixel.ttf"
	local fontCustom = native.newFont(fontDir, 12)
	dialogue = display.newText({text="",fontSize=25, font = fontDir})
	sceneGroup:insert(sfondo)
	sceneGroup:insert(pp)	  
	sceneGroup:insert(mrb)
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
		mrb.x = display.contentCenterX
		mrb.y = display.contentCenterY - 100
		-- dialogue.anchorX = 0
		-- dialogue.anchorY = 0
		dialogue.x = display.contentCenterX
		dialogue.y = display.contentCenterY
		dialogueBox.x = display.contentCenterX
		dialogueBox.y = display.contentHeight - dialogueBox.height/2 + 160
		
		
 
    elseif ( phase == "did" ) then
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
        Runtime:removeEventListener("tap", createText)
 
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
