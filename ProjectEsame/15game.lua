

local function creaGriglia() 
    local tasselli={}--dichiaro che tasselli è una tabella
    local larghezzaGriglia = display.contentHeight*0.9
    local griglia= display.newRect(display.contentCenterX,display.contentCenterY, larghezzaGriglia,larghezzaGriglia)
    local dimtassello= (display.contentHeight*0.88)/4
    local colonna=1
    local riga=1
    local spaziaturaTasselli=(larghezzaGriglia-display.contentHeight*0.88)/5
	
	local GRID_WIDTH = 4
	local GRID_HEIGHT = 4
  
  local grid = {} -- creo una griglia 4x4
		for  colonna = 1, GRID_HEIGHT do
			grid[colonna] = {}
				for riga = 1, GRID_WIDTH do
				grid[colonna][riga] = ((colonna - 1) * GRID_WIDTH) + riga
				end
    end

	
    --for riga=1, 4 do
        --for colonna=1,4 do
    for colonna=1,GRID_HEIGHT do
        
        for riga=1,GRID_WIDTH do
		
		   
        local tassello = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassellogioco15_stondato.jpg",dimtassello, dimtassello)
        tassello.anchorX=0
        tassello.anchorY=0
        tassello.y=display.contentHeight/2-(larghezzaGriglia)/2 + (riga-1)*dimtassello + riga*spaziaturaTasselli
        tassello.x=display.contentWidth/2-(larghezzaGriglia)/2 + (colonna-1)*dimtassello + colonna*spaziaturaTasselli
        
		
		
			local numeri = display.newText (
               ((riga - 1) * 4) + colonna,
			   --grid[colonna][riga];
                (riga - 1) * dimtassello,
                (colonna - 1) * dimtassello, native.systemFont, 70
            )
			--numeri:setFillColor( 1, 1, 1 ) --dovrebbere essere giusto ma non va
		numeri.anchorX=0
        numeri.anchorY=0
		numeri.y=display.contentHeight/2-(larghezzaGriglia)/2 + (riga-1)*dimtassello + riga*spaziaturaTasselli
        numeri.x=display.contentWidth/2-(larghezzaGriglia)/2 + (colonna-1)*dimtassello + colonna*spaziaturaTasselli
		
		end
		
    end
end


creaGriglia()
--legare i numeri ai tasselli
--randomizzare i numeri sui tasselli
--eliminare il 16° tassello
--rendere spostabili i tasselli
--aggiungere sfondo