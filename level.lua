local storyboard = require "storyboard"

local levelList = {"level1", "level2", "level3"}

-- Set your current level, maybe with a button...
local currentLevel = levelList[1]

local options =
{
    effect = "slideLeft",
    time = 800,
    params = { levelSentToGame = currentLevel }
}

storyboard.gotoScene( "game", options )