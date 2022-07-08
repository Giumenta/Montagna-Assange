local colonna=1
local riga=1
local GRID_WIDTH = 4
local GRID_HEIGHT = 4
local grid = {} -- creo una griglia 4x4
		for  riga = 1, GRID_HEIGHT do
			grid[riga] = {}
				for colonna = 1, GRID_WIDTH do
				grid[riga][colonna] = ((colonna - 1) * GRID_WIDTH) + riga
				end
		end

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
local function creaGriglia() 
     
    local griglia= display.newRect(display.contentCenterX,display.contentCenterY, larghezzaGriglia,larghezzaGriglia)
	local background = display.newImageRect( "risorseGrafiche/montagnaGenericoAmbiente/sfondogioco15.jpg", larghezzaGriglia,larghezzaGriglia)
    background.x = display.contentCenterX
	background.y = display.contentCenterY
	
    local colonna=1
    local riga=1

	local tassello
	--assegno ad ogni posizione nella griglia un tassello specifico
	grid[1][1] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[1][2] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello2.png",dimtassello, dimtassello )
	grid[1][3] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello3.png",dimtassello, dimtassello )
	grid[1][4] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello4.png",dimtassello, dimtassello )
	grid[2][1] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello5.png",dimtassello, dimtassello )
	grid[2][2] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello6.png",dimtassello, dimtassello )
	grid[2][3] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello7.png",dimtassello, dimtassello )
	grid[2][4] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello8.png",dimtassello, dimtassello )
	grid[3][1] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello9.png",dimtassello, dimtassello )
	grid[3][2] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello10.png",dimtassello, dimtassello )
	grid[3][3] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello11.png",dimtassello, dimtassello )
	grid[3][4] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello12.png",dimtassello, dimtassello )
	grid[4][1] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello13.png",dimtassello, dimtassello )
	grid[4][2] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello14.png",dimtassello, dimtassello )
	grid[4][3] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello15.png",dimtassello, dimtassello )
	
	for colonna=1,4 do        
        for riga=1,4 do
			if grid[riga][colonna] ~= 4*4 then -- rimuovo 16° tassello
				tassello = grid[riga][colonna] --creo i 15 tasselli
				tassello.anchorX=0
				tassello.anchorY=0
				tassello.y=display.contentHeight/2-(larghezzaGriglia)/2 + (riga-1)*dimtassello + riga*spaziaturaTasselli
				tassello.x=display.contentWidth/2-(larghezzaGriglia)/2 + (colonna-1)*dimtassello + colonna*spaziaturaTasselli
				
			end
		end
	end
end

--creo una funzione per verificare la posizione di un tassello libero
local function muovitassello (event)
    local emptyX
	local emptyY
	--local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
   -- print( message )
		--if ( event.keyName == "down" ) then

			for colonna=1, GRID_HEIGHT do
        
				for riga=1, GRID_WIDTH do
					if grid[riga][colonna] == GRID_WIDTH*GRID_HEIGHT  then
					emptyX = colonna
					emptyY = riga
					
					end
				end
			end
		--end
			print('x libera: '..emptyX..', y libera: '..emptyY)--stampo sulla console la posizione del tassello libero
		
		local newEmptyY = emptyY
		local newEmptyX = emptyX
		
		local arrow=event.target
	
	if event.phase == "began" then
        if arrow.name == "left" then
			newEmptyX = emptyX + 1

		elseif arrow.name == "right" then
        	newEmptyX = emptyX - 1

        elseif arrow.name == "up" then
        	newEmptyY = emptyY + 1

        elseif arrow.name == "down" then
        	newEmptyY = emptyY - 1
		
		elseif event.phase == "ended" then
		return false
		end
		if grid[newEmptyY] and grid[newEmptyY][newEmptyX] then
			grid[newEmptyY][newEmptyX], grid[emptyY][emptyX] =
			grid[emptyY][emptyX], grid[newEmptyY][newEmptyX]
			--riga = emptyX
			--colonna = emptyY
			transition.moveTo(grid[emptyY][emptyX], {x=display.contentWidth/2-(larghezzaGriglia)/2 + (emptyX-1)*dimtassello + emptyX*spaziaturaTasselli, y= display.contentHeight/2-(larghezzaGriglia)/2 + (emptyY-1)*dimtassello + emptyY*spaziaturaTasselli, time=100})
		end
	end
		--[[if ( event.keyName == "down" ) then -- sposto verso il basso un tassello
			newEmptyY = emptyY - 1
		elseif ( event.keyName == "up" ) then -- sposto verso l'alto un tassello
			newEmptyY = emptyY + 1
		elseif ( event.keyName == "right" ) then
			newEmptyX = emptyX - 1
		elseif ( event.keyName == "left" ) then
			newEmptyX = emptyX + 1
		end	
		if grid[newEmptyY] then
			grid[newEmptyY][newEmptyX], grid[emptyY][emptyX] =
			grid[emptyY][emptyX], grid[newEmptyY][newEmptyX]
			--riga = emptyX
			--colonna = emptyY
			transition.moveTo(grid[emptyY][emptyX], {x=display.contentWidth/2-(larghezzaGriglia)/2 + (emptyX-1)*dimtassello + emptyX*spaziaturaTasselli, y= display.contentHeight/2-(larghezzaGriglia)/2 + (emptyY-1)*dimtassello + emptyY*spaziaturaTasselli, time=100})
		end]]--
	return true
end
--creo una funzione per lo shuffle dei tasselli
local function onKeyEvent( event )
	if ( event.keyName == "space" ) then
		local moveNumber
		for moveNumber = 1, 1000 do
			local emptyX
			local emptyY
			
			for colonna = 1, GRID_HEIGHT do
				for riga = 1, GRID_WIDTH do
					if grid[riga][colonna] == GRID_WIDTH*GRID_HEIGHT then
						emptyX = colonna
						emptyY = riga
					end
				end
			end
			
			local newEmptyY = emptyY
			local newEmptyX = emptyX
			
			local roll math.random(4)
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
	--			transition.moveTo(grid[emptyY][emptyX], {x=display.contentWidth/2-(larghezzaGriglia)/2 + (emptyX-1)*dimtassello + emptyX*spaziaturaTasselli, y= display.contentHeight/2-(larghezzaGriglia)/2 + (emptyY-1)*dimtassello + emptyY*spaziaturaTasselli, time=100})
			end
		end
	end
end

arrowLeft:addEventListener("touch", muovitassello)
arrowRight:addEventListener("touch", muovitassello)
arrowDown:addEventListener("touch", muovitassello)
arrowUp:addEventListener("touch", muovitassello)

Runtime:addEventListener( "key", onKeyEvent )

creaGriglia()


		


--randomizzare i numeri sui tasselli
--[[
		local emptyX
        local emptyY
        
        for riga = 1, 4 do
            for colonna = 1, 4 do
                if grid[riga][colonna] == 4 * 4 then
                    emptyX = colonna
                    emptyY = riga
                end
            end
        end
        
        local newEmptyY = emptyY
        local newEmptyX = emptyX
        
        local roll math.random(4)
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
			transition.moveTo(grid[emptyY][emptyX], {x=display.contentWidth/2-(larghezzaGriglia)/2 + (emptyX-1)*dimtassello + emptyX*spaziaturaTasselli, y= display.contentHeight/2-(larghezzaGriglia)/2 + (emptyY-1)*dimtassello + emptyY*spaziaturaTasselli, time=100})

        end ]]--