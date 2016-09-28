-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"
curLevel = 1
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view	

	-- Insert a background into the game
	local background = display.newImageRect("images/background.png", 480, 320)
		background.x = halfW
		background.y = halfH
		group:insert(background)

	-- Insert the game title
	local gameTitle = display.newText("Angry Birds",0,0,native.systemFontBold,32)
		gameTitle.x = halfW
		gameTitle.y = halfH - 80
		group:insert(gameTitle)

	local function onPlayBtnRelease()	
		storyboard.gotoScene( "levels", "fade", 500 )
		return true
	end

	-- Create a widget button that will let the player start the game
	local playBtn = widget.newButton{
		label="Start Now",
		onRelease = onPlayBtnRelease
	}
	playBtn.x = halfW
	playBtn.y = halfH
	group:insert( playBtn )
end

function scene:enterScene(event)
	local group = self.view

	if(storyboard.getPrevious() ~= nil) then
		storyboard.purgeScene(storyboard.getPrevious())
		storyboard.removeScene(storyboard.getPrevious())
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene