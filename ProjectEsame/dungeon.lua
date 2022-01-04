local camera= display.newGroup()
local control = display.newGroup()

local arrowLeft = display.newImageRect(control,"risorseTmp_perTest/arrows/arrowLeft.png",80,80)
arrowLeft.x = 100
arrowLeft.y = display.contentCenterY
arrowLeft.name = "left"

local arrowRight = display.newImageRect(control,"risorseTmp_perTest/arrows/arrowRight.png",80,80)
arrowRight.x = display.contentWidth-100
arrowRight.y = display.contentCenterY
arrowRight.name = "right"

local arrowUp = display.newImageRect(control,"risorseTmp_perTest/arrows/arrowUp.png",80,80)
arrowLeft.x = 100
arrowLeft.y = display.contentCenterY
arrowLeft.name = "up"

local arrowDown = display.newImageRect(control,"risorseTmp_perTest/arrows/arrowDown.png",80,80)
arrowLeft.x = 100
arrowLeft.y = display.contentCenterY
arrowLeft.name = "down"

local button = display.newImageRect(control, "risorseTmp_perTest/arrows/redButton.png",80,80)
button.x
button.y
button.name = "button"