
local storyboard = require("storyboard")
local scene=storyboard.newScene()
local physics=require("physics")
physics.start()

local score = 0


function scene:createScene(event)
local group=self.view
local assetGroup = display.newGroup( )

local background = display.newImageRect("images/background2.png", 480, 320)
		background.x = halfW
		background.y = halfH
		group:insert(background)
		

local floor = display.newRect(0,300,1000,4)
physics.addBody(floor,'static')

txt_score = display.newText("Score: "..score,0,0,native.systemFont,22)
		txt_score.x = 430
		group:insert(txt_score)

local fsm2 = require("fsm2")

happywallState = {}
sadwallState = {}
deadwallState={}


function happywallState:enter (owner)
	local function Wallcollision(event)		
		if (owner.name =="wall" and event.other.name == "bird" )   then				
				owner.health=owner.health-8*event.force
				score = score + 1
				txt_score.text = "Score: "..score
				if (owner.health<1.5) then
					owner.fsm2:changeState(sadwallState)
				end
				owner:removeEventListener("touch", owner )				
				event.other:removeEventListener("touch",event.other)	
		end			
	end
	owner:addEventListener("postCollision", Wallcollision)
end



function happywallState:exit ( owner )

end

function happywallState:execute ( owner )
end

function sadwallState:enter ( owner )
	owner:setFrame(2)
	
	if ( owner.health<0.5) then
	
		owner.fsm2:changeState(deadwallState)
	end
end

function sadwallState:exit ( owner )
	return true
end

function sadwallState:execute ( owner )	
end
     

function deadwallState:enter ( owner )
	owner:removeSelf()
	
end

function deadwallState:exit ( owner )
	return true
end

function deadwallState:execute ( owner )
end

	 
function creatwall(x, y)
	
	local wallsheet = graphics.newImageSheet( "stonewall.png", {width=16,height=70, numFrames=2 } )
	local wall = display.newSprite(wallsheet, {name="wall",start=1,count=2,time =100,loopCount=1, loopDirection="forward"} )
	wall.x = x
	wall.y = y
	wall.name="wall"
	wall.health = 2
	wall.fsm2 = fsm2.new(wall)
	wall.fsm2:changeState(happywallState)
	return wall
end
		   
local wall1 = creatwall(300,264)
local wall2 = creatwall(360,264)
local wall3 = display.newImage("beam.png",330,210)
wall3.rotation = 90
--wall3.name= "wall"
local wall4 = creatwall(430,264)
local wall5 = display.newImage("beam.png",400,210)
wall5.rotation =90
group:insert(wall1)
group:insert(wall2)
group:insert(wall3)
group:insert(wall4)
group:insert(wall5)

physics.addBody(wall1)
physics.addBody(wall2)
physics.addBody(wall3)	
physics.addBody(wall4)
physics.addBody(wall5)


happypigState = {}
sadpigState = {}
deadpigState={}


function happypigState:enter (owner)
	local function Pigcollision(event)		
		if (owner.name =="pig" and event.other.name == "bird" ) or (owner.name == "pig" and  event.other.name == "wall") then				
				owner.health=owner.health-5*event.force
		
				if (owner.health<1.5) then
					owner.fsm2:changeState(sadpigState)
					Runtime:removeEventListener("bird","wall",sadpigState)
					--display.removeall()
					
				end
			

				owner:removeEventListener("touch", owner )				
				event.other:removeEventListener("touch",event.other)	
		end			
	end
	owner:addEventListener("postCollision", Pigcollision)
end

function happypigState:exit ( owner )

end

function happypigState:execute ( owner )
end

function sadpigState:enter ( owner )
	owner:setFrame(2)
	
	if ( owner.health<0.5) then
	owner.fsm2:changeState(deadpigState)
	end
end

function sadpigState:exit ( owner )
	return true
end

function sadpigState:execute ( owner )
end


function deadpigState:enter ( owner )
	owner:removeSelf()
	background:removeSelf()
storyboard.gotoScene( "tolevel3" )
end

function deadpigState:exit ( owner )

	return true
end

function deadpigState:execute ( owner )
end

function makepig(x,y)
	local pigsheet = graphics.newImageSheet( "pig.png",{width=48, height=48,numFrames=2})	
	local pig =display.newSprite(pigsheet,{name="pig", start=1,count=2,time=100, loopCount=1, loopDirection="forward"})	
	pig.x=x
	pig.y=y
	pig.health=3
	pig.name="pig"
	pig.fsm2=fsm2.new(pig)
	pig.fsm2:changeState(happypigState)
	return pig
end	



local pig1=makepig(340,280)
physics.addBody(pig1)
pig1.name=("pig")
group:insert(pig1)

local pig2=makepig(400,280)
physics.addBody(pig2)
pig2.name=("pig")
group:insert(pig2)


local bird=display.newImage("redbird.png",60,275,{density=5, friction=5,bounce=0.2, rotation=0})

bird.name="bird"
physics.addBody(bird)
group:insert(bird)

local function onTouched(event)
		if event.phase =="began" then
			display.getCurrentStage():setFocus(bird)
		elseif event.phase=="ended" then
		bird:applyLinearImpulse((event.xStart-event.x)/200,(event.yStart-event.y)/200,bird.x,bird.y)
		display.getCurrentStage():setFocus(nil)
		
		end
end	
bird:setLinearVelocity( 4, 4 )	
bird:addEventListener("touch",onTouched)


local bird2=display.newImage("yellowbird.png",20,275,{density=5, friction=5,bounce=0.2, rotation=0})
bird2.name="bird"
physics.addBody(bird2)
group:insert(bird2)


local function onTouched2(event)

		if event.phase =="began" then
			display.getCurrentStage():setFocus(bird2)
		elseif event.phase=="ended" then
		
		
		bird2:applyLinearImpulse((event.xStart-event.x)/200,(event.yStart-event.y)/200,bird2.x,bird2.y)
		display.getCurrentStage():setFocus(nil)
		
		end
end		
bird2:addEventListener("touch",onTouched2)

end


scene:addEventListener("createScene",scene)
return scene


