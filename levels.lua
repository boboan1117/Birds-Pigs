-----------------------------------------------------------------------------------------
--
-- levels.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )

local scene = storyboard.newScene()



-- Called when the scene's view does not exist:
function scene:createScene(event)

	local group =self.view
	
	
		-----------------------------------------------------------------------------------------
 	local lvlPrompt = display.newText ("Pick a Level", 240, 40, font, 32)
 	local lvl01 = display.newText ("Level 1", 240, 90, font, 28)
 	local lvl02 = display.newText ("Level 2", 240, 140, font, 28)
 	local lvl03 = display.newText ("Level 3", 240, 190, font, 28)
 	
	local background = display.newImageRect("images/background.png", 480, 320)
		background.x = halfW
		background.y = halfH
		group:insert(background)
	
	
	lvl01.ID = 1
 	lvl02.ID = 2
 	lvl03.ID = 3
 	group:insert (lvlPrompt)
 	group:insert (lvl01)
 	group:insert (lvl02)
 	group:insert (lvl03)
 	-----------------------------------------------------------------------------------------
 	local function lvlListener (event)
 		if (event.phase == "began") then
 			if (event.target.ID == 1) then
 				levelSelector = 1
				print("load game 1")
 				storyboard.gotoScene ("my level1-new")
 			elseif (event.target.ID == 2) then
				print("load game 2")
 				levelSelector = 2
 				storyboard.gotoScene ("my level2")
 			elseif (event.target.ID == 3) then
 				levelSelector = 3
 				storyboard.gotoScene ("my level3")
 			end
 		end
 	end
 	lvl01:addEventListener ("touch", lvlListener)
 	lvl02:addEventListener ("touch", lvlListener)
 	lvl03:addEventListener ("touch", lvlListener)
 	---------------------------------------------------------------
	
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene