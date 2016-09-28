-----------------------------------------------------------------------------------------
--
-- game.lua
-- Background graphic from http://opengameart.org/content/starfield-background, courtesy of Sauer2
-- Monkey, enemy, and bullet graphics are from http://www.vickiwenderlich.com/2013/05/free-game-art-space-monkey/
--
-----------------------------------------------------------------------------------------

-- Require in some of Corona's 
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()

local numberOfLives = 3
local bulletSpeed = 0.35
local badGuyMovementSpeed = 1500
local badGuyCreationSpeed = 1000

-- forward declarations and other locals
local background, tmr_createBadGuy, monkey, bullet, txt_score
local tmr_createBadGuy
local lives = {}
local badGuy = {}
local badGuyCounter = 1
local score = 0

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view	

local circle = display.newImage('exorcist.png')
physics.addBody(circle,{radius = 40})

local floor = display.newRect(0,300,768,4)
physics.addBody(floor,'static')

for i = 0,3 do
    local rect = display.newImage('block1.png')
	rect.x = 800
	rect.y = 220 + i*120
	physics.addBody(rect)
end

local function onTouch(event)
     if event.phase == 'began' then
	     display.getCurrentStage():setFocus(circle)
	 elseif event.phase == 'ended'then
	      circle:applyLinearImpulse(event.xStart - event.x, event.yStart - event.y,circle.x,circle.y)
		  
		  display.getCurrentStage():setFocus(nil)
	 end
end
--circle:addEventListener('touch',onTouch)
	
end

function scene:enterScene( event )
	local group = self.view

	-- Actually start the game!	
	physics.start()
	circle:addEventListener('touch',onTouch)
	--tmr_createBadGuy = timer.performWithDelay(badGuyCreationSpeed, createBadGuy, 0)
	--background:addEventListener("touch", touched)
	--Runtime:addEventListener( "collision", onCollision )
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )

return scene