maps={
    ["cwall"]={4,12},
    
    ["y"]=0,
    ["speed"]=5,
    ["cx"]=13,["cy"]=0, --sprites top left
    ["cw"]=8,["ch"]=16, --cells width and height
}

notification_bar=3*8
notification={
    ['frames']=0,['sprite']=0,['msg']="",
    ["cx"]=13,["cy"]=17,
    ["cw"]=16,["ch"]=3
}

fall_speed=3
items_loop=4*fall_speed -- frames to generate new item
items_loop_count=1 -- counter to complete loop
chance_item=60 --%
chance_block=90 --%

function update_game()
    if(game_over) then
        if(btnp(5)) init_game() -- reset game after game over
        return false
    end

    if(items_loop_count==items_loop) then
        if(rnd(100)<=chance_item) new_items_at_y(128, maps.cwall[1]*8, maps.cwall[2]*8, chance_block)
        items_loop_count=0
    end
    items_loop_count+=1
    move_items_up(fall_speed)

    update_hernique(maps.cwall[1]*8, maps.cwall[2]*8)
    score.distance+=1
    check_hit()
end

function check_hit()
    for i=#items,1,-1 do
        local item = items[i]
        if(
            (hrq.y+7>=item.y and hrq.y+7<item.y+7) and
            (hrq.x>item.x and hrq.x-item.x<=4 or item.x>hrq.x and item.x-hrq.x<=4)
        ) then
            if(item.type=="b") then sfx(1) game_over=true
            else
                eat()
                sfx(0)
                score.snacks[item.key]+=1
                notification.frames=3*30
                notification.sprite=item.sprite
                notification.msg=snacks[item.key].msg
                del(items, items[i])
            end
        end
    end
end

function draw_game()
    if(game_over) then draw_game_over_screen() return false end

    cls(1)
    
    -- maps.y+(maps.ch*8) é o final do desenho do mapa
    if(maps.y+(maps.ch*8)<0) maps.y=0
    map(maps.cx,maps.cy,flr((128-maps.cw*8)/2),maps.y,maps.cw,maps.ch)
    map(maps.cx,maps.cy,flr((128-maps.cw*8)/2),maps.y+(maps.ch*8),maps.cw,maps.ch)
    maps.y-=maps.speed

    draw_items()
    draw_hernique()

    --score
    print(score.distance,100,120)
    if(notification.frames>0) then
        map(notification.cx,notification.cy,0,0,notification.cw,notification.ch)
        print(notification.msg,(128-(#notification.msg*4))/2,(notification.ch*8/2)-2)
        notification.frames-=1
    end
end

function init_game()
    game_over=false
    
    score={
        ['distance']=0,
    }
    score['snacks']={}
    for i=1,#snacks do add(score['snacks'],0) end

    init_hernique(notification.ch*8+8)
end

function draw_game_over_screen()
    local go_screen={
        ["cx"]=29,["cy"]=0,
        ["cw"]=7,["ch"]=8,
    }
    local t="perdeu tudo"
    local instruction="aperte x para jogar de novo"
    
    cls(0)
    
    -- sprite: 8x8
    -- letras do print: 3x5

    local y=3
    local x=(128-(#t*4))/2
    print(t,x,y)

    x=(127-go_screen.cw*8)/2
    y+=5+3
    map(go_screen.cx,go_screen.cy,x,y,go_screen.cw,go_screen.ch)
    
    x=(127-12*3)/2
    y+=3 + go_screen.ch*8
    print("score: "..score.distance,x,y)

    -- y no meio entre instruction e score
    x=(128-#snacks*(10+3*3))/2
    y=y+((120-y)/2)-5
    for i=1,#snacks do
        spr(snacks[i].sprite,x,y)
        x+=10
        print("x"..score.snacks[i],x,y)
        x+=3*3+2
    end
    y+=8+3

    print(instruction,(128-(#instruction*4))/2,120)
end
