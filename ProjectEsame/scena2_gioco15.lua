--tutte le nostre belle variabili
local colonna
local riga
local GRID_WIDTH
local GRID_HEIGHT
local larghezzaGriglia
local dimtassello
local spaziaturaTasselli
local control
local background
local tasselliGroup
local larghezzaGriglia
local dimtassello
local spaziaturaTasselli
local control 
local arrowLeft 
local arrowRight 
local arrowUp 
local arrowDown 

--funzioni varie

local function goToScene3()
	composer.removeScene("scene3")
	composer.gotoScene("scene3", {effect = "zoomInOutFade",	time = 1000})
end

local function isRisolto()
	local complete=true

	local riga = 1
	local colonna = 1
	local contaCaselle = 1
	
	local r = 1
	local c = 1
	
	while complete and contaCaselle < 17 do
		if grid[r][c] ~= nil then  
			if grid[r][c].value == ((r-1)*4 + c) then
				contaCaselle = contaCaselle + 1
				if (contaCaselle % 4 == 0) then
					c = 4
				else
					c = contaCaselle % 4
				end
				r = math.ceil((contaCaselle) / 4)
			else
				complete = false
			end
		else
			if r ~= 4 and c ~= 4 then
				complete = false
			else
				break
			end
		end
		
	end

	if complete and contaCaselle == 16 then
		--timer.performWithDelay(3000, goToScene3)
	else
		
	end
end


local function shuffle()

	local moveNumber
		for moveNumber = 1, 1000 do
			local emptyX
			local emptyY
			
			for colonna = 1, GRID_HEIGHT do
				for riga = 1, GRID_WIDTH do
					if grid[riga][colonna] == nil then
						emptyX = colonna
						emptyY = riga
					end
				end
			end
			
			local newEmptyY = emptyY
			local newEmptyX = emptyX
			
			local roll = math.random(4)
				
			if roll == 1 then
				newEmptyY = emptyY - 1
			elseif roll == 2 then
				newEmptyY = emptyY + 1
			elseif roll == 3 then
				newEmptyX = emptyX - 1
			elseif roll == 4 then
				newEmptyX = emptyX + 1
			end
			
				if grid[newEmptyY] and grid[newEmptyY][newEmptyX] then
					grid[newEmptyY][newEmptyX], grid[emptyY][emptyX] =
					grid[emptyY][emptyX], grid[newEmptyY][newEmptyX]
					transition.moveTo(grid[emptyY][emptyX], {x=display.contentWidth/2-(larghezzaGriglia)/2 + (emptyX-1)*dimtassello + emptyX*spaziaturaTasselli, y= display.contentHeight/2-(larghezzaGriglia)/2 + (emptyY-1)*dimtassello + emptyY*spaziaturaTasselli, time=10})
				end
		end
end

--creo una funzione per spostare i tasselli nella casella libera
local function muovitassello (event)
    local emptyX
	local emptyY

	for colonna=1, GRID_HEIGHT do

		for riga=1, GRID_WIDTH do
			if grid[riga][colonna] == nil  then
			emptyX = colonna
			emptyY = riga
			
			end
		end
	end
		
	local newEmptyY = emptyY
	local newEmptyX = emptyX
	
	local arrow=event.target
	
	if event.phase == "began" then
        if arrow.name == "left" then --sposto il tass a sinistra
			newEmptyX = emptyX + 1

		elseif arrow.name == "right" then  --sposto il tassello a destra
        	newEmptyX = emptyX - 1

        elseif arrow.name == "up" then  --sposto il tassello in alto
        	newEmptyY = emptyY + 1

        elseif arrow.name == "down" then  --sposto il tassello in basso
        	newEmptyY = emptyY - 1
		end
		if grid[newEmptyY] and grid[newEmptyY][newEmptyX] then
			grid[newEmptyY][newEmptyX], grid[emptyY][emptyX] = grid[emptyY][emptyX], grid[newEmptyY][newEmptyX]
			transition.moveTo(grid[emptyY][emptyX],{x=display.contentWidth/2-(larghezzaGriglia)/2 + (emptyX-1)*dimtassello + emptyX*spaziaturaTasselli, y= display.contentHeight/2-(larghezzaGriglia)/2 + (emptyY-1)*dimtassello + emptyY*spaziaturaTasselli, time=100})
		end
		isRisolto()
	end
end


--funzione per spostare i tasselli con la tastiera
local function muovitassello_keyboard (event)
    local emptyX
	local emptyY

	for colonna=1, GRID_HEIGHT do

		for riga=1, GRID_WIDTH do
			if grid[riga][colonna] == nil  then
			emptyX = colonna
			emptyY = riga
			
			end
		end
	end
	
	local newEmptyY = emptyY
	local newEmptyX = emptyX
	
	if event.phase == "down" then
		if ( event.keyName == "down" ) or( event.keyName == "s" ) then -- sposto verso il basso un tassello
			newEmptyY = emptyY - 1
			elseif ( event.keyName == "up" ) or( event.keyName == "w" ) then -- sposto verso l'alto un tassello
				newEmptyY = emptyY + 1
			elseif ( event.keyName == "left" ) or( event.keyName == "a" ) then -- sposto verso sinistra un tassello
				newEmptyX = emptyX + 1
			elseif ( event.keyName == "right" )  or( event.keyName == "d" )then -- sposto verso destra un tassello
				newEmptyX = emptyX - 1
			end
		if grid[newEmptyY] and grid[newEmptyY][newEmptyX] then
			grid[newEmptyY][newEmptyX], grid[emptyY][emptyX] =
			grid[emptyY][emptyX], grid[newEmptyY][newEmptyX]
			transition.moveTo(grid[emptyY][emptyX], {x=display.contentWidth/2-(larghezzaGriglia)/2 + (emptyX-1)*dimtassello + emptyX*spaziaturaTasselli, y= display.contentHeight/2-(larghezzaGriglia)/2 + (emptyY-1)*dimtassello + emptyY*spaziaturaTasselli, time=100})
		end
		isRisolto()
	end
end


--creo i tasselli e li posiziono nella griglia

local function creaGriglia() 
     
    local griglia= display.newRect(tasselliGroup,display.contentCenterX,display.contentCenterY, larghezzaGriglia,larghezzaGriglia)
	local background = display.newImageRect(tasselliGroup, "risorseGrafiche/montagnaGenericoAmbiente/sfondogioco15.jpg", larghezzaGriglia,larghezzaGriglia)
   
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	
    local colonna=1
    local riga=1

	local tassello
	
	for riga=1,4 do        
        for colonna=1,4 do
			

			if grid[riga][colonna] ~= GRID_HEIGHT*GRID_WIDTH then
				--assegno ad ogni posizione nella griglia un tassello specifico
				local nTassello = (riga - 1)*4 + colonna 
				local filePath = "risorseGrafiche/montagnaGenericoAmbiente/tassello" .. nTassello .. ".png"
				
				grid[riga][colonna] = display.newImageRect(tasselliGroup, filePath, dimtassello, dimtassello)
				tassello = grid[riga][colonna] --creo i 15 tasselli
				grid[riga][colonna].anchorX=0
				grid[riga][colonna].anchorY=0
				grid[riga][colonna].y=display.contentHeight/2-(larghezzaGriglia)/2 + (riga-1)*dimtassello + riga*spaziaturaTasselli
				grid[riga][colonna].x=display.contentWidth/2-(larghezzaGriglia)/2 + (colonna-1)*dimtassello + colonna*spaziaturaTasselli
				grid[riga][colonna].value = (riga-1)*4 + colonna
			else 
				--il tassello 'vuoto'
				grid[riga][colonna] = nil
			end
		end
	end
	shuffle()--mescolo i tasselli
end

function scene:create( event )
 
    local sceneGroup = self.view
	
    local larghezzaGriglia = display.contentHeight*0.9
    local dimtassello= (display.contentHeight*0.88)/4
    local spaziaturaTasselli=(larghezzaGriglia-display.contentHeight*0.88)/5
    local control = display.newGroup()
    -- create obj arrows and button for interaction
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

	sceneGroup:insert(control)
	sceneGroup:insert(tasselliGroup)
  
end
	 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
		colonna=1
		riga=1
		GRID_WIDTH = 4
		GRID_HEIGHT = 4
		-- place the retry object at the center of the display
		retry.x = display.contentCenterX
		retry.y = display.contentCenterY
		
    
 
    elseif ( phase == "did" ) then
		creaGriglia()
        -- activate the tap listener 
		retry.tap = restart
		retry:addEventListener("tap", restart)
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