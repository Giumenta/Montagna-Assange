-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--//yooo

-- PARTE DI CODICE PER IL PLATFORM VERTICALE (3 LIVELLO)
-- fromVeeko says: non so di preciso come fare a testare la roba, quindi linko qua il file che sto iniziando a
-- fare e vedo di farlo funzionare. Commento il resto del codice e prima di finire dovrei ricordarmi sempre di 
-- scommentarlo, però ehi non escludo di essere studpido e dimenticarmi di farlo quindi cheers non prendetevela	
require "dungeon"
--require "platformVerticale" --dovrebbe richiamare il file creato

local control = display.newGroup()
local createdButtons = false
control = createButtons() --richiamo la funzione presente in platformVerticale, mezzo test che funga tutto
print(control.arrowUp)
-- local arrowUp = display.newImageRect("arrowUp.png", 80, 80)
-- local arrowUp = display.newText("10", 100, 200, native.systemFont, 100)
--[[arrowUp.x = display.contentWidth-100
arrowUp.y = display.contentCenterY
arrowUp.name = "up" --]]


--FINE PARTE PROVA CODICE PLATFORM VERTICALE (3 LIVELLO)