--link alla mappa
local tiled = require "com.ponywolf.ponytiled"
local json = require "json"
local mapData = json.decodeFile(system.pathForFile("mappe\\livello3\\livelloPlatformVerticaleProva.json",system.ResourceDirectory))
local map = tiled.new(mapData, "mappe\\livello3")



--creo lo sfondo
background = display.newRect(display.contentCenterX, display.contentCenterY, 1280, 720)

--richiamo la fisica
physics = require("physics")
physics.start()
physics.pause()
physics.setDrawMode("hybrid")

--creo i gruppi che ci servono

local allArrows = display.newGroup()

--link alle risorse grafiche (tutte qua così se c'è qualcosa da cambiare non si devediventare matti a cercarle nel file')

local pg = display.newImageRect( "\\risorseGrafiche\\risorseTmp_perTest\\stickyMan.png", 600,400 )

local arrowUp = display.newImageRect(allArrows, "\\risorseGrafiche\\risorseTmp_perTest\\arrows\\arrowUp.png", 100, 100)
local arrowLeft = display.newImageRect(allArrows, "\\risorseGrafiche\\risorseTmp_perTest\\arrows\\arrowLeft.png",100, 100)
local arrowRight = display.newImageRect(allArrows, "\\risorseGrafiche\\risorseTmp_perTest\\arrows\\arrowRight.png", 100, 100)

--setting base delle frecce
arrowUp.name = "up"
arrowUp.x = 500
arrowUp.y = 525

arrowLeft.name = "left"
arrowLeft.x = 425
arrowLeft.y = 600

arrowRight.name = "right"
arrowRight.x = 575
arrowRight.y = 600

--sposto tutte le frecce via gruppo e le metto in basso a dx
allArrows.x = 625
allArrows.y = 50

--preparo il personaggio
pg.x= display.contentCenterX
pg.y= display.contentCenterY
pg.name= "pg"


--faccio partire la gravità così da poter muovere il pg
physics.start()
physics.setGravity(0,9)
local pgOutline = graphics.newOutline(1.2, "\\risorseGrafiche\\risorseTmp_perTest\\stickyMan.png")
physics.addBody(pg, "dynamic", {outline=pgOutline, density=1.1, bounce = 0})
pg.isFixedRotation = true
--funzione base per spostare il personaggio
local function movePg(event)
	local arrow=event.target
	
	if event.phase == "began" then
        if arrow.name == "left" then
			pg:setLinearVelocity(-200, 0)
	    	 
		elseif arrow.name == "right" then
        	pg:setLinearVelocity(200,0)
            
        elseif arrow.name == "up" then
        	pg:applyLinearImpulse(20, 0, pg.x, pg.y)   
	   end

    elseif event.phase == "moved" then
		if arrow.name == "left" then
			pg:setLinearVelocity(-200, 0)
	    	 
		elseif arrow.name == "right" then
        	pg:setLinearVelocity(200,0)
            
        elseif arrow.name == "up" then
        	pg:applyLinearImpulse(20, 0, pg.x, pg.y)    
	   end
	
	elseif event.phase == "ended" then
			pg:setLinearVelocity(0,0)
	end
 	   	 
 	return true
end

local function moveCamera(event)

end

--associo alle frecce la funzione movePg
arrowUp:addEventListener("touch", movePg) --da modificare
arrowLeft:addEventListener("touch", movePg)
arrowRight:addEventListener("touch", movePg)

--creo il fondo della mappa
floor = display.newRect(display.contentCenterX, display.contentCenterY*2, 1280, 1)
physics.addBody(floor, "static", {bounce = 0})

	
	


