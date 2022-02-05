-- library to specify functionality of our hero (aka the penguin)
local M={}



-- BEGIN INSERT CODE
-- audioData are stored in the audioData module
-- import the audioData module
   --local audioData=require("audioData")
-- END INSERT CODE

-- The module function creates hero and handles his/her collisions with other game objects
function M.new()
   -- Begin data for the penguin sprite 
   local opt = { width = 32, height = 32, numFrames = 12}
   local heroSheet = graphics.newImageSheet("risorseGrafiche/PG/sprite-sheet.png",opt)

   local heroSeqs ={{
		name = "Front",
		start = 1,
		count = 3,
		time = 300,
		loopCount = 0,
		loopDirection ="forward"
	},
	{
		name = "Left",
		start = 4,
		count = 6,
		time = 300,
		loopCount = 0,
		loopDirection ="forward"
	},
	{
		name = "Right",
		start = 7,
		count = 9,
		time = 300,
		loopCount = 0,
		loopDirection ="forward"
	},
	{
		name = "Back",
		start = 10,
		count = 12,
		time = 300,
		loopCount = 0,
		loopDirection ="forward"
	}
  }

    -- end data for the penguin sprite

    -- define and postion hero sprite		  
    local hero = display.newSprite(heroSheet,heroSeqs)
  

    -- define hero physics body
    local heroShape={-6,0,6,0,-6,16,6,16}
    
	-- 1) add a dynamic, anaelastic physics body to hero  
	physics.addBody(hero,"dynamic", {shape=heroShape, bounce=0,density=1.5})
    -- 2) Make hero a display object not affected by off-balance rotations
    hero.isFixedRotation=true

	




	
	-- on precollison disable the collision between hero and ladderEnd
	-- to allow hero to pass through the final part of the ladder
	
	---NON SERVE---

	--local function onPreCollision(self,event)
	--	local heroBottom = self.y+16
	--	local collidedObj=event.other
	--	local collidedObjTop = collidedObj.y-collidedObj.height/2
	 
	--	if (collidedObj.type == "ladderEnd" ) then	
	--		if (heroBottom >= collidedObjTop) then
	--	       event.contact.isEnabled = false  --disable this specific collision   		
	--		end	  
	--	end
	--end








	
	-- Function onCollision is the local collision handler attached to hero. 
	-- It controls collision between hero and
	-- 1. the evil cat (when this collision occurs, we stop the music, hero animationam physics,
	--    and we play the evil sfx)
	-- 2. an egg (if collision is with an egg, we make the egg invisible and play the bonus sfx)
	-- 3. the exit door (if collision is with the door, we stop bgMusic, pause hero animation and physics,
	--    and play the exit sfx) 
	-- 4. barriers (when this kind of collision is recognized, hero movement is inverted automatically)
	-- 5. platform (this collision is used to allow jumps only when hero is touching the top edge
	--              of a platform. We use the variables collidedObjTop and heroBottom to check
	--              this last condition. When this is the case, we also guarantee that hero is moving
	--              by setting his linear velocity)
	-- 6. ladderStart (when hero collides with the beginning of the ladder, we stop hero horizontal speed, we apply a vertical force to hero to make him climb up the ladder, and we set
	-- the flag hero.isOnLadder to true. We also play the ladder sound and we change the hero sprite
	-- animation sequence to climbUp)

	-- Note that when hero ended to climb up the ladder (i.e., collision hero-ladderEnd ends)
	-- we change the hero animation sequence to walk and we apply a non-zero horizontal speed to hero
	-- (i.e., we make hero walking again)
	-- Also, when a collision hero-platform ends, hero is falling or jumping, hence new jumps are not 
	-- allowed.
	-- Finally, note that when collision hero-egg terminates, we remove the egg from the device memory. 

	local function onCollision(self,event)
		local collidedObj = event.other
		local collidedObjTop= collidedObj.y-collidedObj.height/2
		local heroBottom=hero.y+16
	
	
		--when a collision between hero and another objects starts...
		if event.phase=="began" then
			print("CollidedObj start:"..collidedObj.type)
			-- Collision hero-cat
			if collidedObj.name == "enemy" then
				--BEGIN INSERT CODE
				-- 1) pause the background music
				audio.pause(audioData.bgMusic)
				-- 2) play the evil sound fx
				audio.play(audioData.soundTable.evil)
				-- 3) set the animation sequence  of self (i.e. the hero) to "die"
				hero:setSequence("die")
				-- 4) reproduce the animation sequence
				hero:play()
				-- 5) remove the tapListener controlHero (used to control the hero movements)
				Runtime:removeEventListener("tap", controlHero)
				-- 6) pause the physics
				physics.pause()
				--END INSERT CODE
			end	
			-- Collision hero-door
			if collidedObj.name == "ladder" then
				--BEGIN INSERT CODE
				-- 1) pause the background music
				audio.pause(audioData.bgMusic)
				-- 2) play the exit sound fx
				audio.play(audioData.soundTable.exit)
				-- 3) pause the hero sprite animation
				hero:pause()
				-- 4) remove the tapListener controlHero (used to control the hero movements)
				Runtime:removeEventListener("tap", controlHero)
				-- 5) pause the physics
				physics.pause()
				--END INSERT CODE
			end	 
			-- Collision hero-egg
			if collidedObj.name == "door" then
				--BEGIN INSERT CODE
				-- 1) make the collided egg invisible
				self.isVisible=false
				-- 2) play the bonus sound fx
				audio.play(audioData.soundTable.bonus)
				--END INSERT CODE
			end		
			-- Collision hero-ladderStart 	 
			if collidedObj.type=="ladderStart" then
				--BEGIN INSERT CODE
				--1) set isOnLadder field of self to true (i.e. the hero is on the ladder)
				self.isOnLadder=true
				--2) set the hero animation sequence to climbUp 
				self:setSequence("climbUp")
				--3) play the animation sequence
				self:play()
				--4) stop the hero by setting to 0 its linear velocity
				self:setLinearVelocity(0,0)
				--5) move the hero up through the ladder using the following transition
				transition.moveTo(self,{y=self.y-(32*collidedObj.ladderLength),time=800})
				--6) play the ladder soundFx
				audio.play(audioData.soundTable.ladder)
				--END INSERT CODE 	
			end
		    		
	     end
		 -- when the collision between hero and the end of the ladder ends, hero starts walking again
		 -- and jumps are forbidden
		 if event.phase=="ended" then
			 print("CollidedObj end:"..collidedObj.type)
			 if collidedObj.name=="ladderEnd" then
				 hero.isOnLadder = false
				 self.jumpAllowed = false
				 self:setSequence("walk")
				 self:play()
				 self:setLinearVelocity(self.speedDir*self.speed,0)	 
		 -- when collision between hero and platform ends, hero is jumping or falling,
		 -- hence we disable jumps. 	 
			 elseif collidedObj.type == "platform" then
					 self.jumpAllowed = false	 		
			end		 
		 end	 
	end
	-- define precollision and collision handlers for hero	
	hero.preCollision=onPreCollision
	hero.collision = onCollision
	
	return hero
end	  






-- The init function initializes the following hero parameters:
--  xStart,yStart: initial position of hero at the beginning of the execution.
--  speed: hero velocity (measured in pixel/seconds)
--  speedDir: initial direction (1 = right, -1 = left)
--  jumpAllowed: boolean value that establishes if jumps are initially allowed
--  isOnLadder: boolean value that indicates if the initial hero position is on the ladder
function M.init(hero,xStart,yStart, isOnLadder)
	-- initial hero position
    hero.x=xStart
    hero.y=yStart

    -- initial hero speed (px/s) and speed direction  (1= right, -1=left) 
    hero.speedDir=speedDir
    hero.speed=speed
	
	-- is initially hero on a ladder? (true or false)
	hero.isOnLadder=isOnLadder 
	
end	








-- the activate function starts the movements of hero and its precollision and collision listeners
function M.activate(hero)
	--BEGIN INSERT CODE
	--1) set the hero animation sequendce to walk
	hero:setSequence("walk")
	--2) play the animation sequence
	hero:play()
	--3) set hero linear velocity to (hero.speedDir*hero.speed,0)
	hero:setLinearVelocity(hero.speedDir*hero.speed,0)
	--4) activate the precollision and collision listeners on hero.
	hero:addEventListener("precollision",hero)
	hero:addEventListener("collision",hero)
	--END INSERT CODE
end

return M