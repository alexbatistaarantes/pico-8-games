function check_hit()
    for i=0,bird.size[1]-1 do
        if(kv[i+bird.x][1]>=bird.y or kv[i+bird.x][2]<=bird.y+bird.size[2])
        then return true end
    end
    return false
end

function update_game()
    if(not game_over) then
        if(check_hit()) then
            update_bird("hit")
            game_over=true
        else
            if(btnp(2) or btnp(4) or btnp(5)) then -- up, x, c
                update_bird("fly")
            else
                update_bird()
            end
            update_kv(bird.speed)
            score+=bird.speed
        end
    else
        if(btnp(5)) then
            _init()
        end
    end
end

function draw_game()
    draw_kv()
    draw_bird()
    if(game_over) then
        print("score: "..score, 5, 56, 2)
        print("press ❎ to replay", 5, 65, 2)
    end
end

function init_game()
    game_over=false
    score=0
    init_kv()
    init_bird()
end
