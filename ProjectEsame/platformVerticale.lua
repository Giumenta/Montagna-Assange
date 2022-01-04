function createButtons() -- crea le frecce utili per sx/dx/jmp 
						-- non local in modo tale che i suoi valori possano essere 
	local control = display.newGroup() --crea il gruppo control, dove mette tutta la roba 

	local arrowUp = display.newImageRect(control, "\\risorseGrafiche\\risorseTmp_perTest\\arrows\arrowUp.png", 80, 80)
	arrowUp.name = "up"

	local arrowLeft = display.newImageRect(control, "\\risorseGrafiche\\risorseTmp_perTest\\arrows\arrowLeft.png", 80, 80)
	arrowLeft.name = "left"

	local arrowRight = display.newImageRect(control, "\\risorseGrafiche\\risorseTmp_perTest\\arrows\arrowRight.png", 80, 80)
	arrowRight.name = "right"

	return control
end


