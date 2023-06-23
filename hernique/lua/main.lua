function _update()
    if(state=='p') then update_game()
    else --menu
        if(btnp(5)) then
            state="p"
            init_game()
        end
    end
end

function _draw()
    if(state=="p") draw_game()
end

function _init()
    state="m"
    draw_menu()
end

function draw_menu()
    local stream={
        ["cx"]=0,["cy"]=0,
        ["cw"]=13,["ch"]=7,
    }
    stream["y"]=flr((128-stream.ch*8)/2)

    local title="hernique stream videogame"
    local instruction="aperte x para iniciar"
    
    cls(1)
    
    --title
    print(title,flr((128-(#title*4))/2),stream.y-10)
    
    --draw
    palt(0,false)
    map(stream.cx,stream.cy,flr((128-stream.cw*8)/2),stream.y,stream.cw,stream.ch)
    palt(0,true)
    
    --instruction
    print(instruction,flr((128-(#instruction*4))/2),stream.y+stream.ch*8+5)
end
