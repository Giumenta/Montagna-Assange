

local function creaGriglia() 
    local tasselli={}--dichiaro che tasselli è una tabella
    local larghezzaGriglia = display.contentHeight*0.9
    local griglia= display.newRect(display.contentCenterX,display.contentCenterY, larghezzaGriglia,larghezzaGriglia)
    local dimtassello= (display.contentHeight*0.88)/4
    local colonna=1
    local riga=1
    local spaziaturaTasselli=(larghezzaGriglia-display.contentHeight*0.88)/5
    for riga=1, 4 do
        for colonna=1,4 do
        local tassello = display.newImageRect("risorseGrafiche/montagnaGenericoAmbiente/tassellogioco15_stondato.jpg",dimtassello, dimtassello)
        tassello.anchorX=0
        tassello.anchorY=0
        tassello.y=display.contentHeight/2-(larghezzaGriglia)/2 + (riga-1)*dimtassello + riga*spaziaturaTasselli
        tassello.x=display.contentWidth/2-(larghezzaGriglia)/2 + (colonna-1)*dimtassello + colonna*spaziaturaTasselli
        
		
			local numeri = display.newText (
               ((colonna - 1) * 4) + riga,
                (riga - 1) * dimtassello,
                (colonna - 1) * dimtassello, native.systemFont, 55
            )
			--myText:setFillColor( 1, 0, 0 )
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