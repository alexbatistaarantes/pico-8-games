function eat()
    hrq.eat=true
    hrq.sprite_frame=0
end

function update_hernique(min_x, max_x)
    local move=0
    if(btn(0)) move=-hrq.speed
    if(btn(1)) move=hrq.speed
    
    hrq.x=mid(min_x,hrq.x+move,max_x-8)
end

function draw_hernique()
    spr(get_sprite(),hrq.x,hrq.y,1,1)
end

function get_sprite()
    local sprites=hrq.d_sprites
    if(hrq.eat) sprites=hrq.e_sprites

    local sprite=0
    for i=1,#sprites do
        if(hrq.sprite_frame<sprites[i][1]) then
            sprite=sprites[i][2]
            break
        end
    end

    hrq.sprite_frame+=1
    if(hrq.sprite_frame==sprites[#sprites][1]) then
        hrq.sprite_frame=0
        if(hrq.eat) hrq.eat=false
    end
    
    return sprite
end

function init_hernique(loc)
    hrq={
        ["x"]=56, ["y"]=loc,
        ["speed"]=1.5,
        
        --sprites
        ["d_sprites"]={{10,16},{20,17}}, -- {frame, sprite number}
        ["e_sprites"]={{10,19},{20,18}}, -- {frame, sprite number}
        ["sprite_frame"]=0,
        ["eat"]=false
    }
end
