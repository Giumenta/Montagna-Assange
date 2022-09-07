local composer = require( "composer" )
 
local scene = composer.newScene()
 
local sfondo = display.newGroup()
local pp = display.newGroup() 
local gameover


local function tornaAlTuoPaese(event)
	composer.removeScene("scena3_dungeon")
	composer.gotoScene("scena3_dungeon")
end

-- create()
function scene:create( event )
	print("Scena 3 gameover, create")
	--hero sequence e sheet
	
	local rect = display.newRect(display.contentCenterX,
                             display.contentCenterY,display.contentWidth,display.contentHeight)
							 rect.alpha= 0

rect:setFillColor(1,1,0)

local go = display.newImageRect("img/GameOver.png",412,78)
go.x = display.contentCenterX
go.y = -40
go.alpha = 0




local move_down = transition.to(go,{delay=420, time = 600,
                                    y = display.contentCenterY,
								    alpha = 1})

	gameover = display.newImageRect("PG/GameOver.png", 412,78)
	display.newImage(rect, 412,78)
	sceneGroup:insert(gameover)
end

-- show()
function scene:show( event ) 
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then 
		print("scena3 gamover, show- will")    
		gameover.x = display.contentCenterX
		gameover.y = display.contentCenterY
    elseif ( phase == "did" ) then
		print("scena1, show-did")
		hero:setSequence("freeze")
		createText(text)
        -- activate the tap listener 
		Runtime:addEventListener("tap", tornaAlTuoPaese)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
		Runtime:removeEventListener("tap", tornaAlTuoPaese)
 
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

	