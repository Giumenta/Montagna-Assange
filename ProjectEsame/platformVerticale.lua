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



