snacks={
    [1]={["nome"]="maconha", ["sprite"]=11,["msg"]="*apenas tabaco ele diz*"}, --maconha
    [2]={["nome"]="comunismo", ["sprite"]=12,["msg"]="*converteu mais 1*"}, --foice e martelo
    [3]={["nome"]="dwarffortress", ["sprite"]=13,["msg"]="*defendeu gameplay de excel*"}, --dwarffortress
    [4]={["nome"]="timrogers", ["sprite"]=14,["msg"]="*assistiu 1 hora de tim rogers*"}, --tim rogers
    [5]={["nome"]="markfisher", ["sprite"]=15,["msg"]="*citou mark fisher*"}, --mark fisher
}
block_sprite=25 --block

items={}

function new_items_at_y(y, min, max, cb)
    -- at y, generate items
    local x = min + rnd(max-8-min)
    if(rnd(100)<=cb) then
        add(items, {['x']=x,['y']=y,['type']='b',['sprite']=block_sprite})
    else
        key=flr(rnd(#snacks))+1
        add(items, {['x']=x,['y']=y,['type']='s',['sprite']=snacks[key].sprite,['key']=key})
    end
end

function move_items_up(speed)
    -- for every item, decrease y, by speed
    for i=#items,1,-1 do
        items[i].y-=speed
        if(items[i].y+8<0) del(items, items[i]) -- saiu para fora da tela
    end
end

function draw_items()
    for i=1,#items do
        local item = items[i]
        spr(item.sprite,item.x,item.y)
    end
end
