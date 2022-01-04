-- create group for non fixed obj (camera) and for fixed obj(control)
local camera= display.newGroup()
local control = display.newGroup()

-- create obj arrows and button for interaction
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
button.x =display.contentCenterX
button.y = display.contentCenterX
button.name = "button"

-- add event to arrows and button
arrowLeft:addEventListener("touch", movePg)
arrowRight:addEventListener("touch", movePg)
arrowDown:addEventListener("touch", movePg)
arrowUp:addEventListener("touch", movePg)
