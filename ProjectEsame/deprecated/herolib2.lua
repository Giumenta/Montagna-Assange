local M={}



-- just a function that allows to retrieve the hero object
-- from the map level passed as argument.
-- The function also redefines the physics body of the hero
function M.findHero(level)
    -- search the hero in the current level
    local hero = level:findObject("pg")

    physics.removeBody(hero)
    physics.addBody(hero,"dynamic",{radius=32,isSensor=true})

    -- associate with hero the enterFrame listener checkheroPos to check whether
    -- the  hero direction must be inverted and its image flipped
    -- horizontally. 
    hero.enterFrame=checkheroPosition

    return hero
end

-- this function sets the horizontal linear velocity of the enemy
-- and activate its listener checkheroPosition
function M.animate( enemy )
    -- start moving the enemy using setLinearVelocity
    enemy:setLinearVelocity(enemy.speedDir*enemy.speed,0)
    -- activate the enemy enterFrame listener to check its position 
    Runtime:addEventListener("enterFrame",enemy)
end

return M