function createButtons() -- crea le frecce utili per sx/dx/jmp 
						-- non local in modo tale che i suoi valori possano essere 
	-- local control = display.newGroup() --crea il gruppo control, dove mette tutta la roba 
	control = {}
	local allArrows = display.newGroup()
	local arrowUp = display.newImageRect(allArrows, "/risorseGrafiche/risorseTmp_perTest/arrows/arrowUp.png", 100, 100)
	arrowUp.name = "up"
	arrowUp.x = 500
	arrowUp.y = 525

	local arrowLeft = display.newImageRect(allArrows, "/risorseGrafiche/risorseTmp_perTest/arrows/arrowLeft.png",100, 100)
	arrowLeft.name = "left"
	arrowLeft.x = 425
	arrowLeft.y = 600

	local arrowRight = display.newImageRect(allArrows, "/risorseGrafiche/risorseTmp_perTest/arrows/arrowRight.png", 100, 100)
	arrowRight.name = "right"
	arrowRight.x = 575
	arrowRight.y = 600
	
	table.insert(control, allArrows)
	table.insert(control, arrowUp)
	table.insert(control, arrowLeft)
	table.insert(control, arrowRight)
	

	return control
end

local control = display.newGroup()

control = createButtons() --richiamo la funzione presente in platformVerticale, mezzo test che funga tutto
print(control)
local prova = display.newImageRect("/risorseGrafiche/risorseTmp_perTest/arrows/arrowUp.png", 80, 80)
-- local arrowUp = display.newText("10", 100, 200, native.systemFont, 100)
--[[arrowUp.x = display.contentWidth-100
arrowUp.y = display.contentCenterY
arrowUp.name = "up" --]]

print(prova)


