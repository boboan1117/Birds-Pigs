local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local physics = require ("physics")
physics.start();

local background
local score = 0
local bugnum=1


function scene:createScene( event )
	local group = self.view	
	local game = display.newGroup()
	
	local floor = display.newRect(0,300,1000,4)
	physics.addBody(floor,'static')


	
	local background = display.newImageRect("images/background1.png", 480, 320)
		background.x = halfW
		background.y = halfH
		group:insert(background)
		
	local circle = display.newImage('pidgin_24.png')
	circle.x = 80
    circle.y = 275
	circle.name="circle"
    physics.addBody(circle, "dynamic", {density = 4.0, friction = 6.3, bounce = 0.03})
	
	local circle1 = display.newImage('pidgin_24.png')
	circle1.x = 40
    circle1.y = 275
	circle1.name="circle"
    physics.addBody(circle1, "dynamic", {density = 4.0, friction = 6.3, bounce = 0.03})
	
	txt_score = display.newText("Score: "..score,0,0,native.systemFont,22)
		txt_score.x = 430
		group:insert(txt_score)
		
	
	local wall01=display.newImage("shortwall.png",375,264,{density=4.0, friction=1, bounce=0.2 })
	physics.addBody(wall01)
	wall01.name="wall"
	wall01.collision=onCollision
	wall01:addEventListener("collision",wall01)
	wall01 = crash.newAnim{ "shortwall.png","beam.png" }
	game:insert(wall01)
	
	local wall02=display.newImage("shortwall.png",425,264,{density=4.0, friction=1, bounce=0.2 })
	wall02.name="wall"
	physics.addBody(wall02)
	wall02.collision=onCollision
	wall02:addEventListener("collision",wall02)


    local wall03=display.newImage("beam.png",400,220,{density=12.0, friction=0.3, bounce=0.4})
	wall03.name="wall"
    wall03.rotation=90
	physics.addBody(wall03)
	wall03.collision=onCollision
	wall03:addEventListener("collision",wall03)
	
	
	local bug=display.newImage("bug_24.png",400,275,{density=1.0, friction=0.1, bounce=0.5, radius=25})
	physics.addBody(bug)
	bug.name=("bug")
	bug.collision=onCollision
	bug:addEventListener("collision",bug)
	

 local function onCollision( event )		
		if((event.object1.name=="wall" and event.object2.name=="bug") or 
		(event.object1.name=="wall" and event.object2.name=="circle")) then
			event.object1:removeSelf()
			event.object1.myName=nil
			event.object2:removeSelf()
			event.object2.myName=nil
			score = score + 1
			bugnum = bugnum -1
			txt_score.text = "Score: "..score
			print (bugnum)

			end
	end
	
	function circleTouched(event) 
	if event.phase =="began" then 
		display.getCurrentStage():setFocus(circle)
		return true
	elseif event.phase =="ended" then 
		
		display.getCurrentStage():setFocus(nil)
		circle:applyLinearImpulse(event.xStart - event.x, event.yStart - event.y, circle.x, circle.y)
	end
end
	function circleTouched1(event)
	if event.phase =="began" then 
		display.getCurrentStage():setFocus(circle1)
		return true
	elseif event.phase =="ended" then 
		
		display.getCurrentStage():setFocus(nil)
		circle1:applyLinearImpulse(event.xStart - event.x, event.yStart - event.y, circle1.x, circle1.y)
	end
end

function nextlevel()

if (event.bugnum == 0) then
storyboard.gotoScene("my level2")
end
end


circle:addEventListener("touch", circleTouched)
circle1:addEventListener("touch", circleTouched1)
Runtime:addEventListener("collision" , onCollision)
end

function scene:enterScene( event )
	local group = self.view

	physics.start()

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )

return scene