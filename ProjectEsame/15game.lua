local colonna=1
local riga=1
local GRID_WIDTH = 4
local GRID_HEIGHT = 4
local grid = {} -- creo una griglia 4x4
		for  colonna = 1, GRID_HEIGHT do
			grid[colonna] = {}
				for riga = 1, GRID_WIDTH do
				grid[colonna][riga] = ((colonna - 1) * GRID_WIDTH) + riga
				end
		end

local function creaGriglia() 
    --local tasselli={}--dichiaro che tasselli è una tabella
    local larghezzaGriglia = display.contentHeight*0.9
    local griglia= display.newRect(display.contentCenterX,display.contentCenterY, larghezzaGriglia,larghezzaGriglia)
    local dimtassello= (display.contentHeight*0.88)/4
    local colonna=1
    local riga=1
    local spaziaturaTasselli=(larghezzaGriglia-display.contentHeight*0.88)/5
	
-- disegno i tasselli
      --for riga=1, 4 do
        --for colonna=1,4 do
    for colonna=1,GRID_HEIGHT do
        
        for riga=1,GRID_WIDTH do
			if grid[colonna][riga] ~= GRID_WIDTH*GRID_HEIGHT then -- rimuovo 16° tassello
		   
				grid[colonna][riga] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassellogioco15_stondato.jpg",dimtassello, dimtassello )
				grid[colonna][riga].anchorX=0
				grid[colonna][riga].anchorY=0
				grid[colonna][riga].y=display.contentHeight/2-(larghezzaGriglia)/2 + (riga-1)*dimtassello + riga*spaziaturaTasselli
				grid[colonna][riga].x=display.contentWidth/2-(larghezzaGriglia)/2 + (colonna-1)*dimtassello + colonna*spaziaturaTasselli
				grid[colonna][riga].valore= riga * colonna
		
		--disegno i numeri sui tasselli
				grid[colonna][riga] = display.newText (
				((riga - 1) * 4) + colonna,
				--grid[riga][colonna].valore,
				(riga - 1) * dimtassello,
                (colonna - 1) * dimtassello, native.systemFont, 70
				)
			--numeri:setFillColor( 1, 0.5, .5 ) --dovrebbere essere giusto ma non va
		
				grid[colonna][riga].anchorX=0
				grid[colonna][riga].anchorY=0
				grid[colonna][riga].y=display.contentHeight/2-(larghezzaGriglia)/2 + (riga-1)*dimtassello + riga*spaziaturaTasselli
				grid[colonna][riga].x=display.contentWidth/2-(larghezzaGriglia)/2 + (colonna-1)*dimtassello + colonna*spaziaturaTasselli
			end
		end
		
    end
end
--creo una funzione per verificare la posizione di un tassello libero
local function onKeyEvent (event)
    local emptyX
	local emptyY
	--local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
   -- print( message )
		--if ( event.keyName == "down" ) then

			for colonna=1, GRID_HEIGHT do
        
				for riga=1, GRID_WIDTH do
					if grid[colonna][riga] == GRID_WIDTH*GRID_HEIGHT  then
					emptyX = riga
					emptyY = colonna
					
					end
				end
			--end
		  end
			print('x libera: '..emptyX..', y libera: '..emptyY)--stampo sulla console la posizione del tassello libero
		
		local newEmptyY = emptyY
		
		
		if ( event.keyName == "down" ) then -- sposto verso il basso un tassello
			newEmptyY = emptyY - 1
			elseif ( event.keyName == "up" ) then -- sposto verso l'alto un tassello
				newEmptyY = emptyY + 1
			end
				if grid[newEmptyY] then
				grid[newEmptyY][emptyX], grid[emptyY][emptyX] =
				grid[emptyY][emptyX], grid[newEmptyY][emptyX]
				riga=emptyX
				colonna=emptyY
				end
	--return false
end

Runtime:addEventListener( "key", onKeyEvent )

creaGriglia()


		


--randomizzare i numeri sui tasselli

--rendere spostabili i tasselli
--aggiungere sfondo