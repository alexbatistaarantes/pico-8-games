gravity=0.2

function update_bird(act)
    act = act or "fall"
    if(act=="hit") then
        bird.sprite=bird_dead
        sfx(2)
    else
        if(act=="fly") then
            bird.vector-=bird.strength
            sfx(1)
        elseif(act=="fall") then bird.vector+=gravity
        --elseif(act=="dash") then -- increase speed momentarily maybe
        end
        bird.y+=bird.vector
        
        if(bird.vector<0) then bird.sprite=bird_flying
        else bird.sprite=bird_falling end
    end
end

function draw_bird()
    sspr(bird.sprite[1],bird.sprite[2],bird.size[1],bird.size[2],bird.x, bird.y)
end

function init_bird()
    bird={
        ["x"]=30,
        ["y"]=60,
        ["speed"]=2,
        ["strength"]=4,
        ["sprite"]="fall",
        ["vector"]=0,
        ["size"]={8,8}
    }

    -- sprites and sound {x,y}
    bird_flying={0,0}
    bird_falling={1*bird.size[1],0}
    bird_dead={2*bird.size[1],0}
end
