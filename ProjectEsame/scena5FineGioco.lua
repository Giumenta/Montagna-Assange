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
local reveal
local function createText(self, event)
	if textN <= #textTable then
		if(textN == reveal) then
            transition.fadeOut( cloud, { time=2000 } )
        end
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

		-- composer.removeScene("scena3_dungeon")
		-- composer.gotoScene("scena3_dungeon", {effect = "zoomInOutFade",	time = 1000}) 
	end
end

 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )

    local sceneGroup = self.view
	textTable = {
		"Mr B.: Sei riuscito a superare i pericoli del monte STM",
		"Mr B.: Hai dimostrato di essere degno di portare alto il nome\n del sacro ordine di GP",
		"Mr B.: Resta un solo mistero da svelarti...",
        "Mr Ballis: Ecco, ora conosci anche il mio volto.",
        "Mr Ballis: Ora vai, e porta dentro te il sacro fuoco del monte STM!"
	}
    reveal = 4
    background = display.newImageRect(sfondo, "risorseGrafiche/PG/holyCrapAmIInHeaven.png", display.contentWidth, display.contentHeight)
    mrb = display.newImageRect(pp, "risorseGrafiche/collezioneDiRoba/b.png", 600, 600)
    cloud = display.newImageRect(pp,"risorseGrafiche/scenaIntro/nuvolaVoce.png", 800, 600)
    dialogueBox = display.newImageRect(pp, "risorseGrafiche/boxmessaggi.png", display.contentWidth +100, display.contentHeight/1.5)
	local fontDir = "risorseGrafiche/font/fontpixel.ttf"
	local fontCustom = native.newFont(fontDir, 12)
	dialogue = display.newText({text="",fontSize=25, font = fontDir})
	sceneGroup:insert(sfondo)
	sceneGroup:insert(pp)	  
	sceneGroup:insert(dialogue)
end



 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
       -- composer.removeScene("scena3_dungeon")

		sfondo.x = display.contentCenterX
		sfondo.y = display.contentCenterY - 100
		sfondo:scale(0.8,0.8)
		textN = 0
		mrb.x = display.contentCenterX
		mrb.y = display.contentCenterY - 100
        cloud.x = display.contentCenterX
		cloud.y = display.contentCenterY - 100
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
