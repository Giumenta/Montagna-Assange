local composer = require("composer")

local scene = composer.newScene()

local sfondo = display.newGroup()
local pp = display.newGroup()
local go

local function tornaAlTuoPaese(event)
    composer.removeScene("scena3_dungeon", true)
    composer.gotoScene("scena3_dungeon", {effect = "zoomInOutFade",	time = 1000})
end

-- create()
function scene:create(event)
    local sceneGroup = self.view
    print("Scena 3 gameover, create")
    -- hero sequence e sheet

    go = display.newImageRect("risorseGrafiche/PG/GameOver.png",412,78)
    sceneGroup:insert(go)
end

-- show()
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase
    
    if (phase == "will") then
        print("scena3 gamover, show- will")
        go.x = display.contentCenterX
        go.y = display.contentCenterY
        local move_down = transition.to(go, {
            delay = 420,
            time = 600,
            y = display.contentCenterY
        })
    elseif (phase == "did") then
        print("scena3 gameover, show-did")

        -- activate the tap listener 
        Runtime:addEventListener("tap", tornaAlTuoPaese)
    end
end

-- hide()
function scene:hide(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        Runtime:removeEventListener("tap", tornaAlTuoPaese)

    elseif (phase == "did") then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end

-- destroy()
function scene:destroy(event)
    composer.removeScene("scena3_gameoverDungeon")

    
    local sceneGroup = self.view

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------------

return scene

