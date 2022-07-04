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
     local larghezzaGriglia = display.contentHeight*0.9
    local griglia= display.newRect(display.contentCenterX,display.contentCenterY, larghezzaGriglia,larghezzaGriglia)
	local background = display.newImageRect( "risorseGrafiche/montagnaGenericoAmbiente/sfondogioco15.jpg", larghezzaGriglia,larghezzaGriglia)
    background.x = display.contentCenterX
	background.y = display.contentCenterY
	local dimtassello= (display.contentHeight*0.88)/4
    local colonna=1
    local riga=1
    local spaziaturaTasselli=(larghezzaGriglia-display.contentHeight*0.88)/5
	grid[1][1] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[2][1] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[3][1] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[4][1] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[1][2] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[2][2] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[3][2] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[4][2] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[1][3] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[2][3] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[3][3] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[4][3] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[1][4] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[2][4] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	grid[3][4] = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassello1.png",dimtassello, dimtassello )
	
	 for colonna=1,4 do
        
        for riga=1,4 do
			if grid[colonna][riga] ~= 4*4 then -- rimuovo 16° tassello
				local tassello = grid[colonna][riga]
				tassello.anchorX=0
				tassello.anchorY=0
				tassello.y=display.contentHeight/2-(larghezzaGriglia)/2 + (riga-1)*dimtassello + riga*spaziaturaTasselli
				tassello.x=display.contentWidth/2-(larghezzaGriglia)/2 + (colonna-1)*dimtassello + colonna*spaziaturaTasselli
				
			end
		end
	end
end
--creo una funzione per verificare la posizione di un tassello libero
local function onKeyEvent (event)
 
end

Runtime:addEventListener( "key", onKeyEvent )

creaGriglia()


		


--randomizzare i numeri sui tasselli

--rendere spostabili i tasselli
--aggiungere sfondo